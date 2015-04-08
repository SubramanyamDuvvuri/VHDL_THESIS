----------------------------------------------------------------------------------
-- Company:         DFKI Bremen
-- Engineer:        Florian Hühn
-- 
-- Create Date:     10:18:14 10.12.2013
-- Design Name: 
-- Module Name:     basic_clk_reset_mod
-- Project Name: 
-- Target Devices:  Series7 Family. Tested von XC7Z020-1DG484
-- Tool versions: 
-- Description:     Basic reconditioning of incoming clock signal.
--                  Since external clock souces a subject to several noise sources
--                  and exhibit a severe amout of phase, frequency and duty
--                  cycle jitter they sould always be cleand by a pll. See
--                  Xilinx UG382.
--
--                  Of course you should adapt the clock frequencies to your
--                  needs. You can produce up to 6 diffent clock signals with a
--                  fixed frequency and phase alignment to each other.
--
--                  Switching characteristics for Spantan6 SpeedGrade -1:
--                  F_{in}: 19MHz - 800MHz
--                  F_[vco}: 800MHz - 1600MHz
--                  F_{pfd}: 19MHz - 450MHz
--                  F_{bw_low}: 1MHz
--                  F_{bw_high}: 4MHz
--                  F_{out_max_bufg}: 625MHz
--                  F_{out_min}: 6.25MHz
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.02 - Adapted from Spratan6 to Series7
-- Revision 0.01 - File Created
-- Additional Comments: 
--                  With very high EMI the PLL might loose lock (intended behavior).
--                  Even though a system reset is recommended in this case because
--                  the clock signals properties doesn't match the asumptions of
--                  the synthesis tools anymore, this might not always be the
--                  desired behavior.
--
----------------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;
use     IEEE.NUMERIC_STD.ALL;
Library UNISIM;
use     UNISIM.vcomponents.all;
use     work.asynch_sercomm_config_pack.all;


entity basic_clk_reset_mod is
    Port(
        clk_in : in  STD_LOGIC;             -- Input clock from local oscillator
        nreset_in : in  STD_LOGIC;          -- Input Pin not_reset
        
        clkFullDR : out STD_LOGIC;          -- Datarate on GCLK network
        clkHalfDR : out  STD_LOGIC;         -- Datarate/2 on GCLK network
        clkCommInterface : out STD_LOGIC;   -- Clock for interface to async_sercomm*top
        clk20MHz : out  STD_LOGIC;          -- Clean 20MHz output
        clk200MHz : out  STD_LOGIC;         -- 200MHz output (delay line calibration clock)

        reset : out  STD_LOGIC              -- Global reset output (synchronous to clkHalfDR and clkCommInterface)
    );
end basic_clk_reset_mod;

architecture Behavioral of basic_clk_reset_mod is

signal pll_fb : std_logic;
signal pll_out0 : std_logic;
signal pll_out1 : std_logic;
signal pll_out2 : std_logic;
signal pll_out3 : std_logic;
signal pll_out4 : std_logic;
signal pll_locked : std_logic;

signal clk20MHz_bufg : std_logic;
signal clk200MHz_bufg : std_logic;
signal clkHalfDR_bufg : std_logic;
signal clkCommInterface_bufg : std_logic;

signal startupResetCounter : natural range 0 to 15 := 0;
alias resetClk1 : std_logic is clkHalfDR_bufg;
alias resetClk2 : std_logic is clkCommInterface_bufg;

signal inverted_nreset_in : std_logic;

constant CLK_20M_PLLDIV : natural := CLK_PLLFREQ/20e6;

