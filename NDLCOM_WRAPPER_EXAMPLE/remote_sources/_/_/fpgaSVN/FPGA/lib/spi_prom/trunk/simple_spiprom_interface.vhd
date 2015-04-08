---------------------------------------------------------------------------------
--! @file simple_spiprom_interface.vhd
--!
--! @brief   This module allows page read/write and sector erase at an
--!          SPI EEPROM in 1bit mode.
--! @details This module is a simple interface of the access to an SPI
--!          EEPROM in 1bit mode.\n
--!          In this module only page read/write and sector erase operations
--!          are available. For more complex accesses please use the
--!          spi_prom implementation.\n
--!          This module uses two 256 byte buffers to store the data which
--!          should be send or is read from the device. The interface to these
--!          buffers is a normal dualport block ram interface. Because of the
--!          size of these buffers (the page size) a maximal amount of 256
--!          bytes could by read/written with one trigger. This constant amount
--!          of bytes can be configured down (!) with the DATA_LENGTH generic.
--!          To read/write different amounts of data is it easily possible to
--!          replace the DATA_LENGTH generic with an input signal.\n
--!          An example design could be found in the examples directory.\n\n
--!          German Research Center for Artificial Intelligence\n
--!          Project: iStruct
--!
--! @date   30.10.2012
--! @author Tobias Stark (tobias.stark@dfki.de)
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simple_spiprom_interface is
    generic ( CLK_FREQ     : natural := 20000000;             --! the system clock frequency
              SPI_CLK_FREQ : natural := 5000000;              --! the clk frequency for the eeprom (max. CLK_FREQ/4!)
              DATA_LENGTH  : natural := 256;                  --! the length of the data which should be read/written (max. 256)
              UNLOCK_KEY   : std_logic_vector(3 downto 0) := "1010" );  --! key to unlock the prom (has to be the same as key_input to access the prom))
    
    port ( CLK            : in  std_logic;                     --! the system clock
           RST            : in  std_logic;                     --! the system reset

           -- lines to the spi prom
           SPI_nCS       : out std_logic;                      --! chip select signal to the prom
           SPI_CLK       : out std_logic;                      --! clock signal to the prom
           SPI_DO        : out std_logic;                      --! data line to the prom
           SPI_DI        : in  std_logic;                      --! data line from the prom

           -- control signals
           key_input     : in  std_logic_vector(3 downto 0);   --! key to unlock the prom (has to be the same as UNLOCK_KEY to access the prom)
           erase_trigger : in  std_logic;                      --! signal to trigger a sector erase
           write_trigger : in  std_logic;                      --! signal to trigger a page write
           read_trigger  : in  std_logic;                      --! signal to trigger a page read
           prom_busy     : out std_logic;                      --! '1' if the prom is busy
           address       : in  std_logic_vector(23 downto 0);  --! the address where the data should be read/written

           -- interface to the page buffers
           din_offset    : in  std_logic_vector(7 downto 0);   --! the offset of the data in buffer
           din           : in  std_logic_vector(7 downto 0);   --! the data to write into the data in buffer
           din_we        : in  std_logic;                      --! write enable of the data in buffer
           dout_offset   : in  std_logic_vector(7 downto 0);   --! the offset of the data out buffer
           dout          : out std_logic_vector(7 downto 0) ); --! the data to read from the data out buffer
end simple_spiprom_interface;

architecture Behavioral of simple_spiprom_interface is

    constant MAX_CLK_COUNTER  : integer := (CLK_FREQ + 2*SPI_CLK_FREQ)/(2*SPI_CLK_FREQ);

    constant WRITE_ENABLE         : std_logic_vector(7 downto 0) := x"06";  -- WREN
    constant SECTOR_ERASE         : std_logic_vector(7 downto 0) := x"d8";  -- SE
    constant WRITE_PAGE           : std_logic_vector(7 downto 0) := x"02";  -- PP
    constant READ_PAGE            : std_logic_vector(7 downto 0) := x"03";  -- READ
    constant READ_STATUS_REGISTER : std_logic_vector(7 downto 0) := x"05";  -- RDSR
    
    signal read_buffer_we       : std_logic;
    signal read_buffer_addr_in  : std_logic_vector(7 downto 0);
    signal read_buffer_data_in  : std_logic_vector(7 downto 0);

    signal write_buffer_addr_out : std_logic_vector(7 downto 0);
    signal write_buffer_data_out : std_logic_vector(7 downto 0);

    signal ncs_int       : std_logic;
    signal sclk_int      : std_logic;
    signal sclk_rising   : std_logic;
    signal sclk_falling  : std_logic;
    signal prom_busy_int : std_logic;

    type signal_states is (idle, write_en, send_cmd, send_addr,
                           send_data, recv_data, release_cs);
    signal signal_state : signal_states;

    signal cmd_byte : std_logic_vector(7 downto 0);

