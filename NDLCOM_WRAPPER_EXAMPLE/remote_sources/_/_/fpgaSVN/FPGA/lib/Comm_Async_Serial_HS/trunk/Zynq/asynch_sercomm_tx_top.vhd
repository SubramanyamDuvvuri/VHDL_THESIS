----------------------------------------------------------------------------------
-- Company:         DFKI Bremen
-- Engineer:        Florian Hühn
-- 
-- Create Date:     10:18:14 10.12.2013
-- Design Name: 
-- Module Name:     asynch_sercomm_tx_top - Behavioral 
-- Project Name: 
-- Target Devices:  Series7 Family. Tested von XC7Z020-1DG484
-- Tool versions: 
-- Description:     Receiver module with channel decoder.
--                  All clocks have to be in sync with each other!
--                  If you didn't mess with the basic_clk_reset_mod and the
--                  config-package this will be the case.
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
library encode_8b10b;
use     work.asynch_sercomm_config_pack.all;


entity asynch_sercomm_tx_top is
    generic (
            SLOW_GEN_DELAY_CYCLES : natural := 1    -- Nuber of cycles (clkCommInterface) which are needed 
                                                    -- by the Ssgnal source to react on encoderNewDataStrobe
                                                    -- (Usually this will be one Cycle...)
        );
    port (
            clkFullDR : in  std_logic;              -- Datarate, gclk network
            clkHalfDR : in  std_logic;              -- Datarate/2, gclk network
            clkCommInterface : in std_logic;        -- Clock for decoder*-Signals. See CLK_COMM_INTERFACE_FREQ
            reset : in std_logic;                   -- Global reset, has to be aligned with clkHalfDR
            txPPin : out std_logic;                 -- Direct connection to differential output pin P
            txNPin : out std_logic;                 -- Direct connection to differential output pin N
            
            encoderWordIn : in std_logic_vector(7 downto 0);  -- Word input (clkCommInterface Domain)
            encoderKIn : in std_logic;              -- Word is K-word (clkCommInterface Domain)
            encoderNewDataStrobe : out std_logic    -- Need new Data (clkCommInterface Domain)
        );
end asynch_sercomm_tx_top;

architecture Behavioral of asynch_sercomm_tx_top is

-- LVDS transmitter block
signal txLine : std_logic;

-- Tx Frontend
signal codedWordFast : std_logic_vector(9 downto 0) := (others => '0'); --abcdeifghj
signal codedWordAckStrobeFast : std_logic := '0';

-- ClockDomainTransfer
alias encoderWordInSlow : std_logic_vector(7 downto 0) is encoderWordIn;
alias encoderKInSlow : std_logic is encoderKIn;
alias encoderNewDataStrobeSlow : std_logic is encoderNewDataStrobe;

constant STROBE_DELAY : natural := (5+CLK_COMM_INTERFACE_DIV*(1+SLOW_GEN_DELAY_CYCLES)-1) mod 5; -- Verzögerung des codedWordAckStrobeFast, die notwendig ist,
                                                                                                 -- um zum richtigen Zeitpunkt die Daten aus dem Fast-Buffer
                                                                                                 -- Richtung Frontend zu übertragen. Ohne verzögerung würde ein
                                                                                                 -- Wort doppelt übertragen, ein anderes hingegen garnicht.
                                                                                                 -- Insbesondere bei CLK_COMM_INTERFACE_DIV=4
signal strobeTracking : std_logic_vector(STROBE_DELAY downto 0) := (others => '0');

signal bufferedWordInFast : std_logic_vector(7 downto 0) := (others => '0');
signal bufferedKInFast : std_logic := '0';
signal encoderWordInFast : std_logic_vector(7 downto 0) := (others => '0');
signal encoderKInFast : std_logic := '0';
signal codedWordAckStrobeFastLatched : std_logic := '0';
signal clkDomainTSlow : std_logic := '0';
signal clkDomainTFast : std_logic_vector(CLK_COMM_INTERFACE_DIV-1 downto 0) := (others => '0');