begin
    assert false report "asynch_sercomm: PLL Frequency is "&real'image(real(CLK_PLLFREQ)/real(1e6))&"MHz." severity note;
    assert false report "asynch_sercomm: Datarate is "&real'image(real(ASNYCH_SERCOM_DATARATE)/real(1e6))&"MSym/s." severity note;
    assert false report "asynch_sercomm: Frequency of internal Communication interface is "&real'image(real(CLK_PLLFREQ)/real(CLK_COMM_INTERFACE_PLLDIV)/real(1e6))&"MHz." severity note;
    assert ((CLK_COMM_INTERFACE_DIV >= 1) and (CLK_COMM_INTERFACE_DIV <= 4)) report "asynch_sercomm: CLK_COMM_INTERFACE_DIV is not in the interval [1, 4]" severity failure;
    
    assert (integer(real(CLK_PLLFREQ)/real(CLK_200M_PLLDIV))/=ASYNCH_SERCOMM_ISERDES_REFCLK_FREQ) report "asynch_sercomm: Delay line calibration clock frequency is actually "&real'image(real(CLK_PLLFREQ)/real(CLK_200M_PLLDIV)/real(1e6))&"MHz." severity warning;
    assert (((integer(real(CLK_PLLFREQ)/real(CLK_200M_PLLDIV))>=190e6) and (integer(real(CLK_PLLFREQ)/real(CLK_200M_PLLDIV))<=210e6)) or ((integer(real(CLK_PLLFREQ)/real(CLK_200M_PLLDIV))>=290e6) and (integer(real(CLK_PLLFREQ)/real(CLK_200M_PLLDIV))<=310e6))) report "asynch_sercomm: Delay line calibration clock frequency is outside its boundaries of [190;210]MHz or [290;310]MHz" severity failure;
    assert (integer(real(CLK_PLLFREQ)/real(CLK_20M_PLLDIV))/=20e6) report "asynch_sercomm: 20MHz clock frequency is actually "&real'image(real(CLK_PLLFREQ)/real(CLK_20M_PLLDIV)/real(1e6))&"MHz." severity warning;

    inverted_nreset_in <= not nreset_in;
    
    clkHalfDR <= clkHalfDR_bufg;
    clkCommInterface <= clkCommInterface_bufg;
    clk20MHz <= clk20MHz_bufg;
    clk200MHz <= clk200MHz_bufg;
    
