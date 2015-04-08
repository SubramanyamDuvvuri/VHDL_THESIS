----------------------------------------------------------------------------------
--! @file    rtc_mod.vhd
--!
--! @brief   Real time clock module for an internal time in us.
--! @details Real time clock module that calculates an internal time in us.\n\n
--!          German Research Center for Artificial Intelligence\n
--!          Project: iStruct\n
--!
--!          $LastChangedRevision: 2666 $
--!          $LastChangedBy: tstark $
--!          $LastChangedDate: 2011-09-21 11:13:40 +0200 (Wed, 21 Sep 2011) $
--!
--! @date   24.08.2011
--! @author Tobias Stark (tobias.stark@dfki.de)
--!
--! @addtogroup VHDL
--! @{
--! @defgroup VHDL_rtc_mod rtc_mod
--! @{
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity rtc_mod is
    generic ( SYSTEM_speed : integer := 18432000 );
    port ( CLK : in  std_logic;
           RST : in  std_logic;
           actualTime : out std_logic_vector(63 downto 0);
           setNewTime : in  std_logic;
           newTime : in std_logic_vector(63 downto 0) );
end rtc_mod;

architecture Behavioral of rtc_mod is

    constant MHZ_MAX_COUNTER : integer := SYSTEM_speed/1000000;
    constant KHZ_100_VALUE   : integer := (SYSTEM_speed-MHZ_MAX_COUNTER*1000000)/100000;
    constant KHZ_10_VALUE    : integer := (SYSTEM_speed-MHZ_MAX_COUNTER*1000000-KHZ_100_VALUE*100000)/10000;
    constant KHZ_1_VALUE     : integer := (SYSTEM_speed-MHZ_MAX_COUNTER*1000000-KHZ_100_VALUE*100000-KHZ_10_VALUE*10000)/1000;

begin

    time_counter : process (CLK, RST)
        variable time_int        : std_logic_vector(63 downto 0);
        variable clk_counter     : integer range 0 to MHZ_MAX_COUNTER-1;
        variable khz_100_counter : integer range 0 to 9;
        variable khz_10_counter  : integer range 0 to 99;
        variable khz_1_counter   : integer range 0 to 999;
        variable khz_100_extra   : integer range 0 to 9;
        variable khz_10_extra    : integer range 0 to 9;
        variable khz_1_extra     : integer range 0 to 9;
    begin
        if CLK='1' and CLK'event then
            if RST='1' then
                time_int := (others => '0');
                clk_counter     := 0;
                khz_100_counter := 0;
                khz_10_counter  := 0;
                khz_1_counter   := 0;
                khz_100_extra   := 0;
                khz_10_extra    := 0;
                khz_1_extra     := 0;
            else
                
                if setNewTime = '1' then
                    time_int        := newTime;
                    clk_counter     := 0;
                    khz_100_counter := 0;
                    khz_10_counter  := 0;
                    khz_1_counter   := 0;
                    khz_100_extra   := 0;
                    khz_10_extra    := 0;
                    khz_1_extra     := 0;
                    
                elsif clk_counter < MHZ_MAX_COUNTER-1 then
                    clk_counter   := clk_counter + 1;
                    
                elsif khz_100_extra > 0 then
                    -- extra clk cycles for 100kHz values
                    khz_100_extra := khz_100_extra - 1;
                    
                elsif khz_10_extra > 0 then
                    -- extra clk cycles for 10kHz values
                    khz_10_extra  := khz_10_extra - 1;
                    
                elsif khz_1_extra > 0 then
                    -- extra clk cycles for 1kHz values
                    khz_1_extra   := khz_1_extra - 1;
                    
                else

                    clk_counter := 0;
                    time_int := time_int + 1;

                    if khz_100_counter < 9 then
                        khz_100_counter := khz_100_counter + 1;
                    else
                        -- add extra clk cycles for 100kHz values
                        khz_100_counter := 0;
                        khz_100_extra := KHZ_100_VALUE;
                    end if;

                    if khz_10_counter < 99 then
                        khz_10_counter := khz_10_counter + 1;
                    else
                        -- add extra clk cycles for 10kHz values
                        khz_10_counter := 0;
                        khz_10_extra := KHZ_10_VALUE;
                    end if;

                    if khz_1_counter < 999 then
                        khz_1_counter := khz_1_counter + 1;
                    else
                        -- add extra clk cycles for 1kHz values
                        khz_1_counter := 0;
                        khz_1_extra := KHZ_1_VALUE;
                    end if;
                        
                end if;
            end if;
            actualTime <= time_int;
        end if;
    end process;

end Behavioral;

--! @}
--! @}