begin
----------------------------------------------------------------------------------------------------------------------    
-- Rx
    -- LVDS transmitter block
    OBUFDS_inst : OBUFDS
    generic map (
        IOSTANDARD => ASYNCH_SERCOMM_IOSTANDARD_TX --LVDS_33 or LVDS_25
        ) 
    port map (
        O => txPPin,            -- Diff_p output (connect directly to top-level port)
        OB => txNPin,           -- Diff_n output (connect directly to top-level port)
        I => txLine             -- Buffer input 
    ); 

    -- Frontend
    tx_inst : entity work.asynch_sercomm_tx_frontend
    port map(
        clkFullDR => clkFullDR,                 -- Datarate, gclk network
        clkHalfDR => clkHalfDR,                 -- Datarate/2, gclk network
        reset => reset,                         -- Global reset, has to be aligned with clkHalfDR
        txPin => txLine,                        -- Direct connection to Output Pin of IOB or OBUFDS
        codedWordIn => codedWordFast,           -- Word input. Order: abcdeifghj (MSB transmitted first)
        codedWordInAckStrobe => codedWordAckStrobeFast-- Read codedWordIn. Apply next word.
    );
    
----------------------------------------------------------------------------------------------------------------------    
-- 8b10b encoder
    encode_8b10b_inst : entity encode_8b10b.encode_8b10b_top
    generic map(
        C_ENCODE_TYPE => ASYNCH_SERCOMM_8b10b_USE_BRAM, --1=BRAM basiert, 0=LUT
        C_ELABORATION_DIR => "./",  --Verzeichnis für BRAM-Init File
        C_HAS_BPORTS => 0,          --Einzelner Dekoder
        C_HAS_CE => 1,              --Clock Enable
        C_FORCE_CODE_DISP => 0,
        C_FORCE_CODE_DISP_B => 0,
        C_FORCE_CODE_VAL => "1010101010",
        C_FORCE_CODE_VAL_B => "1010101010",
        C_HAS_DISP_OUT => 0,
        C_HAS_DISP_IN => 0,
        C_HAS_FORCE_CODE => 0,
        C_HAS_KERR => 0,            --Output "K-Wort nicht existent"
        C_HAS_ND => 0               --NewData Output
    )
    port map(
        CLK        => clkHalfDR,
        CE         => codedWordAckStrobeFast,
        DIN        => encoderWordInFast,
        KIN        => encoderKInFast,
        DOUT(0)       => codedWordFast(9),
        DOUT(1)       => codedWordFast(8),
        DOUT(2)       => codedWordFast(7),
        DOUT(3)       => codedWordFast(6),
        DOUT(4)       => codedWordFast(5),
        DOUT(5)       => codedWordFast(4),
        DOUT(6)       => codedWordFast(3),
        DOUT(7)       => codedWordFast(2),
        DOUT(8)       => codedWordFast(1),
        DOUT(9)       => codedWordFast(0)
    );
    
----------------------------------------------------------------------------------------------------------------------    
-- ClkDomainTransfer
    ClkDomainTransfer_generate : if(CLK_COMM_INTERFACE_DIV>1) generate
        clk_domain_transfer_slow_t_proc : process(clkCommInterface)
        begin
            if(clkCommInterface'event and clkCommInterface='1') then
                clkDomainTSlow <= not clkDomainTSlow;
            end if;
        end process;
        
        clk_domain_transfer_proc : process(clkHalfDR)
        begin
            if(clkHalfDR'event and clkHalfDR='1') then
                clkDomainTFast(0) <= clkDomainTSlow;
                clkDomainTFast(CLK_COMM_INTERFACE_DIV-1 downto 1) <= clkDomainTFast(CLK_COMM_INTERFACE_DIV-2 downto 0);
                
                if(clkDomainTFast(CLK_COMM_INTERFACE_DIV-1) /= clkDomainTFast(CLK_COMM_INTERFACE_DIV-2)) then
                    bufferedWordInFast <= encoderWordInSlow;
                    bufferedKInFast <= encoderKInSlow;
                    
                    encoderNewDataStrobeSlow <= codedWordAckStrobeFastLatched;
                    codedWordAckStrobeFastLatched <= '0';
                end if;
                
                if(codedWordAckStrobeFast='1') then
                    codedWordAckStrobeFastLatched <= '1';
                end if;
                
                strobeTracking(strobeTracking'low) <= codedWordAckStrobeFast;
                strobeTracking(strobeTracking'high downto strobeTracking'low+1) <= strobeTracking(strobeTracking'high-1 downto strobeTracking'low);
                if(strobeTracking(strobeTracking'high)='1') then
                    encoderWordInFast <= bufferedWordInFast;
                    encoderKInFast <= bufferedKInFast;
                end if;                
            end if;
        end process;
    end generate;
    
    NoClkDomainTransfer_generate : if(CLK_COMM_INTERFACE_DIV=1) generate
        encoderWordInFast <= encoderWordInSlow;
        encoderKInFast <= encoderKInSlow;
        encoderNewDataStrobeSlow <= codedWordAckStrobeFast;
    end generate;    

end Behavioral;

