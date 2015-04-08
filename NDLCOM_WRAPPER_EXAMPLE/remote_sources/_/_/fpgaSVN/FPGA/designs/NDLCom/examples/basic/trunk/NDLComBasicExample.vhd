---------------------------------------------------------------------------------
--! @file    NDLComBasicExample.vhd
--! @class   NDLComBasicExample
--!
--! @brief   A basic example for the NDLCom library.
--! @details This is a basic example which demonstrates some functions of the
--!          NDLCom library like register access and in-system programming. This
--!          design is written for the BLDC-stack V3 and V4 (use the corresponding
--!          ucf-file).\n\n
--!          German Research Center for Artificial Intelligence\n
--!
--! @date   10.11.2014
--! @author Tobias Stark (tobias.stark@dfki.de)
---------------------------------------------------------------------------------
-- Last Commit: 
-- $LastChangedRevision: 3673 $
-- $LastChangedBy: tstark $
-- $LastChangedDate: 2014-11-28 14:25:04 +0100 (Fri, 28 Nov 2014) $
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.config.all;
use work.date.all;
use work.register_types.all;
use work.register_pack.all;
use work.deviceclasses.all;

entity NDLComBasicExample is
    port( CLK_IN      : in  std_logic;
          nRST_IN     : in  std_logic;
          LED         : out std_logic_vector(1 downto 0);
          
          -- pins for communication
          RX1         : in  std_logic;
          TX1         : out std_logic;
          RX2         : in  std_logic;
          TX2         : out std_logic;

          -- pins for SPIPROM
          PROM_nCS    : out std_logic;
          PROM_CLK    : out std_logic;
          PROM_nWP    : out std_logic;
          PROM_nHOLD  : out std_logic;
          PROM_MISO   : in  std_logic;
          PROM_MOSI   : out std_logic );
end NDLComBasicExample;

architecture Behavioral of NDLComBasicExample is
    
    alias clk : std_logic is CLK_IN;
    signal reset : std_logic;

    signal node_id : std_logic_vector(7 downto 0);
    signal enable  : std_logic;
    signal promInitDone : std_logic;

    signal resetDevice : std_logic;

    signal actualTime  : std_logic_vector(63 downto 0);

    signal telemetry   : TelemetryValues;

-------------- EEPROM Interface -------------------------------------------------

    signal writePromTrigger   : std_logic;

    signal prom_key_input     : std_logic_vector(3 downto 0);
    signal prom_erase_trigger : std_logic;
    signal prom_write_trigger : std_logic;
    signal prom_read_trigger  : std_logic;
    signal prom_busy          : std_logic;
    signal prom_address       : std_logic_vector(23 downto 0);
    signal prom_din_offset    : std_logic_vector(7 downto 0);
    signal prom_din           : std_logic_vector(7 downto 0);
    signal prom_din_we        : std_logic;
    signal prom_dout_offset   : std_logic_vector(7 downto 0);
    signal prom_dout          : std_logic_vector(7 downto 0);

    signal reg_prom_request       : std_logic;
    signal reg_prom_access        : std_logic;
    signal reg_prom_key_input     : std_logic_vector(3 downto 0);
    signal reg_prom_erase_trigger : std_logic;
    signal reg_prom_write_trigger : std_logic;
    signal reg_prom_read_trigger  : std_logic;
    signal reg_prom_address       : std_logic_vector(23 downto 0);
    signal reg_prom_din_offset    : std_logic_vector(7 downto 0);
    signal reg_prom_din           : std_logic_vector(7 downto 0);
    signal reg_prom_din_we        : std_logic;
    signal reg_prom_dout_offset   : std_logic_vector(7 downto 0);

    signal isp_prom_request       : std_logic;
    signal isp_prom_access        : std_logic;
    signal isp_prom_key_input     : std_logic_vector(3 downto 0);
    signal isp_prom_erase_trigger : std_logic;
    signal isp_prom_write_trigger : std_logic;
    signal isp_prom_read_trigger  : std_logic;
    signal isp_prom_address       : std_logic_vector(23 downto 0);
    signal isp_prom_din_offset    : std_logic_vector(6 downto 0);
    signal isp_prom_din           : std_logic_vector(7 downto 0);
    signal isp_prom_din_we        : std_logic;
    signal isp_prom_dout_offset   : std_logic_vector(6 downto 0);
    
