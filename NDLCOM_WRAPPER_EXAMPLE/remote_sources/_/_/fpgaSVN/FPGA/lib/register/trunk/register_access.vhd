---------------------------------------------------------------------------------
--! @file register_access.vhd
--!
--! @brief  register access module
--! @author Tobias Stark (tobias.stark@dfki.de)
--! @date   29.10.2014
--!
--! This module provides the register access functionality that comes
--! with the NDLCom framework (read/write register).\n
--! It also provides a prom-connection to read/write prom registers
--! from/to it.\n\n
--! German Research Center for Artificial Intelligence\n
--!
--! $LastChangedRevision: 3668 $
--! $LastChangedBy: tstark $
--! $LastChangedDate: 2014-11-28 13:31:09 +0100 (Fri, 28 Nov 2014) $
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.config.all;
use work.register_types.all;
use work.register_pack.all;
use work.devices.all;

entity register_access is
    port ( clk : in std_logic;
           rst : in std_logic;

           register_memory : inout registermemory_t;  --! the type where the registers are stored

           busy       : out std_logic;  --! busy status signal
           init_done  : out std_logic;  --! init done status signal
           write_prom : in  std_logic;  --! write prom trigger

           -- signals to access the registers
           -- (ro-registers have to be set via the
           -- set_ro_* functions from register_pack)
           reg_read_id    : in  std_logic_vector(15 downto 0);
           reg_read_type  : out registertype_t;
           reg_read_data  : out std_logic_vector(63 downto 0);
           reg_read       : in  std_logic;
           reg_read_ack   : out std_logic;
           reg_write_id   : in  std_logic_vector(15 downto 0);
           reg_write_type : in  registertype_t;
           reg_write_data : in  std_logic_vector(63 downto 0);
           reg_write      : in  std_logic;
           
           -- signals to be connected with the prom
           -- (e.g. simple_spiprom_interface)
           prom_request     : out std_logic;
           prom_access      : in  std_logic;
           prom_key_input   : out std_logic_vector(3 downto 0);
           prom_read_trigger  : out std_logic;
           prom_erase_trigger : out std_logic;
           prom_write_trigger : out std_logic;
           prom_busy        : in  std_logic;
           prom_address     : out std_logic_vector(23 downto 0);
           prom_din_offset  : out std_logic_vector(7 downto 0);
           prom_din         : out std_logic_vector(7 downto 0);
           prom_din_we      : out std_logic;
           prom_dout_offset : out std_logic_vector(7 downto 0);
           prom_dout        : in  std_logic_vector(7 downto 0);

           debug1 : out std_logic_vector(15 downto 0);
           debug2 : out std_logic_vector(15 downto 0);
           debug3 : out std_logic_vector(15 downto 0) );
end register_access;

architecture Behavioral of register_access is

    type regAccessStates is (idle, readRegister, writeRegister,
                             initPromRegister_find, initPromRegister_read,
                             writePromRegister_find, writePromRegister_write,
                             waitProm);
    signal regAccessState : regAccessStates;
    
    signal reg_addr       : integer range 0 to 65535;
    signal reg_mem_type   : reg_mem_type_t;
    signal reg_len        : integer range 0 to 8;
    
-------------- EEPROM Interface -------------------------------------------------

    signal write_data : std_logic_vector(63 downto 0);
    signal busy_int      : std_logic;
    signal init_done_int : std_logic;
    signal prom_din_offset_int  : std_logic_vector(7 downto 0);
    signal prom_dout_offset_int : std_logic_vector(7 downto 0);
    
