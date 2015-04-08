---------------------------------------------------------------------------------
--! @file register_pack.vhd
--!
--! @brief  register package
--! @author Tobias Stark (tobias.stark@dfki.de)
--! @date   29.10.2014
--!
--! This package provides some functions to work with the registers.\n\n
--! German Research Center for Artificial Intelligence\n
--!
--! $LastChangedRevision: 3679 $
--! $LastChangedBy: tstark $
--! $LastChangedDate: 2014-12-08 11:35:35 +0100 (Mon, 08 Dec 2014) $
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.register_types.all;
use work.config.all;
use work.devices.all;
use work.deviceclasses.all;

package register_pack is

    -- type for the register memory of the different register types
    type registermemory_t is
    record
        prom_registers : reg_mem_array_t(PROM_REGISTER_MEMORY_SIZE-1 downto 0);
        ram_registers  : reg_mem_array_t(RAM_REGISTER_MEMORY_SIZE-1 downto 0);
        ro_registers   : reg_mem_array_t(RO_REGISTER_MEMORY_SIZE-1 downto 0);
        -- a temporary register to enable atomic writes
        -- (MAX_REGISTER_ID+1 indicates no write active)
        tmp_reg_id     : integer range MIN_REGISTER_ID to MAX_REGISTER_ID+1;
        tmp_reg        : std_logic_vector(63 downto 0);
    end record;

    -- -------------------- --
    -- conversion functions --
    -- -------------------- --

    -- registertype2enum returns the integer defined in the enum RepresentationsRegisterType
    -- in lib/representations/Register.h for a specific registertype
    function registertype2enum (constant reg_type : registertype_t) return std_logic_vector;

    -- enum2register is the inverse function for register2enum and returns the registertype_t
    -- as it is defined in the enum RepresentationsRegisterType in lib/representations/Register.h
    function enum2registertype (constant enum : std_logic_vector( 7 downto 0)) return registertype_t;

    -- registertye2len returns the byte-length of a specific registertype
    function registertype2len (constant reg_type : registertype_t) return natural;

    -- ---------------- --
    -- access functions --
    -- ---------------- --

    -- get_register returns the register with id reg_id (it could be 8,16,32 or 64 bit wide)
    function get_register (constant reg_mem : registermemory_t; constant reg_id : natural) return std_logic_vector;

    -- set_ro_register sets a ro register with value (it could be 8,16,32 or 64 bit wide)
    -- (for other register memory types you have to use the register_access process)
    procedure set_ro_register (signal reg_mem : inout registermemory_t; constant reg_id : natural; constant value : std_logic_vector);

    -- set_ro_registerbit sets a bit of a ro register
    -- (for other register memory types you have to use the register_access process)
    procedure set_ro_registerbit (signal reg_mem : inout registermemory_t; constant reg_id, reg_bit : natural; constant value : std_logic);
    
end package register_pack;

-- ------------------------------------------------------------------------------

