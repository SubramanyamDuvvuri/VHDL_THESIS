--! @file NDLCom_config.vhd
--! @date 2011

--! @addtogroup group_NDLCom
--! @{

--! @addtogroup group_NDLCom_vhdl
--! @{

library IEEE;
use IEEE.STD_LOGIC_1164.all;

--! @brief This file contains the configuration data for the FPGA NDLCom IP core.
package NDLCom_config is

  constant MAX_NUM_NODES : integer := 64;

  -- memory size: size of the send buffer
  -- this should be aligned with the send_buffer IP core (!)
  constant MEM_ADDR_WIDTH : integer := 10;
  constant MEM_SIZE       : integer := 2**MEM_ADDR_WIDTH;

  constant HEADER_LENGTH   : integer := 4;
  constant CRC_LENGTH      : integer := 2;  -- Length of the CRC field
  constant MAX_PACKET_SIZE : integer := HEADER_LENGTH+2+CRC_LENGTH+510;  -- 7 bytes start, end flag, fcs and header 
                                        -- 2*255 bytes payload -- Double the number of bytes are used as , in the worst case scenario all the bytes can be changed by esape sequences 

  constant FLAG_BYTE   : std_logic_vector(7 downto 0) := x"7e";
  constant ESCAPE_BYTE : std_logic_vector(7 downto 0) := x"7d";

  constant BROADCAST_ID : std_logic_vector(7 downto 0) := x"ff";

  -- direction of the communication
  -- top: to/from the body
  -- bottom: to/from the end point
  type communication_direction is (top, bottom, broadcast);

  -- routing array where for each node the communication direction can be stored
  type routing_array is array(0 to MAX_NUM_NODES) of communication_direction;

  -- type definition for the header
  type header_type is array (0 to HEADER_LENGTH-1) of std_logic_vector(7 downto 0);

  -- Record for CRC module input
  type crc_i_t is record
    -- The 'crc_check' items are for data which is received by the ndlcom
    -- module. The 'crc_gen' items are for data which is sent away by the ndlcom
    -- module

    -- Contains one byte of data. This byte is serialized and fed into the crc
    -- generation module
    crc_check_buf          : std_logic_vector(7 downto 0);
    -- This element is the trigger for the crc check module to serialize the
    -- above data byte and compute a crc on it
    crc_check_buf_new_byte : std_logic;
    -- To reset the generated crc check value
    crc_check_reset        : std_logic;
    -- Contains one byte of data. This byte is serialized and fed into the crc
    -- generation module
    crc_gen_buf            : std_logic_vector(7 downto 0);
    -- This element is the trigger for the crc generation module to serialize
    -- the above data byte and compute a crc on it
    crc_gen_buf_new_byte   : std_logic;
    -- To reset the generated crc gen value
    crc_gen_reset          : std_logic;
  end record crc_i_t;

  -- Record for CRC module output
  type crc_o_t is record
    -- The 'crc_check' items are for data which is received by the ndlcom
    -- module. The 'crc_gen' items are for data which is sent away by the ndlcom
    -- module

    -- This element contains the computed crc value for incoming data
    crc_check_value : std_logic_vector(15 downto 0);
    -- This element contains the computed crc value for outgoing data
    crc_gen_value   : std_logic_vector(15 downto 0);
    -- '1' if CRC is correct
    crc_check_match : std_logic;
  end record crc_o_t;

end NDLCom_config;

--! @}

--! @}
