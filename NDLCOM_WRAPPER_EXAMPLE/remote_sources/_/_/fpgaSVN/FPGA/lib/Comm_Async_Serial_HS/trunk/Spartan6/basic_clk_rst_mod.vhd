----------------------------------------------------------------------------------
-- Company:         DFKI Bremen
-- Engineer:        Florian Hühn
--
-- Create Date:     10:47:59 12/27/2012
-- Design Name:
-- Module Name:     basic_clk_reset_mod
-- Project Name:
-- Target Devices:  Spartan6
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
--                  Switching characteristics for Spantan6 SpeedGrade -2:
--                  F_{in}: 19MHz - 450MHz
--                  F_[vco}: 400MHz - 1000MHz
--                  F_{pfd}: 19MHz - 400MHz
--                  F_{bw_low}: 1MHz
--                  F_{bw_high}: 4MHz
--                  F_{out_max_bufg}: 375MHz
--                  F_{out_max_bufpll}: 950MHz
--                  F_{out_min}: 3.125MHz
--
-- Dependencies:
--
-- Revision:
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
library work;
use     work.asynch_sercomm_config_pack.all;


entity basic_clk_reset_mod is
    Port ( clk20MHz_in : in  STD_LOGIC;         -- Input clock from local oscillator 20MHz
           nreset_in : in  STD_LOGIC;           -- Input Pin not_reset
           clkDoubleDR_io : out STD_LOGIC;      -- Datarate*2 on IO Clock network
           clkDoubleDR_ioce : out STD_LOGIC;    -- Datarate*2 to Datarate/2 clock domain transfer strobe signal
           clkHalfDR : out  STD_LOGIC;          -- Datarate/2 on GCLK network
           clkCommInterface : out STD_LOGIC;    -- Clock for interface to async_sercomm*top
           clk20MHz : out  STD_LOGIC;           -- Clean 20MHz output

           reset : out  STD_LOGIC               -- Global reset output
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
signal clkHalfDR_bufg : std_logic;
signal clkCommInterface_bufg : std_logic;

signal startupResetCounter : natural range 0 to 15 := 0;
alias resetClk : std_logic is clkCommInterface_bufg;

constant CLK_20M_PLLDIV : natural := CLK_PLLFREQ/20e6;

begin
    assert false report "asynch_sercomm: PLL Frequency is "&real'image(real(CLK_PLLFREQ)/real(1e6))&"MHz." severity note;
    assert false report "asynch_sercomm: Datarate is "&real'image(real(ASNYCH_SERCOM_DATARATE)/real(1e6))&"MSym/s." severity note;
    assert false report "asynch_sercomm: Frequency of internal Communication interface is "&real'image(real(CLK_PLLFREQ)/real(CLK_COMM_INTERFACE_PLLDIV)/real(1e6))&"MHz." severity note;
    assert ((CLK_COMM_INTERFACE_DIV >= 1) and (CLK_COMM_INTERFACE_DIV <= 4)) report "asynch_sercomm: CLK_COMM_INTERFACE_DIV is not in the interval [1, 4]" severity failure;

    assert (integer(real(CLK_PLLFREQ)/real(CLK_20M_PLLDIV))/=20e6) report "20MHz clock frequency is actually "&real'image(real(CLK_PLLFREQ)/real(CLK_20M_PLLDIV)/real(1e6))&"MHz." severity warning;

    clkHalfDR <= clkHalfDR_bufg;
    clkCommInterface <= clkCommInterface_bufg;
    clk20MHz <= clk20MHz_bufg;

----------------------------------------------------------------------------------------------------------------------
-- Taktaufbereitung
    PLL_BASE_inst : PLL_BASE
    generic map (
        BANDWIDTH => "LOW",                 -- "HIGH", "LOW" or "OPTIMIZED"
        CLKFBOUT_MULT => CLK_LO_PLLMULTIP,  -- Multiply value for all CLKOUT clock outputs (1-64)
        CLKFBOUT_PHASE => 0.0,              -- Phase offset in degrees of the clock feedback output (0.0-360.0).
        CLKIN_PERIOD => CLK_LO_PERIOD_NS,   -- Input clock period in ns to ps resolution (i.e. 33.333 is 30MHz).
        -- CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: Divide amount for CLKOUT# clock output (1-128)
        CLKOUT0_DIVIDE => CLK_DOUBLE_DR_PLLDIV,         --1000->1000
        CLKOUT1_DIVIDE => CLK_HALF_DR_PLLDIV,           --1000->250
        CLKOUT2_DIVIDE => CLK_COMM_INTERFACE_PLLDIV,    --1000->88.333
        CLKOUT3_DIVIDE => CLK_20M_PLLDIV,               --1000->20
        CLKOUT4_DIVIDE => 25,
        CLKOUT5_DIVIDE => 25,
        -- CLKOUT0_DUTY_CYCLE - CLKOUT5_DUTY_CYCLE: Duty cycle for CLKOUT# clock output (0.01-0.99).
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
        CLK_FEEDBACK => "CLKFBOUT",         -- Clock source to drive CLKFBIN ("CLKFBOUT" or "CLKOUT0")
        COMPENSATION => "INTERNAL",         -- "SYSTEM_SYNCHRONOUS", "SOURCE_SYNCHRONOUS", "EXTERNAL"
        DIVCLK_DIVIDE => 1,                 -- Division value for all output clocks (1-52)
        REF_JITTER => 0.1,                  -- Reference Clock Jitter in UI (0.000-0.999).
        RESET_ON_LOSS_OF_LOCK => FALSE      -- Must be set to FALSE
    )
    port map (
        CLKFBOUT => pll_fb,                 -- 1-bit output: PLL_BASE feedback output
        -- CLKOUT0 - CLKOUT5: 1-bit (each) output: Clock outputs
        CLKOUT0 => pll_out0,
        CLKOUT1 => pll_out1,
        CLKOUT2 => pll_out2,
        CLKOUT3 => pll_out3,
        CLKOUT4 => pll_out4,
        CLKOUT5 => open,
        LOCKED => pll_locked,               -- 1-bit output: PLL_BASE lock status output
        CLKFBIN => pll_fb,                  -- 1-bit input: Feedback clock input
        CLKIN => clk20MHz_in,               -- 1-bit input: Clock input
        RST => not nreset_in                -- 1-bit input: Reset input
    );

    BUFPLL_0_inst : BUFPLL
    generic map (
        DIVIDE => 4,                        -- DIVCLK divider (1-8)
        ENABLE_SYNC => TRUE                 -- Enable synchrnonization between PLL and GCLK (TRUE/FALSE)
    )
    port map (
        IOCLK => clkDoubleDR_io,            -- 1-bit output: Output I/O clock
        LOCK => open,                       -- 1-bit output: Synchronized LOCK output
        SERDESSTROBE => clkDoubleDR_ioce,   -- 1-bit output: Output SERDES strobe (connect to ISERDES2/OSERDES2)
        GCLK => clkHalfDR_bufg,             -- 1-bit input: BUFG clock input
        LOCKED => pll_locked,               -- 1-bit input: LOCKED input from PLL
        PLLIN => pll_out0                   -- 1-bit input: Clock input from PLL
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

----------------------------------------------------------------------------------------------------------------------
-- Resetzeugs
    --StartupReset. Sinn und Zweck des ganzen:
    --Wenn das Bitfile direkt per JTAG in den FPGA geschoben wird, kann nicht garantiert werden, dass
    --der externe Reset-Pin ausgelöst wird. Um dennoch mit einem definierten Reset-Zustand zu
    --starten wird hier nochmal für 16 Takte lang ein Reset erzeugt.
    --Zusätzlich wird gewartet, bis die PLL stabil ist. Wenn die PLL ihren lock verliert wird auch resettet.
    startupReset_proc : process(resetClk,pll_locked,nreset_in)
    begin
        if(pll_locked='0' or nreset_in='0') then
            -- Warten bis die PLL stabil ist
            -- Asynchroner reset wichtig, da die CLK von genau dieser PLL kommt
            startupResetCounter <= 0;
            reset <= '1';
        elsif(resetClk'event and resetClk='1') then
            if(startupResetCounter=15) then
                reset <= '0';
            else
                startupResetCounter <= startupResetCounter+1;
                reset <= '1';
            end if;
        end if;
    end process;

end Behavioral;