begin

    busy      <= busy_int or reg_read or reg_write or write_prom or not init_done_int;
    init_done <= init_done_int;
    prom_din_offset  <= prom_din_offset_int;
    prom_dout_offset <= prom_dout_offset_int;
    
    registerAccessHandler : process (clk)
        variable idleFlag       : std_logic;
        variable waitPromAccess : std_logic;
        variable reg_index      : integer range MIN_REGISTER_ID to MAX_REGISTER_ID+1;
        variable mem_offset     : integer range 0 to 8;
    begin
        if clk'event and clk='1' then
            if rst='1' then
                idleFlag       := '0';
                waitPromAccess := '0';
                reg_index      := MIN_REGISTER_ID;
                mem_offset     := 0;
                reg_addr       <= 0;
                reg_len        <= 0;
                write_data     <= (others => '0');

                register_memory.prom_registers <= (others => (others => '0'));
                register_memory.ram_registers  <= (others => (others => '0'));
                register_memory.tmp_reg_id     <= MAX_REGISTER_ID+1;  -- invalid register id
                register_memory.tmp_reg        <= (others => '0');
                
                reg_read_data <= (others => '0');
                reg_read_ack  <= '0';

                prom_request         <= '0';
                prom_key_input       <= (others => '0');
                prom_erase_trigger   <= '0';
                prom_write_trigger   <= '0';
                prom_read_trigger    <= '0';
                prom_address         <= (others => '0');
                prom_din_we          <= '0';
                prom_din_offset_int  <= (others => '0');
                prom_din             <= (others => '0');
                prom_dout_offset_int <= (others => '0');

                busy_int      <= '0';
                init_done_int <= '0';

                debug1 <= (others => '0');
                regAccessState <= idle;
            else
                -- defaults
                reg_read_ack <= '0';
                prom_erase_trigger <= '0';
                prom_write_trigger <= '0';
                prom_read_trigger  <= '0';
                prom_din_we        <= '0';

                if idleFlag='1' then
                    idleFlag := '0';
                    
                elsif waitPromAccess='1' then
                    debug1(3 downto 0) <= "1111";
                    -- wait till we can access the prom
                    if prom_access='1' and prom_busy='0' then
                        waitPromAccess  := '0';
                        if regAccessState = writePromRegister_find then
                            prom_key_input     <= "1010";
                            prom_address       <= PROM_CONFIG_BASE;
                            prom_din_offset_int <= (others => '1');
                            prom_erase_trigger <= '1';
                        else
                            prom_key_input    <= "1010";
                            prom_address      <= PROM_CONFIG_BASE;
                            prom_dout_offset_int <= (others => '0');
                            prom_read_trigger <= '1';
                        end if;
                    end if;
                else
                    
                    case regAccessState is

                        when idle =>
                            busy_int <= '0';
                            prom_key_input <= (others => '0');
                            prom_request   <= '0';
                            
                            if init_done_int='0' then
                                debug1(3 downto 0) <= "0001";
                                busy_int       <= '1';
                                prom_request   <= '1';
                                waitPromAccess := '1';
                                reg_index      := MIN_REGISTER_ID;
                                reg_mem_type   <= REGISTER_MEM_TYPES(reg_index);
                                regAccessState <= initPromRegister_find;
                                
                            elsif write_prom='1' then
                                debug1(3 downto 0) <= "0010";
                                busy_int       <= '1';
                                prom_request   <= '1';
                                waitPromAccess := '1';
                                reg_index      := MIN_REGISTER_ID;
                                reg_mem_type   <= REGISTER_MEM_TYPES(reg_index);
                                regAccessState <= writePromRegister_find;
                                
                            elsif reg_read='1' then
                                busy_int       <= '1';
                                mem_offset     := 0;
                                reg_addr       <= REGISTER_MEMORY_MAP(to_integer(unsigned(reg_read_id)));
                                reg_mem_type   <= REGISTER_MEM_TYPES(to_integer(unsigned(reg_read_id)));
                                reg_len        <= registertype2len(REGISTER_TYPES(to_integer(unsigned(reg_read_id))));
                                regAccessState <= readRegister;

                            elsif reg_write='1' then
                                -- TODO: check types (received and xml)
                                busy_int       <= '1';
                                mem_offset     := 0;
                                reg_addr       <= REGISTER_MEMORY_MAP(to_integer(unsigned(reg_write_id)));
                                reg_mem_type   <= REGISTER_MEM_TYPES(to_integer(unsigned(reg_write_id)));
                                reg_len        <= registertype2len(REGISTER_TYPES(to_integer(unsigned(reg_write_id))));
                                write_data     <= reg_write_data;

                                if to_integer(unsigned(reg_write_id)) >= MIN_REGISTER_ID and
                                    to_integer(unsigned(reg_write_id)) <= MAX_REGISTER_ID then
                                    -- set the tmp_reg to the new data so that reads during
                                    -- register writes can read valid data from here
                                    register_memory.tmp_reg_id <= to_integer(unsigned(reg_write_id));
                                    register_memory.tmp_reg    <= reg_write_data;
                                    regAccessState <= writeRegister;
                                else
                                    regAccessState <= idle;
                                end if;

                            end if;
                            
                        when readRegister =>
                            debug1(3 downto 0) <= "0011";
                            debug2 <= std_logic_vector(to_unsigned(reg_len,6)) & reg_read_id(9 downto 0);
                            debug3 <= std_logic_vector(to_unsigned(reg_addr,16));
                            
                            case reg_mem_type is
                                when prom =>
                                    reg_read_data(mem_offset*8+7 downto mem_offset*8) <= register_memory.prom_registers(reg_addr+mem_offset);
                                when ram =>
                                    reg_read_data(mem_offset*8+7 downto mem_offset*8) <= register_memory.ram_registers(reg_addr+mem_offset);
                                when ro =>
                                    reg_read_data(mem_offset*8+7 downto mem_offset*8) <= register_memory.ro_registers(reg_addr+mem_offset);
                                when others =>
                                    reg_read_data <= (others => '0');
                            end case;

                            mem_offset := mem_offset+1;
                            if mem_offset < reg_len then
                                regAccessState <= readRegister;
                            else
                                if to_integer(unsigned(reg_read_id)) >= MIN_REGISTER_ID and
                                    to_integer(unsigned(reg_read_id)) <= MAX_REGISTER_ID then
                                    reg_read_type <= REGISTER_TYPES(to_integer(unsigned(reg_read_id)));
                                else
                                    reg_read_type <= ERROR;
                                end if;
                                reg_read_ack   <= '1';
                                regAccessState <= idle;
                            end if;
                                
                        when writeRegister =>
                            debug1(3 downto 0) <= "0100";
                            debug2 <= std_logic_vector(to_unsigned(reg_len,6)) & reg_write_id(9 downto 0);
                            debug3 <= std_logic_vector(to_unsigned(reg_addr,16));

                            case reg_mem_type is
                                when prom =>
                                    register_memory.prom_registers(reg_addr+mem_offset) <= write_data(mem_offset*8+7 downto mem_offset*8);
                                when ram =>
                                    register_memory.ram_registers(reg_addr+mem_offset) <= write_data(mem_offset*8+7 downto mem_offset*8);
                                when others =>
                            end case;

                            mem_offset := mem_offset + 1;
                            if mem_offset < reg_len then
                                regAccessState <= writeRegister;
                            else
                                -- let point the tmp_reg_id to MAX_REGISTE_ID+1 (invalid register id)
                                -- to indicate that no write is active
                                register_memory.tmp_reg_id <= MAX_REGISTER_ID+1;
                                regAccessState <= idle;
                            end if;

                        when initPromRegister_find =>
                            debug1(3 downto 0) <= "1000";
                            --if REGISTER_MEM_TYPES(reg_index) /= prom then TODO: warum geht das nicht (NODE_ID ist falsch)
                            if reg_mem_type /= prom then
                                if reg_index < MAX_REGISTER_ID then
                                    reg_index := reg_index + 1;
                                    reg_mem_type   <= REGISTER_MEM_TYPES(reg_index);
                                    regAccessState <= initPromRegister_find;
                                else
                                    init_done_int  <= '1';
                                    regAccessState <= idle;
                                end if;
                            else
                                mem_offset := 0;
                                reg_addr   <= REGISTER_MEMORY_MAP(reg_index);
                                reg_len    <= registertype2len(REGISTER_TYPES(reg_index));
                                regAccessState <= initPromRegister_read;
                            end if;

                        when initPromRegister_read =>
                            debug1(3 downto 0) <= "1001";
                            if prom_busy='0' then
                                register_memory.prom_registers(reg_addr+mem_offset) <= prom_dout;
                                prom_dout_offset_int <= std_logic_vector(unsigned(prom_dout_offset_int) + 1);
                                mem_offset := mem_offset + 1;
                                if mem_offset < reg_len then
                                    idleFlag := '1';
                                    regAccessState <= initPromRegister_read;
                                else
                                    reg_index := reg_index + 1;
                                    reg_mem_type   <= REGISTER_MEM_TYPES(reg_index);
                                    regAccessState <= initPromRegister_find;
                                end if;
                            end if;

                        when writePromRegister_find =>
                            debug1(3 downto 0) <= "1100";                            
                            --if REGISTER_MEM_TYPES(reg_index) /= prom then TODO: s.o.
                            if reg_mem_type /= prom then
                                if reg_index < MAX_REGISTER_ID then
                                    reg_index := reg_index + 1;
                                    reg_mem_type   <= REGISTER_MEM_TYPES(reg_index);
                                    regAccessState <= writePromRegister_find;
                                elsif prom_busy='0' then
                                    prom_key_input     <= "1010";
                                    prom_write_trigger <= '1';
                                    regAccessState <= waitProm;
                                end if;
                            else
                                mem_offset := 0;
                                reg_addr   <= REGISTER_MEMORY_MAP(reg_index);
                                reg_len    <= registertype2len(REGISTER_TYPES(reg_index));
                                regAccessState <= writePromRegister_write;
                            end if;

                        when writePromRegister_write =>
                            debug1(3 downto 0) <= "1101";
                            prom_din_offset_int <= std_logic_vector(unsigned(prom_din_offset_int) + 1);
                            prom_din     <= register_memory.prom_registers(reg_addr+mem_offset);
                            prom_din_we  <= '1';
                            mem_offset := mem_offset + 1;
                            if mem_offset < reg_len then
                                regAccessState <= writePromRegister_write;
                            else
                                reg_index := reg_index + 1;
                                reg_mem_type   <= REGISTER_MEM_TYPES(reg_index);
                                regAccessState <= writePromRegister_find;
                            end if;

                        when waitProm =>
                            debug1(3 downto 0) <= "1111";
                            if prom_busy='0' then
                                regAccessState <= idle;
                            end if;

                    end case;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
