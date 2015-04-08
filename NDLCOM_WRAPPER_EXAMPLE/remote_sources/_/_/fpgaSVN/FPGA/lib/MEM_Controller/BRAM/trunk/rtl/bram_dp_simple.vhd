---------------------------------------------------------------------------------
--! @file    bram_dp_simple.vhd
--!
--! @brief   Simple dual port bram with one write and one read port.
--! @details Simple dual port bram with one write and one read port.
--!          This implementation is based on the example on
--!          http://www.lothar-miller.de/s9y/archives/20-RAM.html#extended\n
--!
--!          $LastChangedRevision: 3288 $
--!          $LastChangedBy: hhanff $
--!          $LastChangedDate: 2014-03-26 09:20:49 +0100 (Wed, 26 Mar 2014) $
--!
--! @date    02.12.2013
--! @author  Tobias Stark (tobias.stark@dfki.de)
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bram_dp_simple is

    generic ( ADDRWIDTH : integer := 8;                           --! address width (memory size: 2^ADDRWIDTH bytes)
              DATAWIDTH : integer := 8 );                         --! data width
    port ( clk   : in  std_logic;                                 --! clock
           we    : in  std_logic;                                 --! write enable
           waddr : in  std_logic_vector(ADDRWIDTH-1 downto 0);    --! write address
           wdata : in  std_logic_vector(DATAWIDTH-1 downto 0);    --! write data
           raddr : in  std_logic_vector(ADDRWIDTH-1 downto 0);    --! read address
           rdata : out std_logic_vector(DATAWIDTH-1 downto 0) );  --! read data

end bram_dp_simple;

architecture behavioral of bram_dp_simple is

    type mem_t is array(0 to 2**ADDRWIDTH-1) of std_logic_vector(DATAWIDTH-1 downto 0);
    -- Default value needed for simulation.
    signal mem : mem_t := (others => (others => '0'));

begin

    mem_access : process (clk)
    begin
        if clk'event and clk='1' then
            if we='1' then
                mem(to_integer(unsigned(waddr))) <= wdata;
            end if;
            rdata <= mem(to_integer(unsigned(raddr)));
        end if;
    end process;

end behavioral;
