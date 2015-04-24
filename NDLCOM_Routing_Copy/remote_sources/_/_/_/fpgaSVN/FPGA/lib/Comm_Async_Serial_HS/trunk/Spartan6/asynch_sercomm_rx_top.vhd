----------------------------------------------------------------------------------
-- Company:         DFKI Bremen
-- Engineer:        Florian Hühn
-- 
-- Create Date:     15:39:58 02/04/2013 
-- Design Name: 
-- Module Name:     asynch_sercomm_rx_top - Behavioral 
-- Project Name: 
-- Target Devices:  Spartan6 Family. Tested von XC6SLX45-3CSG324
-- Tool versions: 
-- Description:     Receiver module with channel decoder.
--                  All clocks have to be in sync with each other!
--                  If you didn't mess with the basic_clk_reset_mod and the
--                  config-package this will be the case.
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
library decode_8b10b;
use     work.asynch_sercomm_config_pack.all;


entity asynch_sercomm_rx_top is
    port (
            clkHalfDR : in  std_logic;              -- Datarate/2, gclk network
            clkDoubleDR_ioce : in  std_logic;       -- Datarate/2, special ioce synchronisation network
            clkDoubleDR_io : in  std_logic;         -- Datarate*2, BUFIO2 or BUFPLL Clock Region network
            clkCommInterface : in std_logic;        -- Clock for decoder*-Signals. See CLK_COMM_INTERFACE_FREQ
            reset : in std_logic;                   -- Global reset
            rxPPin : in std_logic;                  -- Direct connection to differential input signal
            rxNPin : in std_logic;                  -- Direct connection to differential input signal
            decoderWordOut : out std_logic_vector(7 downto 0);  -- Word output (clkCommInterface Domain)
            decoderKOut : out std_logic;            -- Word is K-word (clkCommInterface Domain)
            decoderCodeErr : out std_logic;         -- Invalid code (clkCommInterface Domain)
            decoderDispErr : out std_logic;         -- Running disparity error (clkCommInterface Domain)
            decoderNewDataStrobe : out std_logic    -- New data Available (clkCommInterface Domain)
        );
end asynch_sercomm_rx_top;

architecture Behavioral of asynch_sercomm_rx_top is

-- LVDS receiver block
signal rxLine : std_logic;

-- Rx Frontend
signal codedWordOut : std_logic_vector(9 downto 0) := (others => '0'); --abcdeifghj
signal codedWordOutNewDataStrobe : std_logic := '0';

signal decoderWordOutFast : std_logic_vector(7 downto 0) := (others => '0');
signal decoderKOutFast : std_logic := '0';
signal decoderCodeErrFast : std_logic := '0';
signal decoderDispErrFast : std_logic := '0';
signal decoderNewDataStrobeFast : std_logic := '0';
signal decoderNewDataStrobeFastLatched : std_logic := '0';

-- ClockDomainTransfer
alias decoderWordOutSlow : std_logic_vector(7 downto 0) is decoderWordOut;
alias decoderKOutSlow : std_logic is decoderKOut;
alias decoderCodeErrSlow : std_logic is decoderCodeErr;
alias decoderDispErrSlow : std_logic is decoderDispErr;
alias decoderNewDataStrobeSlow : std_logic is decoderNewDataStrobe;

signal clkDomainTSlow : std_logic := '0';
signal clkDomainTFast : std_logic_vector(CLK_COMM_INTERFACE_DIV-1 downto 0) := (others => '0');