begin

    SPI_CLK <= sclk_int;
    SPI_nCS <= ncs_int;

    prom_busy <= prom_busy_int or erase_trigger or write_trigger or read_trigger;

    -- buffer to store data which was read
    -- from the prom
    read_buffer : entity work.bram_dp_simple
        generic map ( ADDRWIDTH => 8,
                      DATAWIDTH => 8 )
        port map ( clk   => CLK,
                   we    => read_buffer_we,
                   waddr => read_buffer_addr_in,
                   wdata => read_buffer_data_in,
                   raddr => dout_offset,
                   rdata => dout );

    -- buffer to store data which should be
    -- written to the prom
    write_buffer : entity work.bram_dp_simple
        generic map ( ADDRWIDTH => 8,
                      DATAWIDTH => 8 )
        port map ( clk   => CLK,
                   we    => din_we,
                   waddr => din_offset,
                   wdata => din,
                   raddr => write_buffer_addr_out,
                   rdata => write_buffer_data_out );

    -- Process to generate the spi clock as well as signals
    -- for rising and falling edges of the spi clock.
    clock_generator : process (CLK)
        variable counter : integer range 0 to MAX_CLK_COUNTER;
    begin
        if CLK'event and CLK='1' then
            if RST='1' then
                counter      := 0;
                sclk_rising  <= '0';
                sclk_falling <= '0';
                sclk_int     <= '0';
            else
                -- defaults
                sclk_rising  <= '0';
                sclk_falling <= '0';

                if counter < MAX_CLK_COUNTER-1 then
                    counter := counter + 1;
                else
                    counter := 0;
                    sclk_int <= not sclk_int;
                    if sclk_int='0' then
                        sclk_rising  <= '1';
                    else
                        sclk_falling <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- This process handles all the communication
    -- with the spi prom.
    signal_handler : process (CLK)
        variable idleFlag    : std_logic;
        variable bitCounter  : integer range 0 to 23;
        variable byteCounter : integer range 0 to 255;
        variable byteBuffer  : std_logic_vector(7 downto 0);
    begin
        if CLK'event and CLK='1' then
            if RST='1' then
                idleFlag    := '0';
                bitCounter  := 0;
                byteCounter := 0;
                byteBuffer  := (others => '0');

                ncs_int <= '1';
                SPI_DO  <= '0';

                cmd_byte <= (others => '0');
                read_buffer_we <= '0';
                
                signal_state <= idle;
            else
                -- defaults
                read_buffer_we <= '0';

                case signal_state is

                    when idle =>
                        -- wait for a trigger signal to start
                        -- a communication sequece
                        bitCounter := 0;
                        prom_busy_int <= '0';
                        if erase_trigger='1' and key_input=UNLOCK_KEY then
                            prom_busy_int    <= '1';
                            cmd_byte     <= SECTOR_ERASE;
                            signal_state <= write_en;
                        elsif write_trigger='1' and key_input=UNLOCK_KEY then
                            prom_busy_int    <= '1';
                            cmd_byte     <= WRITE_PAGE;
                            signal_state <= write_en;
                        elsif read_trigger='1' and key_input=UNLOCK_KEY then
                            prom_busy_int    <= '1';
                            cmd_byte     <= READ_PAGE;
                            signal_state <= send_cmd;
                        end if;

                    when write_en =>
                        -- send the write enable sequence
                        if sclk_falling='1' then
                            if bitCounter < 8 then
                                ncs_int      <= '0';
                                SPI_DO       <= WRITE_ENABLE(7-bitCounter);
                                bitCounter   := bitCounter + 1;
                                signal_state <= write_en;
                            else
                                ncs_int      <= '1';
                                bitCounter   := 0;
                                signal_state <= send_cmd;
                            end if;
                        end if;

                    when send_cmd =>
                        -- send a command
                        if sclk_falling='1' then
                            ncs_int <= '0';
                            SPI_DO  <= cmd_byte(7-bitCounter);
                            if bitCounter < 7 then
                                bitCounter := bitCounter + 1;
                                signal_state <= send_cmd;
                            else
                                bitCounter := 0;
                                byteCounter := 0;
                                if cmd_byte /= READ_STATUS_REGISTER then
                                    -- now we can send the address
                                    signal_state <= send_addr;
                                else
                                    -- read status -> now we can read the status
                                    signal_state <= recv_data;
                                end if;
                            end if;
                        end if;

                    when send_addr =>
                        -- send the 24bit address
                        if sclk_falling='1' then
                            ncs_int <= '0';
                            SPI_DO  <= address(23-bitCounter);
                            if bitCounter < 23 then
                                bitCounter := bitCounter + 1;
                                signal_state <= send_addr;
                            else
                                bitCounter  := 0;
                                byteCounter := 0;
                                if cmd_byte = WRITE_PAGE then
                                    -- now we can send the data
                                    write_buffer_addr_out <= (others => '0');
                                    signal_state <= send_data;
                                elsif cmd_byte = READ_PAGE then
                                    -- now we can receive the data
                                    idleFlag := '1';
                                    signal_state <= recv_data;
                                else
                                    -- sector erase -> now polling prom status
                                    cmd_byte <= READ_STATUS_REGISTER;
                                    signal_state <= release_cs;
                                end if;
                            end if;
                        end if;

                    when send_data =>
                        -- send DATA_LENGTH bytes of data
                        if sclk_falling='1' then
                            ncs_int <= '0';
                            SPI_DO <= write_buffer_data_out(7-bitCounter);
                            if bitCounter<7 then
                                bitCounter := bitCounter + 1;
                                signal_state <= send_data;
                            else
                                bitCounter := 0;
                                if byteCounter < DATA_LENGTH-1 then
                                    byteCounter := byteCounter + 1;
                                    write_buffer_addr_out <= std_logic_vector(to_unsigned(byteCounter,8));
                                    signal_state <= send_data;
                                else
                                    -- finished -> now polling prom status
                                    byteCounter := 0;
                                    cmd_byte <= READ_STATUS_REGISTER;
                                    signal_state <= release_cs;
                                end if;
                            end if;
                        end if;

                    when recv_data =>
                        -- receiving DATA_LENGTH bytes of data
                        if sclk_rising='1' then
                            if idleFlag='1' then
                                -- here we have to wait one cycle
                                -- to get the correct edge
                                idleFlag := '0';
                            else
                                ncs_int <= '0';
                                byteBuffer(7-bitCounter) := SPI_DI;
                                if bitCounter < 7 then
                                    bitCounter := bitCounter + 1;
                                    signal_state <= recv_data;
                                else
                                    bitCounter := 0;
                                    if cmd_byte /= READ_STATUS_REGISTER then
                                        read_buffer_addr_in <= std_logic_vector(to_unsigned(byteCounter,8));
                                        read_buffer_data_in <= byteBuffer;
                                        read_buffer_we <= '1';
                                        if byteCounter < DATA_LENGTH-1 then
                                            byteCounter := byteCounter + 1;
                                            signal_state <= recv_data;
                                        else
                                            -- finished -> release cs and then idle
                                            byteCounter := 0;
                                            signal_state <= release_cs;
                                        end if;
                                    else
                                        if byteBuffer(0)='0' then
                                            -- finished (prom ready again) -> release cs and then idle
                                            cmd_byte <= (others => '0');
                                            signal_state <= release_cs;
                                        else
                                            signal_state <= recv_data;
                                        end if;
                                    end if;
                                end if;
                            end if;
                        end if;

                    when release_cs =>
                        -- release chip select (and idle for one cycle)
                        if sclk_falling='1' then
                            ncs_int <= '1';
                            if cmd_byte=READ_STATUS_REGISTER then
                                -- after releasing cs we can now start polling prom status
                                signal_state <= send_cmd;
                            else
                                -- finished !
                                signal_state <= idle;
                            end if;
                        end if;

                end case;

            end if;
        end if;
    end process;

end Behavioral;