-------------- Register ---------------------------------------------------------

    -- data structure to store register
    signal register_memory : registermemory_t;

    signal reg_busy       : std_logic;
    signal reg_read_id    : std_logic_vector(15 downto 0);
    signal reg_read_type  : registertype_t;
    signal reg_read_data  : std_logic_vector(63 downto 0);
    signal reg_read       : std_logic;
    signal reg_read_ack   : std_logic;
    signal reg_write_id   : std_logic_vector(15 downto 0);
    signal reg_write_type : registertype_t;
    signal reg_write_data : std_logic_vector(63 downto 0);
    signal reg_write      : std_logic;

-------------- ISP signals ------------------------------------------------------

    signal isp_cmd_upload     : std_logic;
    signal isp_cmd_data       : std_logic;
    signal isp_cmd_download   : std_logic;
    signal isp_cmd_ack        : std_logic;
    signal isp_din_addr       : std_logic_vector(31 downto 0);
    signal isp_din_len        : std_logic_vector(31 downto 0);
    signal isp_din            : std_logic_vector(7 downto 0);
    signal isp_din_valid      : std_logic;
    signal isp_din_ack        : std_logic;
    signal isp_dout_addr      : std_logic_vector(31 downto 0);
    signal isp_dout           : std_logic_vector(7 downto 0);
    signal isp_dout_valid     : std_logic;
    signal isp_dout_ack       : std_logic;

begin

    reset <= not nRST_IN;

    LED(0) <= enable;
    LED(1) <= prom_busy;

