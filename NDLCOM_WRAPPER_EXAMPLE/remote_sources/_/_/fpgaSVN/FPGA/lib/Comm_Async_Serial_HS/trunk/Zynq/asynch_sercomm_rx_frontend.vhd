----------------------------------------------------------------------------------
-- Company:         DFKI Bremen
-- Engineer:        Florian Hühn
-- 
-- Create Date:     10:18:14 10.12.2013
-- Design Name: 
-- Module Name:     asynch_sercomm_rx_frontend - Behavioral 
-- Project Name: 
-- Target Devices:  Series7 Family. Tested von XC7Z020-1DG484
-- Tool versions: 
-- Description: 
--                  Empfangsteil für schnelle, asynchrone Kommunikation mit
--                  4-fach Überabtastung.
--                  Ausgelegt auf 8b10b-Code. Synchronisiert sich auf das Comma-
--                  Wort "0011111" bzw "1100000" und gibt anschließend die
--                  synchronisierten 10bit Worte parallel aus.
--                  Zwecks Synchronisation ist das Wort K28.7 verboten!
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.02 - Adapted from Spratan6 to Series7
-- Revision 0.01 - File Created
-- Additional Comments: 
--                  Late Sampling Variante
--
----------------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

package asynch_sercomm_rx_frontend_pack is
    function calc_tap_value ( DATARATE : natural; IDELAY_REFCLK_FREQ_MHZ : real ) return natural;
end asynch_sercomm_rx_frontend_pack;
package body asynch_sercomm_rx_frontend_pack is
    -- Definition of Delay-Values. Wanted Delay in seconds is 1/(Datarate[Hz]*4)
    function calc_tap_value ( DATARATE : natural; IDELAY_REFCLK_FREQ_MHZ : real ) return natural is
        variable tmp : natural := 0;
    begin
           if(DATARATE=320_000_000 and IDELAY_REFCLK_FREQ_MHZ=200.0) then tmp:= 10; --Rechnerisch: 10=> 781.25ps;  781.25ps soll
        elsif(DATARATE=100_000_000 and IDELAY_REFCLK_FREQ_MHZ=200.0) then tmp:= 32; --Rechnerisch: 32=>2500.00ps; 2500.00ps soll; Nicht real überprüft
        elsif(DATARATE=240_000_000 and IDELAY_REFCLK_FREQ_MHZ=200.0) then tmp:= 13; --Rechnerisch: 13=>1015.62ps; 1041.67ps soll; Nicht real überprüft
        elsif(DATARATE=240_000_000 and IDELAY_REFCLK_FREQ_MHZ=300.0) then tmp:= 20; --Rechnerisch: 20=>1041.67ps; 1041.67ps soll; Nicht real überprüft
        elsif(DATARATE=500_000_000 and IDELAY_REFCLK_FREQ_MHZ=300.0) then tmp:= 10; --Rechnerisch: 10=> 520.83ps;  500.00ps soll; Nicht real überprüft
        else tmp:= 0; end if;
        -- Beim Zynq können die Tap-Werte berechnet werden, da der Chip seine Taps permanent anhand der Refclk nachkalibriert.
        -- Refclk=200MHz => 78.125ps/tap
        -- Refclk=300MHz => 52.083333ps/tap
        -- Zumindest für Refclk=200MHz udn 300MHz gilt tap_delay=1/(Refclk_freq*64)
        
        -- 
        -- To check resulting delay time for a given TAP Value in a particular design:
        -- Use Xilinx Timing Analyzer:
        -- Open Design
        -- Run timing analysis
        -- user specified paths by defining endpoints
        -- from: *rxLine*, to: *serdata1_*
        -- OK
        -- Check Delay difference between (rxLine->serdata1_master) and (rxLine->serdata1_slave)
        -- to match 1/(Datarate*4)
        
        -- Die Realität beim Spartan6 sagt: Die Fehlerraten gehen runter, wenn man den TAP-Value höher setzt als der Timing
        -- Analyzer sagt. Der Analyzer rechnet aber auch mit 1.14V VCore und 85°C Umgebungstemp.
        
        -- Zynq: Die werte des Timing analyzer stimmen nicht so ganz. In der realität ist er dank Refclk deutlich genauer an den errechneten Werten.
        
        return tmp;
    end calc_tap_value;
