----------------------------------------------------------------------------------
-- Company:         DFKI Bremen
-- Engineer:        Florian Hühn
-- 
-- Create Date:     10:18:14 10.12.2013
-- Design Name: 
-- Module Name:     asynch_sercomm_tx_frontend - Behavioral 
-- Project Name: 
-- Target Devices:  Series7 Family. Tested von XC7Z020-1DG484
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
-- Revision 0.02 - Adapted from Spratan6 to Series7
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
            clkFullDR : in  std_logic;        -- Datarate*2, gclk network
            reset : in std_logic;             -- Global reset, has to be aligned with clkHalfDR
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
   OSERDESE2_inst : OSERDESE2
   generic map (
      DATA_RATE_OQ => "SDR",   -- DDR, SDR
      DATA_RATE_TQ => "SDR",   -- DDR, BUF, SDR
      DATA_WIDTH => 2,         -- Parallel data width (2-8,10,14)
      INIT_OQ => '0',          -- Initial value of OQ output (1'b0,1'b1)
      INIT_TQ => '0',          -- Initial value of TQ output (1'b0,1'b1)
      SERDES_MODE => "MASTER", -- MASTER, SLAVE
      SRVAL_OQ => '0',         -- OQ output value when SR is used (1'b0,1'b1)
      SRVAL_TQ => '0',         -- TQ output value when SR is used (1'b0,1'b1)
      TBYTE_CTL => "FALSE",    -- Enable tristate byte operation (FALSE, TRUE)
      TBYTE_SRC => "FALSE",    -- Tristate byte source (FALSE, TRUE)
      TRISTATE_WIDTH => 1      -- 3-state converter width (1,4)
   )
   port map (
      OFB => open,             -- 1-bit output: Feedback path for data
      OQ => txPin,             -- 1-bit output: Data path output
      SHIFTOUT1 => open,
      SHIFTOUT2 => open,
      TBYTEOUT => open,        -- 1-bit output: Byte group tristate
      TFB => open,             -- 1-bit output: 3-state control
      TQ => open,              -- 1-bit output: 3-state control
      CLK => clkFullDR,   -- 1-bit input: High speed clock
      CLKDIV => clkHalfDR,     -- 1-bit input: Divided clock
      -- D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
      D1 => txData(0),
      D2 => txData(1),
      D3 => '0',
      D4 => '0',
      D5 => '0',
      D6 => '0',
      D7 => '0',
      D8 => '0',
      OCE => '1',              -- 1-bit input: Output data clock enable
      RST => reset,            -- 1-bit input: Reset
      SHIFTIN1 => '0',
      SHIFTIN2 => '0',
      T1 => '0',
      T2 => '0',
      T3 => '0',
      T4 => '0',
      TBYTEIN => '0',          -- 1-bit input: Byte group tristate
      TCE => '0'               -- 1-bit input: 3-state clock enable
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
                codedWordBuffer <= codedWordIn;--"0011111010"; -- "0011111010"=SOF, RD=-1
                codedWordInAckStrobe <= '1';
            else
                bitcounter <= bitcounter + 1;
            end if;
        end if;
    end process;
    
end Behavioral;