--    device_reconf : entity work.device_reconf_spartan6(Behavioral)
--        port map ( clk => clk,
--                   rst => reset,
--                   reconf_trigger => resetDevice );

    rtc_inst : entity work.rtc_mod(Behavioral)
        generic map ( SYSTEM_speed => CLK_FREQ )
        port map ( CLK => clk,
                   RST => reset,
                   actualTime => actualTime,
                   setNewTime => '0',
                   newTime    => (others => '0') );

    NDLCom_wrapper : entity work.NDLCom_wrapper
        generic map ( CLK_FREQ      => CLK_FREQ,
                      BAUD_RATE     => BAUD_RATE )
        port map ( CLK      => clk,
                   RST      => reset,
                   NODE_ID  => x"0a", --node_id,

                   RX1 => RX1,
                   TX1 => TX1,
                   RX2 => RX2,
                   TX2 => TX2,
                   
                   rtc_actual_time  => actualTime,
                   telemetry_values => telemetry,
                   resetDevice      => resetDevice,

                   reg_read_id    => reg_read_id,
                   reg_read_type  => reg_read_type,
                   reg_read_data  => reg_read_data,
                   reg_read       => reg_read,
                   reg_read_ack   => reg_read_ack,
                   reg_write_id   => reg_write_id,
                   reg_write_type => reg_write_type,
                   reg_write_data => reg_write_data,
                   reg_write      => reg_write,
                   
                   isp_cmd_upload   => isp_cmd_upload,
                   isp_cmd_data     => isp_cmd_data,
                   isp_cmd_download => isp_cmd_download,
                   isp_cmd_ack      => isp_cmd_ack,
                   isp_din_addr     => isp_din_addr,
                   isp_din_len      => isp_din_len,
                   isp_din          => isp_din,
                   isp_din_valid    => isp_din_valid,
                   isp_din_ack      => isp_din_ack,
                   isp_dout_addr    => isp_dout_addr,
                   isp_dout         => isp_dout,
                   isp_dout_valid   => isp_dout_valid,
                   isp_dout_ack     => isp_dout_ack,

                   commErr => open );

    comm_proc : process (clk)
        variable oldWritePromState : std_logic;
        variable newWritePromState : std_logic;
        variable writePromTrigger_pending : std_logic;
    begin
        if clk'event and clk='1' then
            if reset='1' then
                node_id <= (others => '0');
                enable  <= '0';
                writePromTrigger  <= '0';
                oldWritePromState := '0';
                newWritePromState := '0';
                writePromTrigger_pending := '0';
            else
                -- defaults
                writePromTrigger <= '0';

                node_id <= get_register(register_memory,NDLCom_NODE_ID);

                newWritePromState := get_register(register_memory,BLDCJoint_CONFIG)(BLDCJoint_CONFIG_WRITE_SETTINGS_BIT);
                if newWritePromState='1' and oldWritePromState='0' then
                    writePromTrigger_pending := '1';
                end if;
                oldWritePromState := newWritePromState;

                if writePromTrigger_pending='1' and reg_busy='0' then
                    writePromTrigger  <= '1';
                    writePromTrigger_pending := '0';
                end if;

                enable <= get_register(register_memory,BLDCJoint_CONFIG)(BLDCJoint_CONFIG_ENABLE_CMD_BIT);

                -- state
                telemetry(0) <= get_register(register_memory,BLDCJoint_STATE);

                -- error
                telemetry(1) <= (others => '0');

                -- warning
                telemetry(2) <= (others => '0');

            end if;
        end if;
    end process;
    
    
    -- --------------------------------------------------------------------------
    --                        SPI-PROM Access
    -- --------------------------------------------------------------------------
    
    -- instantiation of the simple spiprom interface
    spiprom_inst : entity work.simple_spiprom_interface(Behavioral)
        generic map ( CLK_FREQ     => CLK_FREQ,
                      SPI_CLK_FREQ => 5000000,
                      DATA_LENGTH  => 128 )
        port map ( CLK => clk,
                   RST => reset,

                   SPI_nCS   => PROM_nCS,
                   SPI_CLK   => PROM_CLK,
                   SPI_DO    => PROM_MOSI,
                   SPI_DI    => PROM_MISO,

                   key_input     => prom_key_input,
                   erase_trigger => prom_erase_trigger,
                   write_trigger => prom_write_trigger,
                   read_trigger  => prom_read_trigger,
                   prom_busy     => prom_busy,
                   address       => prom_address,

                   -- interface to the page buffers
                   din_we        => prom_din_we,
                   din_offset    => prom_din_offset,
                   din           => prom_din,
                   dout_offset   => prom_dout_offset,
                   dout          => prom_dout );

    PROM_nHOLD <= '1';
    PROM_nWP   <= '1';

    prom_access_handler : process (clk)
    begin
        if clk'event and clk='1' then
            if reset='1' then
                reg_prom_access <= '0';
                isp_prom_access <= '0';
            else
                if reg_prom_request='1' and isp_prom_access='0' then
                    reg_prom_access <= '1';
                elsif isp_prom_request='1' and reg_prom_access='0' then
                    isp_prom_access <= '1';
                else
                    reg_prom_access <= '0';
                    isp_prom_access <= '0';
                end if;
            end if;
        end if;
    end process;

    prom_key_input     <= reg_prom_key_input when reg_prom_access='1' else
                          isp_prom_key_input when isp_prom_access='1' else
                          (others => '0');
    prom_erase_trigger <= reg_prom_erase_trigger when reg_prom_access='1' else
                          isp_prom_erase_trigger when isp_prom_access='1' else
                          '0';
    prom_write_trigger <= reg_prom_write_trigger when reg_prom_access='1' else
                          isp_prom_write_trigger when isp_prom_access='1' else
                          '0';
    prom_read_trigger <= reg_prom_read_trigger when reg_prom_access='1' else
                         isp_prom_read_trigger when isp_prom_access='1' else
                         '0';
    prom_address <= reg_prom_address when reg_prom_access='1' else
                    isp_prom_address when isp_prom_access='1' else
                    (others => '0');
    prom_din_we <= reg_prom_din_we when reg_prom_access='1' else
                   isp_prom_din_we when isp_prom_access='1' else
                   '0';
    prom_din_offset <= reg_prom_din_offset when reg_prom_access='1' else
                       '0' & isp_prom_din_offset when isp_prom_access='1' else
                       (others => '0');
    prom_din <= reg_prom_din when reg_prom_access='1' else
                isp_prom_din when isp_prom_access='1' else
                (others => '0');
    prom_dout_offset <= reg_prom_dout_offset when reg_prom_access='1' else
                        '0' & isp_prom_dout_offset when isp_prom_access='1' else
                        (others => '0');

    
    -- --------------------------------------------------------------------------
    --                        Register Access
    -- --------------------------------------------------------------------------

    roRegisterHandler : process (clk)
    begin
        if clk'event and clk='1' then
            if reset='1' then
                register_memory.ro_registers <= (others => (others => '0'));
            else

                set_ro_register(register_memory, FPGAJoint_SYNTHESIS_YEAR,  SYNTHESIS_YEAR);
                set_ro_register(register_memory, FPGAJoint_SYNTHESIS_MONTH, SYNTHESIS_MONTH);
                set_ro_register(register_memory, FPGAJoint_SYNTHESIS_DAY,   SYNTHESIS_DAY);
                set_ro_register(register_memory, FPGAJoint_SYNTHESIS_AUTHOR,SYNTHESIS_AUTHOR);

                set_ro_register(register_memory, BLDCJoint_STACK_VERSION, std_logic_vector(to_unsigned(STACK_VERSION,8)));

                -- state register
                set_ro_registerbit(register_memory,BLDCJoint_STATE,BLDCJoint_STATE_ENABLE_BIT,enable);
                
            end if;
        end if;
    end process;

    register_access : entity work.register_access
        port map ( clk => clk,
                   rst => reset,

                   register_memory => register_memory,

                   busy       => reg_busy,
                   init_done  => promInitDone,
                   write_prom => writePromTrigger,

                   reg_read_id    => reg_read_id,
                   reg_read_type  => reg_read_type,
                   reg_read_data  => reg_read_data,
                   reg_read       => reg_read,
                   reg_read_ack   => reg_read_ack,
                   reg_write_id   => reg_write_id,
                   reg_write_type => reg_write_type,
                   reg_write_data => reg_write_data,
                   reg_write      => reg_write,

                   prom_request     => reg_prom_request,
                   prom_access      => reg_prom_access,
                   prom_key_input   => reg_prom_key_input,
                   prom_read_trigger  => reg_prom_read_trigger,
                   prom_erase_trigger => reg_prom_erase_trigger,
                   prom_write_trigger => reg_prom_write_trigger,
                   prom_busy        => prom_busy,
                   prom_address     => reg_prom_address,
                   prom_din_offset  => reg_prom_din_offset,
                   prom_din         => reg_prom_din,
                   prom_din_we      => reg_prom_din_we,
                   prom_dout_offset => reg_prom_dout_offset,
                   prom_dout        => prom_dout );

    -- --------------------------------------------------------------------------
    --                     In-System Programming
    -- --------------------------------------------------------------------------

    isp : entity work.InSystemProgramming
        port map ( clk => clk,
                   rst => reset,

                   cmd_upload   => isp_cmd_upload,
                   cmd_data     => isp_cmd_data,
                   cmd_download => isp_cmd_download,
                   cmd_ack      => isp_cmd_ack,
                   din_addr     => isp_din_addr,
                   din_len      => isp_din_len,
                   din          => isp_din,
                   din_valid    => isp_din_valid,
                   din_ack      => isp_din_ack,
                   dout_addr    => isp_dout_addr,
                   dout         => isp_dout,
                   dout_valid   => isp_dout_valid,
                   dout_ack     => isp_dout_ack,

                   prom_request     => isp_prom_request,
                   prom_access      => isp_prom_access,
                   prom_key_input   => isp_prom_key_input,
                   prom_read_trigger  => isp_prom_read_trigger,
                   prom_erase_trigger => isp_prom_erase_trigger,
                   prom_write_trigger => isp_prom_write_trigger,
                   prom_busy        => prom_busy,
                   prom_address     => isp_prom_address,
                   prom_din_offset  => isp_prom_din_offset,
                   prom_din         => isp_prom_din,
                   prom_din_we      => isp_prom_din_we,
                   prom_dout_offset => isp_prom_dout_offset,
                   prom_dout        => prom_dout );

end Behavioral;

