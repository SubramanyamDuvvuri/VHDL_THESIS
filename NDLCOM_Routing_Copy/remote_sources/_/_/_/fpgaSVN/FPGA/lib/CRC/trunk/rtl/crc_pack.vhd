-------------------------------------------------------------------------------
-- Title      : crc_pack
-- Project    : SeeGrip
-------------------------------------------------------------------------------
-- File       : crc_pack.vhd
-- Author     : Hendrik Hanff
-- Company    : DFKI - Deutsches Forschungszentrum für künstliche Intelligenz
-- Created    : 2010-13-08
-- Last update: 2014-10-27
-- Platform   : Xilinx
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This package provides a crc generator
--              Examples on how to use it can be found in the SD-Card project
--              (see sd_card_spi_wrapper.vhd)
--              A good place to verify the crc calculation is:
--              http://ghsi.de/CRC/index.php?Polynom=1000011&Message=3fff
-------------------------------------------------------------------------------
-- Copyright (c) 2010
-------------------------------------------------------------------------------
-- $Rev:: 3590                                            $:  Revision of last commit
-- $Author:: hhanff                                       $:  Author of last commit
-- $Date:: 2014-10-27 17:15:51 +0100 (Mon, 27 Oct 2014)   $:  Date of last commit
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

package crc_pack is
-----------------------------------------------------------------------------
-- Comment about the generator polynomials:
-- LSB represents x^0, MSB represents x^(n-1)
-- x^n is always present and thus NOT included in this representation
-----------------------------------------------------------------------------
  -- CCITT 32 bit x^32+x^26+x^23+x^22+x^16+x^12+x^11+x^10+x^8+x^7+x^5+x^4+x^2+x+1
  constant Crc32Syndrom_c : std_logic_vector (32 downto 1) := x"0000_0000";
  constant Polynomial32_c : std_logic_vector (32 downto 1) := x"04C1_1DB7";  -- (1)0000_0100_1100_0001" 0001_1101_1011_0111;
  -- CCITT/FCS 16 bit X16+X12+X5+1
  constant Crc16Init_c    : std_logic_vector (16 downto 1) := x"ffff";
  --constant Crc16Syndrom_c : std_logic_vector (16 downto 1) := x"84cf";
  constant Crc16Syndrom_c : std_logic_vector (16 downto 1) := x"ffff";
  constant Polynomial16_c : std_logic_vector (16 downto 1) := x"1021";  -- (1)0001_0000_0010_0001";
  --constant Polynomial16_c : std_logic_vector (16 downto 1) := x"8408";  -- (1)0001_0000_0010_0001";
  -- CCITT 8 bit X8+X2+X1+1
  constant Crc8Syndrom_c  : std_logic_vector (8 downto 1)  := x"00";  --    0000_0000;
  constant Polynomial8_c  : std_logic_vector (8 downto 1)  := x"07";  -- (1)0000_0111;
  -- CCITT 7 bit X7+X3+1  (SD, MMC)
  constant Crc7Syndrom_c  : std_logic_vector (7 downto 1)  := "0000000";  --    000_0000;
  constant Polynomial7_c  : std_logic_vector (7 downto 1)  := "0001001";  -- (1)000_1001;
  --       6 bit X6+X1+1  (SSI)
  constant Crc6Syndrom_c  : std_logic_vector (6 downto 1)  := "000000";  --    00_0000;
  constant Polynomial6_c  : std_logic_vector (6 downto 1)  := "000011";  -- (1)00_0011;
  --       5 bit X5+X3+1 (USB)
  constant Crc5Syndrom_c  : std_logic_vector (5 downto 1)  := "00000";  --    0_0000;
  constant Polynomial5_c  : std_logic_vector (5 downto 1)  := "00101";  -- (1)0_0101;
  -- E.g. needed in biss/ssi protocol
  constant Crc4Syndrom_c  : std_logic_vector (4 downto 1)  := "0000";  --    0000;
  constant Polynomial4_c  : std_logic_vector (4 downto 1)  := "0011";  -- (1)0_0011;

-----------------------------------------------------------------------------
-- CRC functions
-----------------------------------------------------------------------------
  -- CRC generation
  function CrcGen_f (
    Enable                : in std_logic;
    Clear                 : in std_logic;
    DataIn                : in std_logic_vector;
    Crc                   : in std_logic_vector;
    constant Polynomial_c : in std_logic_vector
    ) return std_logic_vector;

  -- Pseudo random bit stream generation
  function PrbsGen_f (
    Enable     : in std_logic;
    Clear      : in std_logic;
    NbrOfBits  : in positive;
    Prbs       : in std_logic_vector;
    Polynomial : in std_logic_vector
    ) return std_logic_vector;

end crc_pack;

package body crc_pack is

  -- Generates a CRC checksum
  function CrcGen_f (
    Enable                : in std_logic;
    Clear                 : in std_logic;
    DataIn                : in std_logic_vector;
    Crc                   : in std_logic_vector;
    constant Polynomial_c : in std_logic_vector
    ) return std_logic_vector is
    variable Crc_v : unsigned(Crc'range);
  begin
    Crc_v := unsigned(Crc) or (Crc_v'range => Clear);
    if (Enable = '1') then
      for var in DataIn'range loop
        Crc_v := (('0' & Crc_v(Crc_v'high-1 downto Crc_v'low)) xor((unsigned(Polynomial_c) ror 1) and(Crc_v'range => (DataIn(var) xor Crc_v(Crc_v'high))))) rol 1;
      end loop;
    end if;
    return std_logic_vector(Crc_v);
  end;

  -- Pseudo random bit stream generation
  function PrbsGen_f (
    Enable     : in std_logic;
    Clear      : in std_logic;
    NbrOfBits  : in positive;
    Prbs       : in std_logic_vector;
    Polynomial : in std_logic_vector
    ) return std_logic_vector is
    variable Prbs_v : unsigned(Prbs'range);
    variable Temp_v : std_logic;
  begin
    Prbs_v := unsigned(Prbs) or (Prbs_v'range => Clear);
    if (Enable = '1') then
      for k in 1 to NbrOfBits loop
        Temp_v := '0';
        for i in Polynomial'range loop
          Temp_v := Temp_v xor (Polynomial(i) and Prbs_v(i));
        end loop;
        Prbs_v := Prbs_v(Prbs_v'high-1 downto Prbs_v'low) & Temp_v;
      end loop;
    end if;
    return std_logic_vector(Prbs_v);
  end;

end;