end asynch_sercomm_rx_frontend_pack;



library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;
use     IEEE.NUMERIC_STD.ALL;
library UNISIM;
use     UNISIM.VComponents.all;
use     work.asynch_sercomm_rx_frontend_pack.all;

entity asynch_sercomm_rx_frontend is
    generic (
            DATARATE : natural := 320_000_000;      -- Communication Datarate [Symbols/sec]
            IDELAY_REFCLK_FREQ_MHZ : real := 200.0; -- Actual speed of IDELAYCTRL Refclk (190.0-210.0 or 290.0-310.0@Speedgrade 2 and 3) [MHz]
            INSTANTIATE_IDELAYCTRL : boolean := true-- Instantiate IDELAYCTRL
        );
    port (
            clkFullDR : in  std_logic;          -- Datarate, gclk network
            clkHalfDR : in  std_logic;          -- Datarate/2, gclk network
            clk200MHz : in std_logic;           -- 200MHz delay line calibration clock
            reset : in std_logic;               -- Global reset, has to be aligned with clkHalfDR
            rxLineP : in std_logic;             -- P-Output of IBUFDS_DIFF_OUT
            rxLineN : in std_logic;             -- N-Output of IBUFDS_DIFF_OUT
            codedWordOut : out std_logic_vector(9 downto 0) := (others => '0'); -- Word output. abcdeifghj
            codedWordOutNewDataStrobe : out std_logic := '0' -- New data in codedWordOut available
        );
end asynch_sercomm_rx_frontend;

architecture Behavioral of asynch_sercomm_rx_frontend is
-- Constants
constant QUARTER_SYM_DELAY_TAPS : natural := calc_tap_value(DATARATE, IDELAY_REFCLK_FREQ_MHZ);


-- Rx Sampling
signal serdata1_master : std_logic;
signal serdata1_slave : std_logic;

signal iserdesSamples : std_logic_vector(7 downto 0);
signal rawSamples : std_logic_vector(7 downto 0);

--SamplePointDecision
signal rawSamplesHistory : std_logic_vector(7 downto 0);
type samplepoint_t is (edgeBeforeSP0, edgeBeforeSP1, edgeBeforeSP2, edgeBeforeSP3);
signal activeSamplePoint : samplepoint_t := edgeBeforeSP0;
signal BitSlipNeg : std_logic := '0';
signal BitSlipPos : std_logic := '0';

--SamplePointSelection
signal BitOutMinus1 : std_logic := '0';
signal BitOutMinus1Valid : std_logic := '0';
signal BitOut0 : std_logic := '0';
signal BitOut0Valid : std_logic := '0';
signal BitOut1 : std_logic := '0';

--Deserialisation and Synchronisation (Pipelined damits schnell bleibt)
-- deserialisation
signal dataStreamSRStage0 : std_logic_vector(11 downto 0) := (others => '0');
signal movedByOneStage0 : std_logic := '0';
signal movedByThreeStage0 : std_logic := '0';

-- syncWordDetection
signal dataStreamSRStage1 : std_logic_vector(dataStreamSRStage0'high downto dataStreamSRStage0'low) := (others => '0');
signal movedByOneStage1 : std_logic := '0';
signal movedByThreeStage1 : std_logic := '0';
signal syncAtPos11Stage1 : std_logic := '0';
signal syncAtPos10Stage1 : std_logic := '0';
signal syncAtPos09Stage1 : std_logic := '0';

-- synchronisation
signal dataStreamSRStage2 : std_logic_vector(dataStreamSRStage1'high downto dataStreamSRStage1'low) := (others => '0');
signal startOfCodedWordSR : std_logic_vector(dataStreamSRStage2'high downto dataStreamSRStage2'low+2) := (others => '0');

-- codedWordParallelOutput
signal multipleDetectCounter : natural range 0 to 3 := 0;
--signal codedWordOut : std_logic_vector(9 downto 0) := (others => '0'); --abcdeifghj
--signal codedWordOutNewDataStrobe : std_logic := '0';


