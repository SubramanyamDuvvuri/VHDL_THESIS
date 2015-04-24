----------------------------------------------------------------------------------
-- Company:         DFKI Bremen
-- Engineer:        Florian Hühn
-- 
-- Create Date:     16:48:17 01/08/2013 
-- Design Name: 
-- Module Name:     asynch_sercomm_tx_frontend - Behavioral 
-- Project Name: 
-- Target Devices:  Spartan6 Family. Tested von XC6SLX45-3CSG324
-- Tool versions: 
-- Description: 
--                  Sendeteil für schnelle, asynchrone Kommunikation.
--                  Ausgelegt für 8b10b-Code.
--                  Es muss immer ein zu sendendes Wort am Eingang codedWordIn
--                  bereit stehen. Wenn keine Daten zu versenden sind, eben das
--                  Idle-Wort K28.5.
--                  Zwecks Synchronisation im Empfangsteil ist das Wort K28.7
--                  verboten!
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;
use     IEEE.NUMERIC_STD.ALL;
Library UNISIM;
use     UNISIM.vcomponents.all;

entity asynch_sercomm_tx_frontend is
    Port (  
            clkHalfDR : in  std_logic;        -- Datarate/2, gclk network
            clkDoubleDR_ioce : in  std_logic; -- Datarate/2, special ioce synchronisation network
            clkDoubleDR_io : in  std_logic;   -- Datarate*2, BUFIO2 or BUFPLL Clock Region network
            reset : in std_logic;             -- Global reset
            txPin : out  std_logic;           -- Direct connection to Output Pin of IOB or OBUFDS
            codedWordIn : in std_logic_vector(9 downto 0) := (others => '0'); -- Word input. Order: abcdeifghj (MSB transmitted first)
            codedWordInAckStrobe : out std_logic := '0' -- Read codedWordIn. Apply next word.
        );
end asynch_sercomm_tx_frontend;

architecture Behavioral of asynch_sercomm_tx_frontend is

signal bitcounter : natural range 0 to 4 := 0;
signal txData : std_logic_vector(1 downto 0) := (others => '0');
signal codedWordBuffer : std_logic_vector(9 downto 0) := (others => '0'); --abcdeifghj

begin
----------------------------------------------------------------------------------------------------------------------    
-- Tx "sampling"
-- Um Clocknetze zu sparen und den Transfer zwischen Clockdomänen zu umgehen werden die gleichen Taktraten wie beim
-- Rx-Modul verwendet
   OSERDES2_inst : OSERDES2
   generic map (
      BYPASS_GCLK_FF => FALSE,       -- Bypass CLKDIV syncronization registers (TRUE/FALSE)
      DATA_RATE_OQ => "SDR",         -- Output Data Rate ("SDR" or "DDR")
      DATA_RATE_OT => "SDR",         -- 3-state Data Rate ("SDR" or "DDR")
      DATA_WIDTH => 4,               -- Parallel data width (2-8)
      OUTPUT_MODE => "SINGLE_ENDED", -- "SINGLE_ENDED" or "DIFFERENTIAL" 
      SERDES_MODE => "NONE",         -- "NONE", "MASTER" or "SLAVE" 
      TRAIN_PATTERN => 0             -- Training Pattern (0-15)
   )
   port map (
      OQ => txPin,              -- 1-bit output: Data output to pad or IODELAY2
      SHIFTOUT1 => open,        -- 1-bit output: Cascade data output
      SHIFTOUT2 => open,        -- 1-bit output: Cascade 3-state output
      SHIFTOUT3 => open,        -- 1-bit output: Cascade differential data output
      SHIFTOUT4 => open,        -- 1-bit output: Cascade differential 3-state output
      TQ => open,               -- 1-bit output: 3-state output to pad or IODELAY2
      CLK0 => clkDoubleDR_io,   -- 1-bit input: I/O clock input
      CLK1 => '0',              -- 1-bit input: Secondary I/O clock input
      CLKDIV => clkHalfDR,      -- 1-bit input: Logic domain clock input
      -- D1 - D4: 1-bit (each) input: Parallel data inputs
      D1 => txData(0),
      D2 => txData(0),
      D3 => txData(1),
      D4 => txData(1),
      IOCE => clkDoubleDR_ioce, -- 1-bit input: Data strobe input
      OCE => '1',               -- 1-bit input: Clock enable input
      RST => '0',               -- 1-bit input: Asynchrnous reset input
      SHIFTIN1 => '0',          -- 1-bit input: Cascade data input
      SHIFTIN2 => '0',          -- 1-bit input: Cascade 3-state input
      SHIFTIN3 => '0',          -- 1-bit input: Cascade differential data input
      SHIFTIN4 => '0',          -- 1-bit input: Cascade differential 3-state input
      -- T1 - T4: 1-bit (each) input: 3-state control inputs
      T1 => '0',
      T2 => '0',
      T3 => '0',
      T4 => '0',
      TCE => '0',               -- 1-bit input: 3-state clock enable input
      TRAIN => '0'              -- 1-bit input: Training pattern enable input
   );
   
   
    tx_proc : process(clkHalfDR)
    begin
        -- Reset nicht notwendig: Unabhängig vom jeweiligen Zustand wird er sich synchronisieren und der Reset
        -- führt nur zu timing-Problemen beim routing.
        -- if(reset='1') then
            -- --txData <= (others => '0');
            -- --codedWordBuffer <= (others => '0');
            -- bitcounter <= 0;
            -- codedWordInAckStrobe <= '0';
        -- els
        if(clkHalfDR'event and clkHalfDR='1') then
            case(bitcounter) is
                when 0 =>
                    txData(0) <= codedWordBuffer(9);
                    txData(1) <= codedWordBuffer(8);
                when 1 =>
                    txData(0) <= codedWordBuffer(7);
                    txData(1) <= codedWordBuffer(6);
                when 2 =>
                    txData(0) <= codedWordBuffer(5);
                    txData(1) <= codedWordBuffer(4);
                when 3 =>
                    txData(0) <= codedWordBuffer(3);
                    txData(1) <= codedWordBuffer(2);
                when others =>
                    txData(0) <= codedWordBuffer(1);
                    txData(1) <= codedWordBuffer(0);
            end case;
            
            codedWordInAckStrobe <= '0';
            if(bitcounter=4) then
                bitcounter <= 0;
                codedWordBuffer <= codedWordIn;
                codedWordInAckStrobe <= '1';
            else
                bitcounter <= bitcounter + 1;
            end if;
        end if;
    end process;
    
end Behavioral;
