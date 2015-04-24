---------------------------------------------------------------------------------
--! @file   NDLCom_config.vhd
--! @author Tobias Stark (tobias.stark@dfki.de)
--! @date   2011
--!
--! @brief  Configuration for NDLCom.
--!
--! Receiver module for NDLCom with HSCom.\n\n
--!
--! German Research Center for Artificial Intelligence
---------------------------------------------------------------------------------
-- Last Commit: 
-- $LastChangedRevision: 3912 $
-- $LastChangedBy: tstark $
-- $LastChangedDate: 2015-04-07 13:11:57 +0200 (Tue, 07 Apr 2015) $
---------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

--! @brief This file contains the configuration data for the FPGA NDLCom IP core.
package NDLCom_config is

    constant SIMULATION : boolean := false;
    type Array2x8 is array (0 to 1) of std_logic_vector(7 downto 0);

    constant TIMEOUT_MS : integer := 100;

    -- memory size: size of the different buffers (should hold approx. 2 messages)
    constant MEM_ADDR_WIDTH : integer := 10;

    constant HEADER_LENGTH   : integer := 4;  -- Length of the header
    constant CRC_LENGTH      : integer := 2;  -- Length of the CRC field
    constant MAX_PACKET_SIZE : integer := HEADER_LENGTH+2+CRC_LENGTH+510;  -- start, end flag, fcs and header and 2*255 bytes payload

    constant FLAG_BYTE   : std_logic_vector(7 downto 0) := x"7e";
    constant ESCAPE_BYTE : std_logic_vector(7 downto 0) := x"7d";

    constant BROADCAST_ID : std_logic_vector(7 downto 0) := x"ff";

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