-- attribute IODELAY_GROUP : STRING;
-- attribute IODELAY_GROUP of delay_control_inst: label is "HsComm_rx_delay_group";
-- attribute IODELAY_GROUP of delay1_master_inst: label is "HsComm_rx_delay_group";
-- attribute IODELAY_GROUP of delay1_slave_inst: label is "HsComm_rx_delay_group";

begin
    assert(QUARTER_SYM_DELAY_TAPS>=4 or QUARTER_SYM_DELAY_TAPS=0) report "asynch_sercomm_rx_frontend: Datanrate zu hoch, Verzögerungsleitung wird zu kurz!" severity FAILURE;
    assert(QUARTER_SYM_DELAY_TAPS/=0) report "asynch_sercomm_rx_frontend: Verzögerungswert zur gewünschten Datenrate unbekannt! Datarate="&real'image(real(DATARATE)/real(1e6))&", Refclk="&real'image(real(IDELAY_REFCLK_FREQ_MHZ))&"Mhz" severity FAILURE;
    assert(QUARTER_SYM_DELAY_TAPS<=31) report "asynch_sercomm_rx_frontend: Datanrate zu niedrig, Verzögerung zu groß!" severity FAILURE;

----------------------------------------------------------------------------------------------------------------------    
-- Rx Sampling   
  
    -- SE geht nur mit P-Pins, zugehörige N-Pins können dann nur als normaler Asych-IO genutzt werden.
    
    -- Für jede Region des FPGAs in der ein IDELAY benutzt wird, muss ein IDELAYCTRL genutzt werden
    idelayctrl_generate : if(INSTANTIATE_IDELAYCTRL=true) generate
    delay_control_inst : IDELAYCTRL
    port map (
        RDY => open,            -- 1-bit output: Ready output
        REFCLK => clk200MHz,    -- 1-bit input: Reference clock input
        RST => reset            -- 1-bit input: Active high reset input
    );
    end generate;

    -- Verzögerungsleitungen
    delay1_master_inst : IDELAYE2
    generic map (
        CINVCTRL_SEL => "FALSE",          -- Enable dynamic clock inversion (FALSE, TRUE)
        DELAY_SRC => "IDATAIN",           -- Delay input (IDATAIN, DATAIN)
        HIGH_PERFORMANCE_MODE => "FALSE", -- Reduced jitter ("TRUE"), Reduced power ("FALSE")
        IDELAY_TYPE => "FIXED",           -- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
        IDELAY_VALUE => 0,                -- Input delay tap setting (0-31)
        PIPE_SEL => "FALSE",              -- Select pipelined mode, FALSE, TRUE
        REFCLK_FREQUENCY => IDELAY_REFCLK_FREQ_MHZ, -- IDELAYCTRL clock input frequency in MHz (190.0-210.0).
        SIGNAL_PATTERN => "DATA"          -- DATA, CLOCK input signal
    )
    port map (
        CNTVALUEOUT => open,            -- 5-bit output: Counter value output
        DATAOUT => serdata1_master,     -- 1-bit output: Delayed data output
        C => '0',                       -- 1-bit input: Clock input
        CE => '0',                      -- 1-bit input: Active high enable increment/decrement input
        CINVCTRL => '0',                -- 1-bit input: Dynamic clock inversion input
        CNTVALUEIN => (others => '0'),  -- 5-bit input: Counter value input
        DATAIN => '0',                  -- 1-bit input: Internal delay data input
        IDATAIN => rxLineP,             -- 1-bit input: Data input from the I/O
        INC => '0',                     -- 1-bit input: Increment / Decrement tap delay input
        LD => '0',                      -- 1-bit input: Load IDELAY_VALUE input
        LDPIPEEN => '0',                -- 1-bit input: Enable PIPELINE register to load data input
        REGRST => '0'                   -- 1-bit input: Active-high reset tap-delay input
    );
   
    delay1_slave_inst : IDELAYE2
    generic map (
        CINVCTRL_SEL => "FALSE",          -- Enable dynamic clock inversion (FALSE, TRUE)
        DELAY_SRC => "IDATAIN",           -- Delay input (IDATAIN, DATAIN)
        HIGH_PERFORMANCE_MODE => "FALSE", -- Reduced jitter ("TRUE"), Reduced power ("FALSE")
        IDELAY_TYPE => "FIXED",           -- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
        IDELAY_VALUE => QUARTER_SYM_DELAY_TAPS,    -- Input delay tap setting (0-31)
        PIPE_SEL => "FALSE",              -- Select pipelined mode, FALSE, TRUE
        REFCLK_FREQUENCY => IDELAY_REFCLK_FREQ_MHZ, -- IDELAYCTRL clock input frequency in MHz (190.0-210.0).
        SIGNAL_PATTERN => "DATA"          -- DATA, CLOCK input signal
    )
    port map (
        CNTVALUEOUT => open,            -- 5-bit output: Counter value output
        DATAOUT => serdata1_slave,      -- 1-bit output: Delayed data output
        C => '0',                       -- 1-bit input: Clock input
        CE => '0',                      -- 1-bit input: Active high enable increment/decrement input
        CINVCTRL => '0',                -- 1-bit input: Dynamic clock inversion input
        CNTVALUEIN => (others => '0'),  -- 5-bit input: Counter value input
        DATAIN => '0',                  -- 1-bit input: Internal delay data input
        IDATAIN => rxLineN,             -- 1-bit input: Data input from the I/O
        INC => '0',                     -- 1-bit input: Increment / Decrement tap delay input
        LD => '0',                      -- 1-bit input: Load IDELAY_VALUE input
        LDPIPEEN => '0',                -- 1-bit input: Enable PIPELINE register to load data input
        REGRST => '0'                   -- 1-bit input: Active-high reset tap-delay input
    );
    
    -- Deserialisierer
    serdes1_master_inst : ISERDESE2
    generic map (
        DATA_RATE => "DDR",           -- DDR, SDR
        DATA_WIDTH => 4,              -- Parallel data width (2-8,10,14)
        DYN_CLKDIV_INV_EN => "FALSE", -- Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
        DYN_CLK_INV_EN => "FALSE",    -- Enable DYNCLKINVSEL inversion (FALSE, TRUE)
        -- INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
        INIT_Q1 => '0',
        INIT_Q2 => '0',
        INIT_Q3 => '0',
        INIT_Q4 => '0',
        INTERFACE_TYPE => "NETWORKING",   -- MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
        IOBDELAY => "IFD",           -- NONE, BOTH, IBUF, IFD
        NUM_CE => 1,                  -- Number of clock enables (1,2)
        OFB_USED => "FALSE",          -- Select OFB path (FALSE, TRUE)
        SERDES_MODE => "MASTER",      -- MASTER, SLAVE
        -- SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
        SRVAL_Q1 => '0',
        SRVAL_Q2 => '0',
        SRVAL_Q3 => '0',
        SRVAL_Q4 => '0' 
    )
    port map (
        O => open,                    -- 1-bit output: Combinatorial output
        -- Q1 - Q8: 1-bit (each) output: Registered data outputs
        Q1 => iserdesSamples(7),
        Q2 => iserdesSamples(5),
        Q3 => iserdesSamples(3),
        Q4 => iserdesSamples(1),
        Q5 => open,
        Q6 => open,
        Q7 => open,
        Q8 => open,
        -- SHIFTOUT1-SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
        SHIFTOUT1 => open,
        SHIFTOUT2 => open,
        BITSLIP => '0',               -- 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
                                      -- CLKDIV when asserted (active High). Subsequently, the data seen on the
                                      -- Q1 to Q8 output ports will shift, as in a barrel-shifter operation, one
                                      -- position every time Bitslip is invoked (DDR operation is different from
                                      -- SDR).
        -- CE1, CE2: 1-bit (each) input: Data register clock enable inputs
        CE1 => '1',
        CE2 => '1',
        CLKDIVP => '0',               -- 1-bit input: TBD
        -- Clocks: 1-bit (each) input: ISERDESE2 clock input ports
        CLK => clkFullDR,        -- 1-bit input: High-speed clock
        CLKB => not clkFullDR,   -- 1-bit input: High-speed secondary clock
        CLKDIV => clkHalfDR,          -- 1-bit input: Divided clock
        OCLK => '0',                  -- 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
        -- Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
        DYNCLKDIVSEL => '0',          -- 1-bit input: Dynamic CLKDIV inversion
        DYNCLKSEL => '0',             -- 1-bit input: Dynamic CLK/CLKB inversion
        -- Input Data: 1-bit (each) input: ISERDESE2 data input ports
        D => '0',                     -- 1-bit input: Data input
        DDLY => serdata1_master,      -- 1-bit input: Serial data from IDELAYE2
        OFB => '0',                   -- 1-bit input: Data feedback from OSERDESE2
        OCLKB => '0',                 -- 1-bit input: High speed negative edge output clock
        RST => reset,                 -- 1-bit input: Active high asynchronous reset
        -- SHIFTIN1-SHIFTIN2: 1-bit (each) input: Data width expansion input ports
        SHIFTIN1 => '0',
        SHIFTIN2 => '0' 
    );
    serdes1_slave_inst : ISERDESE2
    generic map (
        DATA_RATE => "DDR",           -- DDR, SDR
        DATA_WIDTH => 4,              -- Parallel data width (2-8,10,14)
        DYN_CLKDIV_INV_EN => "FALSE", -- Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
        DYN_CLK_INV_EN => "FALSE",    -- Enable DYNCLKINVSEL inversion (FALSE, TRUE)
        -- INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
        INIT_Q1 => '0',
        INIT_Q2 => '0',
        INIT_Q3 => '0',
        INIT_Q4 => '0',
        INTERFACE_TYPE => "NETWORKING",   -- MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
        IOBDELAY => "IFD",           -- NONE, BOTH, IBUF, IFD
        NUM_CE => 1,                  -- Number of clock enables (1,2)
        OFB_USED => "FALSE",          -- Select OFB path (FALSE, TRUE)
        SERDES_MODE => "MASTER",      -- MASTER, SLAVE
        -- SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
        SRVAL_Q1 => '0',
        SRVAL_Q2 => '0',
        SRVAL_Q3 => '0',
        SRVAL_Q4 => '0' 
    )
    port map (
        O => open,                    -- 1-bit output: Combinatorial output
        -- Q1 - Q8: 1-bit (each) output: Registered data outputs
        Q1 => iserdesSamples(6),
        Q2 => iserdesSamples(4),
        Q3 => iserdesSamples(2),
        Q4 => iserdesSamples(0),
        Q5 => open,
        Q6 => open,
        Q7 => open,
        Q8 => open,
        -- SHIFTOUT1-SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
        SHIFTOUT1 => open,
        SHIFTOUT2 => open,
        BITSLIP => '0',               -- 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
                                      -- CLKDIV when asserted (active High). Subsequently, the data seen on the
                                      -- Q1 to Q8 output ports will shift, as in a barrel-shifter operation, one
                                      -- position every time Bitslip is invoked (DDR operation is different from
                                      -- SDR).
        -- CE1, CE2: 1-bit (each) input: Data register clock enable inputs
        CE1 => '1',
        CE2 => '1',
        CLKDIVP => '0',               -- 1-bit input: TBD
        -- Clocks: 1-bit (each) input: ISERDESE2 clock input ports
        CLK => clkFullDR,        -- 1-bit input: High-speed clock
        CLKB => not clkFullDR,   -- 1-bit input: High-speed secondary clock
        CLKDIV => clkHalfDR,          -- 1-bit input: Divided clock
        OCLK => '0',                  -- 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
        -- Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
        DYNCLKDIVSEL => '0',          -- 1-bit input: Dynamic CLKDIV inversion
        DYNCLKSEL => '0',             -- 1-bit input: Dynamic CLK/CLKB inversion
        -- Input Data: 1-bit (each) input: ISERDESE2 data input ports
        D => '0',                     -- 1-bit input: Data input
        DDLY => serdata1_slave,       -- 1-bit input: Serial data from IDELAYE2
        OFB => '0',                   -- 1-bit input: Data feedback from OSERDESE2
        OCLKB => '0',                 -- 1-bit input: High speed negative edge output clock
        RST => reset,                 -- 1-bit input: Active high asynchronous reset
        -- SHIFTIN1-SHIFTIN2: 1-bit (each) input: Data width expansion input ports
        SHIFTIN1 => '0',
        SHIFTIN2 => '0' 
   );
   
   rawSamples(0) <= not iserdesSamples(0);
   rawSamples(2) <= not iserdesSamples(2);
   rawSamples(4) <= not iserdesSamples(4);
   rawSamples(6) <= not iserdesSamples(6);
   rawSamples(1) <= iserdesSamples(1);
   rawSamples(3) <= iserdesSamples(3);
   rawSamples(5) <= iserdesSamples(5);
   rawSamples(7) <= iserdesSamples(7);