package body register_pack is

    function registertype2enum (constant reg_type : registertype_t) return std_logic_vector is
        variable out_vec : std_logic_vector(7 downto 0);
    begin
        case (reg_type) is
            when UINT8 =>
                out_vec := x"00";
            when INT8 =>
                out_vec := x"01";
            when UINT16 =>
                out_vec := x"02";
            when INT16 =>
                out_vec := x"03";
            when SINGLEFLOAT =>
                out_vec := x"04";
            when UINT32 =>
                out_vec := x"05";
            when INT32 =>
                out_vec := x"06";
            when DOUBLEFLOAT =>
                out_vec := x"07";
            when UINT64 =>
                out_vec := x"08";
            when INT64 =>
                out_vec := x"09";
            when others =>
                out_vec := x"FF"; -- ERROR
        end case;
        return out_vec;
    end registertype2enum;
    
    function enum2registertype (constant enum : std_logic_vector) return registertype_t is
        variable reg_type : registertype_t;
    begin
        case (enum) is 
            when x"00" =>
                reg_type := UINT8;
            when x"01" =>
                reg_type := INT8;
            when x"02" =>
                reg_type := UINT16;
            when x"03" =>
                reg_type := INT16;
            when x"04" =>
                reg_type := SINGLEFLOAT;
            when x"05" =>
                reg_type := UINT32;
            when x"06" =>
                reg_type := INT32;
            when x"07" =>
                reg_type := DOUBLEFLOAT;
            when x"08" =>
                reg_type := UINT64;
            when x"09" =>
                reg_type := INT64;
            when others =>
                reg_type := ERROR;
        end case;
        return reg_type;
    end enum2registertype;

    function registertype2len (constant reg_type : registertype_t) return natural is
        variable out_len : natural range 0 to 8;
    begin
        case (reg_type) is
            when UINT8 =>
                out_len := 1;
            when INT8 =>
                out_len := 1;
            when UINT16 =>
                out_len := 2;
            when INT16 =>
                out_len := 2;
            when SINGLEFLOAT =>
                out_len := 4;
            when UINT32 =>
                out_len := 4;
            when INT32 =>
                out_len := 4;
            when DOUBLEFLOAT =>
                out_len := 8;
            when UINT64 =>
                out_len := 8;
            when INT64 =>
                out_len := 8;
            when others =>
                out_len := 0; -- ERROR
        end case;
        return out_len;
    end registertype2len;

    function get_register (constant reg_mem : registermemory_t; constant reg_id : natural) return std_logic_vector is
        variable ret : std_logic_vector(63 downto 0);
    begin
        -- check register memory type and read the max possible length (64bit)
        -- TODO: think about a better solution because the memories have to be 7bytes
        --       bigger than necessary to allow 8byte reads at the end of memory.
        --       (e.g. last reg is 1byte -> memory has to be increased by 7bytes)
        --       (fix this in lib/RobotConfig/src/VhdlPackageWriter.cpp also)
        
        -- check if a write is active on the register to be read
        -- if yes, read the data from the tmp_reg (this enables atomic writes)
        if reg_id = reg_mem.tmp_reg_id then
            ret := reg_mem.tmp_reg;
        else
            case REGISTER_MEM_TYPES(reg_id) is
                when prom =>
                    ret := reg_mem.prom_registers(REGISTER_MEMORY_MAP(reg_id)+7) &
                           reg_mem.prom_registers(REGISTER_MEMORY_MAP(reg_id)+6) &
                           reg_mem.prom_registers(REGISTER_MEMORY_MAP(reg_id)+5) &
                           reg_mem.prom_registers(REGISTER_MEMORY_MAP(reg_id)+4) &
                           reg_mem.prom_registers(REGISTER_MEMORY_MAP(reg_id)+3) &
                           reg_mem.prom_registers(REGISTER_MEMORY_MAP(reg_id)+2) &
                           reg_mem.prom_registers(REGISTER_MEMORY_MAP(reg_id)+1) &
                           reg_mem.prom_registers(REGISTER_MEMORY_MAP(reg_id));
                when ram =>
                    ret := reg_mem.ram_registers(REGISTER_MEMORY_MAP(reg_id)+7) &
                           reg_mem.ram_registers(REGISTER_MEMORY_MAP(reg_id)+6) &
                           reg_mem.ram_registers(REGISTER_MEMORY_MAP(reg_id)+5) &
                           reg_mem.ram_registers(REGISTER_MEMORY_MAP(reg_id)+4) &
                           reg_mem.ram_registers(REGISTER_MEMORY_MAP(reg_id)+3) &
                           reg_mem.ram_registers(REGISTER_MEMORY_MAP(reg_id)+2) &
                           reg_mem.ram_registers(REGISTER_MEMORY_MAP(reg_id)+1) &
                           reg_mem.ram_registers(REGISTER_MEMORY_MAP(reg_id));
                when ro =>
                    ret := reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+7) &
                           reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+6) &
                           reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+5) &
                           reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+4) &
                           reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+3) &
                           reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+2) &
                           reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+1) &
                           reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id));
                when others =>
                    ret := (others => '0');
            end case;
        end if;

        -- check the register type and return the corresponding length
        case registertype2len(REGISTER_TYPES(reg_id)) is
            when 1 =>
                return ret(7 downto 0);
            when 2 =>
                return ret(15 downto 0);
            when 4 =>
                return ret(31 downto 0);
            when 8 =>
                return ret(63 downto 0);
            when others =>
                -- this should produce an synthesis error
                -- because 1bit registers do not exist
                return ret(0 downto 0);
        end case;
    end get_register;

    procedure set_ro_register (signal reg_mem : inout registermemory_t; constant reg_id : natural; constant value : std_logic_vector) is
    begin
        -- check the register memory type and set the memory if it is a ro register
        case REGISTER_MEM_TYPES(reg_id) is
            when ro =>
                -- do it with the correct length
                case registertype2len(REGISTER_TYPES(reg_id)) is
                    when 1 =>
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id))   <= value;
                    when 2 =>
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id))   <= value(7 downto 0);
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+1) <= value(15 downto 8);
                    when 4 =>
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id))   <= value(7 downto 0);
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+1) <= value(15 downto 8);
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+2) <= value(23 downto 16);
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+3) <= value(31 downto 24);
                    when 8 =>
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id))   <= value(7 downto 0);
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+1) <= value(15 downto 8);
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+2) <= value(23 downto 16);
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+3) <= value(31 downto 24);
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+4) <= value(39 downto 32);
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+5) <= value(47 downto 40);
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+6) <= value(55 downto 48);
                        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+7) <= value(63 downto 56);
                    when others =>
                end case;
            when others =>
        end case;
    end set_ro_register;
    
    procedure set_ro_registerbit (signal reg_mem : inout registermemory_t; constant reg_id, reg_bit : natural; constant value : std_logic) is
        variable act_byte : integer range 0 to 7;
        variable act_bit  : integer range 0 to 7;
    begin

        -- get the actual byte and bit in the register memory which has to be updated
        act_byte := to_integer(resize(shift_right(to_unsigned(reg_bit,6),3),3));
        act_bit  := to_integer(resize(to_unsigned(reg_bit,6),3));

        -- update the correct bit in the correct byte in the register memory
        reg_mem.ro_registers(REGISTER_MEMORY_MAP(reg_id)+act_byte)(act_bit) <= value;
        
    end set_ro_registerbit;

end package body register_pack;