begin
----------------------------------------------------------------------------------------------------------------------    
-- Rx
    -- LVDS receiver block
    IBUFDS_inst : IBUFDS
    generic map (
        DIFF_TERM => TRUE,          -- Differential Termination 
        IBUF_LOW_PWR => FALSE,      -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
        IOSTANDARD => ASYNCH_SERCOMM_IOSTANDARD_RX) --LVDS_33 or LVDS_25
    port map (
        O => rxLine,                -- Buffer output
        I => rxPPin,                -- Diff_p buffer input (connect directly to top-level port)
        IB => rxNPin                -- Diff_n buffer input (connect directly to top-level port)
    );

    -- Frontend
    rx_inst : entity work.asynch_sercomm_rx_frontend
    generic map(
        DATARATE => ASNYCH_SERCOM_DATARATE,     -- Communication Datarate [Symbols/sec]
        SPEEDGRADE => FPGA_SPEEDGRADE           -- Speed Grade of FPGA: "2", "3N", or "3"
    )
    port map(
        clkHalfDR => clkHalfDR,                 -- Datarate/2, gclk network
        clkDoubleDR_ioce => clkDoubleDR_ioce,   -- Datarate/2, special ioce synchronisation network
        clkDoubleDR_io => clkDoubleDR_io,       -- Datarate*2, BUFIO2 or BUFPLL Clock Region network
        reset => reset,                         -- Global reset
        rxPin => rxLine,                        -- Direct connection to Input Pin of IOB or OBUFDS. In single ended mode only P-Pins are possible! (Because of routing constaints of the FPGA)
        codedWordOut => codedWordOut,           -- Word output. abcdeifghj
        codedWordOutNewDataStrobe => codedWordOutNewDataStrobe -- New data in codedWordOut available
    );    
    
    -- ledOut : process(clkHalfDR)
    -- begin
        -- if(reset='1') then
            -- LED(9 downto 0) <= (others => '0');
        -- elsif(clkHalfDR'event and clkHalfDR='1') then
            -- if(codedWordOutNewDataStrobe='1' and codedWordOut(9)='1') then
                -- LED(9 downto 0) <= codedWordOut;
            -- end if;
            -- LED(10) <= codedWordOutNewDataStrobe;
            -- LED(11) <= codedWordOutNewDataStrobe;
            -- LED(12) <= codedWordOutNewDataStrobe;
        -- end if;
    -- end process;      
    
    -- ledOut : process(clkHalfDR,reset)
    -- begin
        -- if(reset='1') then
            -- LED(12 downto 0) <= (others => '0');
        -- elsif(clkHalfDR'event and clkHalfDR='1') then
            -- if(decoderNewDataStrobe='1') then
                -- LED(7 downto 0) <= decoderWordOut;
                -- LED(8) <= decoderKOut;
                -- LED(9) <= decoderDispErr;
                -- LED(10) <= decoderCodeErr;
            -- end if;
            -- LED(11) <= decoderNewDataStrobe;
            -- LED(12) <= codedWordOutNewDataStrobe;
        -- end if;
    -- end process;   
    -- LED(15) <= reset;
    -- LED(14 downto 13) <= (others => '0');
    
----------------------------------------------------------------------------------------------------------------------    
-- 8b10b decoder
    decode_8b10b_inst : entity decode_8b10b.decode_8b10b_top
    generic map(
        C_DECODE_TYPE => ASYNCH_SERCOMM_8b10b_USE_BRAM, --1=BRAM basiert, 0=LUT
        C_ELABORATION_DIR => "./",  --Verzeichnis für BRAM-Init File
        C_HAS_BPORTS => 0,          --Einzelner Dekoder
        C_HAS_CE => 1,              --Clock Enable
        C_HAS_CODE_ERR => 1,
        C_HAS_DISP_ERR => 1,
        C_HAS_DISP_IN => 0,
        C_HAS_ND => 1,              --NewData Output 
        C_HAS_RUN_DISP => 0,        --rundDisp Output
        C_HAS_SINIT => 0,           --Synchronous Init Pin
        C_HAS_SYM_DISP => 0,
        C_SINIT_VAL => "0000000000",
        C_SINIT_VAL_B => "0000000000"
    )
    port map(
        CLK        => clkHalfDR,
        DIN(0)     => codedWordOut(9), --a
        DIN(1)     => codedWordOut(8), --b
        DIN(2)     => codedWordOut(7), --c
        DIN(3)     => codedWordOut(6), --d
        DIN(4)     => codedWordOut(5), --e
        DIN(5)     => codedWordOut(4), --i
        DIN(6)     => codedWordOut(3), --f
        DIN(7)     => codedWordOut(2), --g
        DIN(8)     => codedWordOut(1), --h
        DIN(9)     => codedWordOut(0), --j
        CE         => codedWordOutNewDataStrobe,

        DOUT       => decoderWordOutFast,
        KOUT       => decoderKOutFast,
        CODE_ERR   => decoderCodeErrFast,
        DISP_ERR   => decoderDispErrFast,
        ND         => decoderNewDataStrobeFast
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
                    decoderWordOutSlow <= decoderWordOutFast;
                    decoderKOutSlow <= decoderKOutFast;
                    decoderCodeErrSlow <= decoderCodeErrFast;
                    decoderDispErrSlow <= decoderDispErrFast;
                    decoderNewDataStrobeSlow <= decoderNewDataStrobeFast or decoderNewDataStrobeFastLatched;
                    decoderNewDataStrobeFastLatched <= '0';
                elsif(decoderNewDataStrobeFast='1') then
                    decoderNewDataStrobeFastLatched <= '1';
                end if;
            end if;
        end process;
    end generate;
    
    NoClkDomainTransfer_generate : if(CLK_COMM_INTERFACE_DIV=1) generate
        decoderWordOutSlow <= decoderWordOutFast;
        decoderKOutSlow <= decoderKOutFast;
        decoderCodeErrSlow <= decoderCodeErrFast;
        decoderDispErrSlow <= decoderDispErrFast;
        decoderNewDataStrobeSlow <= decoderNewDataStrobeFast;
    end generate;    

end Behavioral;