----------------------------------------------------------------------------------------------------------------------    
-- SamplePointDecision   
    saveLastSample : process(clkHalfDR)
    begin
        if(clkHalfDR'event and clkHalfDR='1') then
            rawSamplesHistory <= rawSamples;
        end if;
    end process;
    
    samplePointDecision : process(clkHalfDR)
        variable dataEdgeBeforeSP0 : std_logic;
        variable dataEdgeBeforeSP1 : std_logic;
        variable dataEdgeBeforeSP2 : std_logic;
        variable dataEdgeBeforeSP3 : std_logic;
    begin
        -- Reset unnötig. Unabhängig vom Startzustand muss sich alles auf den Datenstrom aufsynchronisieren.
        -- Der Startzustand ist also egal und das reset-Signal führt nur alle ab und zu zu verkomplizierungen des
        -- routings.
        --if(reset='1') then
            -- BitSlipNeg := '0';
            -- BitSlipPos := '0';
            -- BitOutMinus1 <= '0';
            -- BitOutMinus1Valid <= '0';
            -- BitOut0 <= '0';
            -- BitOut0Valid <= '0';
            -- BitOut1 <= '0';
            -- activeSamplePoint := edgeBeforeSP0;
        --els
        if(clkHalfDR'event and clkHalfDR='1') then
            --Flankendetektion
            dataEdgeBeforeSP0 := (rawSamplesHistory(7) xor rawSamples(0)) or (rawSamples(3) xor rawSamples(4));
            dataEdgeBeforeSP1 := (rawSamples(0) xor rawSamples(1)) or (rawSamples(4) xor rawSamples(5));
            dataEdgeBeforeSP2 := (rawSamples(1) xor rawSamples(2)) or (rawSamples(5) xor rawSamples(6));
            dataEdgeBeforeSP3 := (rawSamples(2) xor rawSamples(3)) or (rawSamples(6) xor rawSamples(7));
            
            -- LED(9) <= BitOutMinus1;
            -- LED(10) <= BitOut0;
            -- LED(11) <= BitOut1;
            -- LED(12) <= dataEdgeBeforeSP0;
            -- LED(13) <= dataEdgeBeforeSP1;
            -- LED(14) <= dataEdgeBeforeSP2;
            -- LED(15) <= dataEdgeBeforeSP3;
            
            --Statemachine zur Speicherung des aktuellen Abtastzeitpunkts
            BitSlipPos <= '0';
            BitSlipNeg <= '0';
            case(activeSamplePoint) is
                when edgeBeforeSP0 =>
                    if(dataEdgeBeforeSP3='1') then
                        activeSamplePoint <= edgeBeforeSP3;
                    elsif(dataEdgeBeforeSP1='1') then
                        activeSamplePoint <= edgeBeforeSP1;
                    end if;
                when edgeBeforeSP1 =>
                    if(dataEdgeBeforeSP0='1') then
                        activeSamplePoint <= edgeBeforeSP0;
                    elsif(dataEdgeBeforeSP2='1') then
                        --rawSamples(0) darf bei diesem Wechsel nicht ausgegeben werden. Wäre sonst doppelt.
                        BitSlipNeg <= '1';
                        activeSamplePoint <= edgeBeforeSP2;
                    end if;
                when edgeBeforeSP2 =>
                    if(dataEdgeBeforeSP1='1') then
                        --rawSamples(0) muss bei diesem Wechsel zusätzlich ausgegeben werden. Würde sonst verschluckt werden.
                        BitSlipPos <= '1';
                        activeSamplePoint <= edgeBeforeSP1;
                    elsif(dataEdgeBeforeSP3='1') then
                        activeSamplePoint <= edgeBeforeSP3;
                    end if;
                when edgeBeforeSP3 =>
                    if(dataEdgeBeforeSP2='1') then
                        activeSamplePoint <= edgeBeforeSP2;
                    elsif(dataEdgeBeforeSP0='1') then
                        activeSamplePoint <= edgeBeforeSP0;
                    end if;
            end case;
        end if;
    end process;

----------------------------------------------------------------------------------------------------------------------    
-- SamplePointSelection
    samplePointSelection : process(clkHalfDR)
    begin
        if(clkHalfDR'event and clkHalfDR='1') then
            --Ausgabe der Bitwerte von den vorher ermittelten Abtastzeitpunkten
            --Ist durch eine FF-Ebene um einen Takt verzögert, das ist aber tolerierbar, da wir nur maximal einen
            --Jitter von 1 Samplepoint pro Samplingperiode (8 Samples) zulassen.
            --Eigentlich könnte man die BitSlip-Abfragen mit in die entsprechenden case(activeSamplePoint)
            --setzen, das würde das Design aber nur unnötig langsamer machen.
            --BitSlipPos und BitSlipNeg können niemals zeitgleich auftreten.
            if(BitSlipPos='1') then
                BitOutMinus1Valid <= '1';
            else
                BitOutMinus1Valid <= '0';
            end if;
            if(BitSlipNeg='1') then
                BitOut0Valid <= '0';
            else
                BitOut0Valid <= '1';
            end if;
            
            BitOutMinus1 <= rawSamplesHistory(0);

            case(activeSamplePoint) is
                when edgeBeforeSP0 =>
                    BitOut0 <= rawSamplesHistory(2);
                    BitOut1 <= rawSamplesHistory(6);
                when edgeBeforeSP1 =>
                    BitOut0 <= rawSamplesHistory(3);
                    BitOut1 <= rawSamplesHistory(7);
                when edgeBeforeSP2 =>
                    BitOut0 <= rawSamplesHistory(0);
                    BitOut1 <= rawSamplesHistory(4);
                when edgeBeforeSP3 =>
                    BitOut0 <= rawSamplesHistory(1);
                    BitOut1 <= rawSamplesHistory(5);
            end case;
        end if;
    end process;
    
----------------------------------------------------------------------------------------------------------------------    
-- Deserialisation and Synchronisation (Pipelined damits schnell bleibt)
    deserialisation : process(clkHalfDR,reset)
    begin
        if(reset='1') then
            movedByOneStage0<='0';
            movedByThreeStage0<='0';
            dataStreamSRStage0 <= (others => '0');
        elsif(clkHalfDR'event and clkHalfDR='1') then
            --BitSlipPos und BitSlipNeg können niemals zeitgleich auftreten.
            movedByOneStage0<='0';
            movedByThreeStage0<='0';
            if(BitOut0Valid='0') then --BitSlipNeg='1'
                dataStreamSRStage0 <= dataStreamSRStage0(10 downto 0) & BitOut1;
                 movedByOneStage0<='1';
            elsif(BitOutMinus1Valid='0') then --Kein BitSlip
                dataStreamSRStage0 <= dataStreamSRStage0(9 downto 0) & BitOut0 & BitOut1;
            else --BitSlipPos='1'
                dataStreamSRStage0 <= dataStreamSRStage0(8 downto 0) & BitOutMinus1 & BitOut0 & BitOut1;
                movedByThreeStage0<='1';
            end if;
        end if;
    end process;
  
    --Wenn K28.7 nicht benutzt wird, dann sind 0011111 und 1100000 "comma codes"
    --Die Benutzung von K28.7 wird hiermit verboten! :P
    syncWordDetection : process(clkHalfDR,reset)
    begin
        if(reset='1') then
            syncAtPos11Stage1 <= '0';
            syncAtPos10Stage1 <= '0';
            syncAtPos09Stage1 <= '0';
            movedByOneStage1 <= '0';
            movedByThreeStage1 <= '0';
            dataStreamSRStage1 <= (others => '0');
        elsif(clkHalfDR'event and clkHalfDR='1') then
            movedByOneStage1 <= movedByOneStage0;
            movedByThreeStage1 <= movedByThreeStage0;
            dataStreamSRStage1 <= dataStreamSRStage0;
            
            syncAtPos11Stage1 <= '0';
            syncAtPos10Stage1 <= '0';
            syncAtPos09Stage1 <= '0';

            if(dataStreamSRStage0(11 downto 5)="0011111" or dataStreamSRStage0(11 downto 5)="1100000") then
                syncAtPos11Stage1 <= '1';
            end if;
            if(dataStreamSRStage0(10 downto 4)="0011111" or dataStreamSRStage0(10 downto 4)="1100000") then
                syncAtPos10Stage1 <= '1';
            end if;
            if(dataStreamSRStage0( 9 downto 3)="0011111" or dataStreamSRStage0( 9 downto 3)="1100000") then
                syncAtPos09Stage1 <= '1';
            end if;
        end if;
    end process;
    
    synchronisation : process(clkHalfDR,reset)
    begin
        if(reset='1') then
            dataStreamSRStage2 <= (others => '0');
            startOfCodedWordSR <= (others => '0');
        elsif(clkHalfDR'event and clkHalfDR='1') then
            --LED(11 downto 0) <= dataStreamSRStage0(11 downto 0);
            if(syncAtPos11Stage1='1') then
                startOfCodedWordSR <= b"1000_0000_00";--00";
            elsif(syncAtPos10Stage1='1') then
                startOfCodedWordSR <= b"0100_0000_00";--00";
            elsif(syncAtPos09Stage1='1') then
                startOfCodedWordSR <= b"0010_0000_00";--00";
            else
                if(movedByOneStage1='1') then
                    startOfCodedWordSR <= startOfCodedWordSR(10 downto 2) & startOfCodedWordSR(11);--& "00";
                elsif(movedByThreeStage1='1') then
                    startOfCodedWordSR <= startOfCodedWordSR(8 downto 2) & startOfCodedWordSR(11 downto 9);--& "00";
                else --movedByTwo
                    startOfCodedWordSR <= startOfCodedWordSR(9 downto 2) & startOfCodedWordSR(11 downto 10);--& "00";
                end if;
            end if;
            
            dataStreamSRStage2 <= dataStreamSRStage1; -- Um 1 Takt verzögern, damit es mit bytesInSR synchron ist
        end if;
    end process;
    
    --Wenn ein Wort ganz im SR liegt, dieses ausgeben.
    --Im Schlimmsten Fall werden jeweils einzelne Bits ins SR geschoben, es könnte also 3 mal unmittelbar
    --hintereinander ein gültiges wort detektiert werden. Die Mehrfachausgabe wird vom multipleDetectCounter
    --verhindert.
    codedWordParallelOutput : process(clkHalfDR,reset)
    begin
        if(reset='1') then
            codedWordOut <= (others => '0');
            codedWordOutNewDataStrobe <= '0';
            multipleDetectCounter <= 0;
        elsif(clkHalfDR'event and clkHalfDR='1') then
            codedWordOutNewDataStrobe <= '0';
            if(multipleDetectCounter=0) then
                if(startOfCodedWordSR(9)='1') then
                    codedWordOut <= dataStreamSRStage2(9 downto 0);
                    codedWordOutNewDataStrobe <= '1';
                    multipleDetectCounter <= 3;
                elsif(startOfCodedWordSR(10)='1') then
                    codedWordOut <= dataStreamSRStage2(10 downto 1);
                    codedWordOutNewDataStrobe <= '1';
                    multipleDetectCounter <= 3;
                elsif(startOfCodedWordSR(11)='1') then
                    codedWordOut <= dataStreamSRStage2(11 downto 2);
                    codedWordOutNewDataStrobe <= '1';
                    multipleDetectCounter <= 3;
                end if;
            else
                multipleDetectCounter <= multipleDetectCounter-1;
            end if;
        end if;
    end process;    

end Behavioral;