----------------------------------------------------------------------------------------------------------------------    
-- Taktaufbereitung
    PLLE2_BASE_inst : PLLE2_BASE
    generic map (
        BANDWIDTH => "LOW",                 -- "HIGH", "LOW" or "OPTIMIZED" 
        CLKFBOUT_MULT => CLK_LO_PLLMULTIP,  -- Multiply value for all CLKOUT clock outputs (1-64)
        CLKFBOUT_PHASE => 0.0,              -- Phase offset in degrees of the clock feedback output (0.0-360.0).
        CLKIN1_PERIOD => CLK_LO_PERIOD_NS,  -- Input clock period in ns to ps resolution (i.e. 33.333 is 30MHz).
        -- CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: Divide amount for CLKOUT# clock output (1-128)
        CLKOUT0_DIVIDE => CLK_FULL_DR_PLLDIV,           --1600->320
        CLKOUT1_DIVIDE => CLK_HALF_DR_PLLDIV,           --1600->160
        CLKOUT2_DIVIDE => CLK_COMM_INTERFACE_PLLDIV,    --1600->40
        CLKOUT3_DIVIDE => CLK_20M_PLLDIV,               --1600->20
        CLKOUT4_DIVIDE => CLK_200M_PLLDIV,              --1600->200       
        CLKOUT5_DIVIDE => 25,
        -- CLKOUT0_DUTY_CYCLE - CLKOUT5_DUTY_CYCLE: Duty cycle for CLKOUT# clock output (0.001-0.999).
        CLKOUT0_DUTY_CYCLE => 0.5,
        CLKOUT1_DUTY_CYCLE => 0.5,
        CLKOUT2_DUTY_CYCLE => 0.5,
        CLKOUT3_DUTY_CYCLE => 0.5,
        CLKOUT4_DUTY_CYCLE => 0.5,
        CLKOUT5_DUTY_CYCLE => 0.5,
        -- CLKOUT0_PHASE - CLKOUT5_PHASE: Output phase relationship for CLKOUT# clock output (-360.0-360.0).
        CLKOUT0_PHASE => 0.0,
        CLKOUT1_PHASE => 0.0,
        CLKOUT2_PHASE => 0.0,
        CLKOUT3_PHASE => 0.0,
        CLKOUT4_PHASE => 0.0,
        CLKOUT5_PHASE => 0.0,
        DIVCLK_DIVIDE => 1,                 -- Division value for all output clocks (1-56)
        REF_JITTER1 => 0.1,                 -- Reference Clock Jitter in UI (0.000-0.999).
        STARTUP_WAIT => "FALSE"             -- Delay DONE until PLL Locks, ("TRUE"/"FALSE")
    )
    port map (
        -- CLKOUT0 - CLKOUT5: 1-bit (each) output: Clock outputs
        CLKOUT0 => pll_out0,
        CLKOUT1 => pll_out1,
        CLKOUT2 => pll_out2,
        CLKOUT3 => pll_out3,
        CLKOUT4 => pll_out4,
        CLKOUT5 => open,
        CLKFBOUT => pll_fb,                 -- 1-bit outpur: Feedback clock
        CLKFBIN => pll_fb,                  -- 1-bit input: Feedback clock
        LOCKED => pll_locked,               -- 1-bit output: PLL_BASE lock status output
        CLKIN1 => clk_in,                   -- 1-bit input: Clock input
        PWRDWN => '0',                      -- 1-bit input: Power-down
        RST => inverted_nreset_in           -- 1-bit input: Reset input
    );

    BUFG_0_inst : BUFG
    port map (
        O => clkFullDR,                     -- 1-bit output: Clock buffer output
        I => pll_out0                       -- 1-bit input: Clock buffer input
    );
    
    BUFG_1_inst : BUFG
    port map (
        O => clkHalfDR_bufg,                -- 1-bit output: Clock buffer output
        I => pll_out1                       -- 1-bit input: Clock buffer input
    );

    BUFG_2_inst : BUFG
    port map (
        O => clkCommInterface_bufg,         -- 1-bit output: Clock buffer output
        I => pll_out2                       -- 1-bit input: Clock buffer input
    );
    
    BUFG_3_inst : BUFG
    port map (
        O => clk20MHz_bufg,                 -- 1-bit output: Clock buffer output
        I => pll_out3                       -- 1-bit input: Clock buffer input
    );
    
    BUFG_4_inst : BUFG
    port map (
        O => clk200MHz_bufg,                -- 1-bit output: Clock buffer output
        I => pll_out4                       -- 1-bit input: Clock buffer input
    );   
----------------------------------------------------------------------------------------------------------------------    
-- Resetzeugs
    --StartupReset. Sinn und Zweck des ganzen:
    --Wenn das Bitfile direkt per JTAG in den FPGA geschoben wird, kann nicht garantiert werden, dass
    --der externe Reset-Pin ausgelöst wird. Um dennoch mit einem definierten Reset-Zustand zu
    --starten wird hier nochmal für 16 Takte lang ein Reset erzeugt.
    --Zusätzlich wird gewartet, bis die PLL stabil ist. Wenn die PLL ihren lock verliert wird auch resettet.
    startupReset_proc : process(resetClk1,resetClk2,pll_locked,nreset_in)
    begin
        if(pll_locked='0' or nreset_in='0') then
            -- Warten bis die PLL stabil ist
            -- Asynchroner reset wichtig, da die CLK von genau dieser PLL kommt
            startupResetCounter <= 0;
            reset <= '1';
        elsif(resetClk1'event and resetClk1='1') then
            if(resetClk2'event and resetClk2='1') then
                if(startupResetCounter=15) then
                    reset <= '0';
                else
                    startupResetCounter <= startupResetCounter+1;
                    reset <= '1';
                end if;
            end if;
        end if;
    end process;

end Behavioral;

