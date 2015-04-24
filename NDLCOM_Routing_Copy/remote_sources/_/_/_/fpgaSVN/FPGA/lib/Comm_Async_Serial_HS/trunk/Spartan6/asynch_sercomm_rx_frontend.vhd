----------------------------------------------------------------------------------
-- Company:         DFKI Bremen
-- Engineer:        Florian Hühn
-- 
-- Create Date:     14:21:17 01/08/2013 
-- Design Name: 
-- Module Name:     asynch_sercomm_rx_frontend - Behavioral 
-- Project Name: 
-- Target Devices:  Spartan6 Family. Tested von XC6SLX45-3CSG324
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
-- Revision 0.01 - File Created
-- Additional Comments: 
--                  Late Sampling Variante
--
----------------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

package asynch_sercomm_rx_frontend_pack is
    function calc_tap_value ( DATARATE : natural; SPEEDGRADE : string ) return natural;
end asynch_sercomm_rx_frontend_pack;
package body asynch_sercomm_rx_frontend_pack is
    -- Definition of Delay-Values. Wanted Delay in seconds is 1/(Datarate[Hz]*4)
    function calc_tap_value ( DATARATE : natural; SPEEDGRADE : string ) return natural is
        variable tmp : natural := 0;
    begin
           if(DATARATE=100_000_000 and SPEEDGRADE="3") then tmp:= 64;--Timing Analyzer: 60=>2509ps; 2500ps soll -- 70 empirisch ermittelt;
        --elsif(DATARATE=100_000_000 and SPEEDGRADE="2") then tmp:= 48;--Wert errechnet, nie überprüft, muss vermutlich kleiner sein
        elsif(DATARATE=150_000_000 and SPEEDGRADE="3") then tmp:= 40;--Timing Analyzer: 40=>1750ps; 1667ps soll
        elsif(DATARATE=160_000_000 and SPEEDGRADE="3") then tmp:= 39;--Timing Analyzer: 39=>1612ps; 1563ps soll
        elsif(DATARATE=200_000_000 and SPEEDGRADE="3") then tmp:= 32;--Timing Analyzer: 30=>1236ps; 1250ps soll
        elsif(DATARATE=240_000_000 and SPEEDGRADE="3") then tmp:= 27;--Timing Analyzer: 26=>1069ps; 1042ps soll
        elsif(DATARATE=300_000_000 and SPEEDGRADE="3") then tmp:= 23;--Timing Analyzer: 22=>ps; 833ps soll
        elsif(DATARATE=320_000_000 and SPEEDGRADE="3") then tmp:= 21;--Timing Analyzer: 21=>857ps; 781ps soll
        elsif(DATARATE=400_000_000 and SPEEDGRADE="3") then tmp:= 19;--Timing Analyzer: 16=>686ps; 625ps soll
        elsif(DATARATE=500_000_000 and SPEEDGRADE="3") then tmp:= 16;--Timing Analyzer: 13=>514ps; 500ps soll -- 17 empirisch ermittelt
        elsif(DATARATE=160_000_000 and SPEEDGRADE="2") then tmp:= 34;--Timing Analyzer: 34=>1669ps; 1563ps soll
        elsif(DATARATE=320_000_000 and SPEEDGRADE="2") then tmp:= 17;--Timing Analyzer: 17=>812ps; 781ps soll
        --elsif(DATARATE=500_000_000 and SPEEDGRADE="2") then tmp:= 10; --Wert errechnet, nie überprüft, muss vermutlich kleiner sein
        else tmp:= 0; end if;
        
        -- To check resulting delay time for a given TAP Value in a particular design:
        -- Use Xilinx Timing Analyzer:
        -- Open Design
        -- Run timing analysis
        -- user specified paths by defining endpoints
        -- from: *rxLine*, to: *serdata1_*
        -- OK
        -- Check Delay difference between (rxLine->serdata1_master) and (rxLine->serdata1_slave)
        -- to match 1/(Datarate*4)
        
        -- Die Realität sagt: Die Fehlerraten gehen runter, wenn man den TAP-Value höher setzt als der Timing
        -- Analyzer sagt. Der Analyzer rechnet aber auch mit 1.14V VCore und 85°C Umgebungstemp.
        
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
            DATARATE : natural := 100_000_000;  -- Communication Datarate [Symbols/sec]
            SPEEDGRADE : string := "3"          -- Speed Grade of FPGA: "2", "3N", or "3"
        );
    port (
            clkHalfDR : in  std_logic;          -- Datarate/2, gclk network
            clkDoubleDR_ioce : in  std_logic;   -- Datarate/2, special ioce synchronisation network
            clkDoubleDR_io : in  std_logic;     -- Datarate*2, BUFIO2 or BUFPLL Clock Region network
            reset : in std_logic;               -- Global reset
            rxPin : in std_logic;               -- Direct connection to Input Pin of IOB or OBUFDS. In single ended mode only P-Pins are possible! (Because of routing constaints of the FPGA)
            codedWordOut : out std_logic_vector(9 downto 0) := (others => '0'); -- Word output. abcdeifghj
            codedWordOutNewDataStrobe : out std_logic := '0' -- New data in codedWordOut available
        );
end asynch_sercomm_rx_frontend;

architecture Behavioral of asynch_sercomm_rx_frontend is
-- Constants
constant HALF_SYM_DELAY_TAPS : natural := calc_tap_value(DATARATE, SPEEDGRADE);


-- Rx Sampling
signal serdata1_master : std_logic;
signal serdata1_slave : std_logic;

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



begin
    -- Laut xilinx funktioniert die Verzögerung erst ab einem Taps-Wert von 4.
    assert(SPEEDGRADE="2" or SPEEDGRADE="3N" or SPEEDGRADE="3") report "asynch_sercomm_rx_frontend: Speed Grade unbekannt!" severity FAILURE;
    assert(HALF_SYM_DELAY_TAPS>=4 or HALF_SYM_DELAY_TAPS=0) report "asynch_sercomm_rx_frontend: Datanrate zu hoch, Verzögerungsleitung wird zu kurz!" severity FAILURE;
    assert(HALF_SYM_DELAY_TAPS/=0) report "asynch_sercomm_rx_frontend: Verzögerungswert zur gewünschten Datenrate unbekannt!" severity FAILURE;
    assert(HALF_SYM_DELAY_TAPS<=255) report "asynch_sercomm_rx_frontend: Datanrate zu niedrig, Verzögerung zu groß!" severity FAILURE;

----------------------------------------------------------------------------------------------------------------------    
-- Rx Sampling   
  
    -- SE geht nur mit P-Pins, zugehörige N-Pins können dann nur als normaler Asych-IO genutzt werden.

    -- Liegt das Signal als DiffSignal an, kann es über einen IBUFDS_DIFF_OUT verdoppelt werden. Jedes der beiden
    -- Signale (Invertiert und nicht invertiert) beide signale können aber nur auf genau ein SERDES-Duo geroutet werden.
    -- Das P-Signal kann auf beide IODELAYS gehen, das N-Signal nur auf den Slave IODELAY.

    -- Der Clock Doubler kann nur aus BUFG und BUFIO2 gespeist werden.
    -- BUFG und SERDES schließen sich aus (timing, alignment von SERDESSTROBE)
    -- BUFIO2 kann nur von einem GCLK, sprich einem IBUFG gespeit werden -> Clock muss an einem GCLK-IO-Pin liegen
    -- -> DDR nur möglich, wenn Datarate/2 an einem GCLK-Pin liegt

    delay1_master_inst : IODELAY2
    generic map (
        COUNTER_WRAPAROUND => "WRAPAROUND", -- "STAY_AT_LIMIT" or "WRAPAROUND" 
        DATA_RATE => "SDR",                 -- "SDR" or "DDR" 
        DELAY_SRC => "IDATAIN",             -- "IO", "ODATAIN" or "IDATAIN" 
        IDELAY2_VALUE => 0,                 -- Delay value when IDELAY_MODE="PCI" (0-255)
        IDELAY_MODE => "NORMAL",            -- "NORMAL" or "PCI" 
        IDELAY_TYPE => "FIXED",             -- "FIXED", "DEFAULT", "VARIABLE_FROM_ZERO", "VARIABLE_FROM_HALF_MAX" 
                                            -- or "DIFF_PHASE_DETECTOR" 
        IDELAY_VALUE => 0,                  -- Amount of taps for fixed input delay (0-255)
        ODELAY_VALUE => 0,                  -- Amount of taps fixed output delay (0-255)
        SERDES_MODE => "NONE",              -- "NONE", "MASTER" or "SLAVE" 
        SIM_TAPDELAY_VALUE => 75            -- Per tap delay used for simulation in ps
    )
    port map (
        BUSY => open,                       -- 1-bit output: Busy output after CAL
        DATAOUT => serdata1_master,         -- 1-bit output: Delayed data output to ISERDES/input register
        DATAOUT2 => open,                   -- 1-bit output: Delayed data output to general FPGA fabric
        DOUT => open,                       -- 1-bit output: Delayed data output
        TOUT => open,                       -- 1-bit output: Delayed 3-state output
        CAL => '0',                         -- 1-bit input: Initiate calibration input
        CE => '0',                          -- 1-bit input: Enable INC input
        CLK => '0',                         -- 1-bit input: Clock input
        IDATAIN => rxPin,                   -- 1-bit input: Data input (connect to top-level port or I/O buffer)
        INC => '0',                         -- 1-bit input: Increment / decrement input
        IOCLK0 => '0',                      -- 1-bit input: Input from the I/O clock network
        IOCLK1 => '0',                      -- 1-bit input: Input from the I/O clock network
        ODATAIN => '0',                     -- 1-bit input: Output data input from output register or OSERDES2.
        RST => '0',                         -- 1-bit input: Reset to zero or 1/2 of total delay period
        T => '1'                            -- 1-bit input: 3-state input signal
    );
    delay1_slave_inst : IODELAY2
    generic map (
        COUNTER_WRAPAROUND => "WRAPAROUND", -- "STAY_AT_LIMIT" or "WRAPAROUND" 
        DATA_RATE => "SDR",                 -- "SDR" or "DDR" 
        DELAY_SRC => "IDATAIN",             -- "IO", "ODATAIN" or "IDATAIN" 
        IDELAY2_VALUE => 0,                 -- Delay value when IDELAY_MODE="PCI" (0-255)
        IDELAY_MODE => "NORMAL",            -- "NORMAL" or "PCI" 
        IDELAY_TYPE => "FIXED",             -- "FIXED", "DEFAULT", "VARIABLE_FROM_ZERO", "VARIABLE_FROM_HALF_MAX" 
                                            -- or "DIFF_PHASE_DETECTOR" 
        IDELAY_VALUE => HALF_SYM_DELAY_TAPS,-- Amount of taps for fixed input delay (0-255)
        -- 59@SG-3N: 2.507ns
        -- 59@SG-3: 2.349ns    63@SG-3: 2.466ns (Gemessen am Limes_Eval: 2.4us@70)
        ODELAY_VALUE => 0,                  -- Amount of taps fixed output delay (0-255)
        SERDES_MODE => "NONE",              -- "NONE", "MASTER" or "SLAVE" 
        SIM_TAPDELAY_VALUE => 75            -- Per tap delay used for simulation in ps
    )
    port map (
        BUSY => open,                       -- 1-bit output: Busy output after CAL
        DATAOUT => serdata1_slave,          -- 1-bit output: Delayed data output to ISERDES/input register
        DATAOUT2 => open,                   -- 1-bit output: Delayed data output to general FPGA fabric
        DOUT => open,                       -- 1-bit output: Delayed data output
        TOUT => open,                       -- 1-bit output: Delayed 3-state output
        CAL => '0',                         -- 1-bit input: Initiate calibration input
        CE => '0',                          -- 1-bit input: Enable INC input
        CLK => '0',                         -- 1-bit input: Clock input
        IDATAIN => rxPin,                   -- 1-bit input: Data input (connect to top-level port or I/O buffer)
        INC => '0',                         -- 1-bit input: Increment / decrement input
        IOCLK0 => '0',                      -- 1-bit input: Input from the I/O clock network
        IOCLK1 => '0',                      -- 1-bit input: Input from the I/O clock network
        ODATAIN => '0',                     -- 1-bit input: Output data input from output register or OSERDES2.
        RST => '0',                         -- 1-bit input: Reset to zero or 1/2 of total delay period
        T => '1'                            -- 1-bit input: 3-state input signal
    );
    
    serdes1_master_inst : ISERDES2
    generic map (
        BITSLIP_ENABLE => FALSE,            -- Enable Bitslip Functionality (TRUE/FALSE)
        DATA_RATE => "SDR",                 -- Data-rate ("SDR" or "DDR")
        DATA_WIDTH => 4,                    -- Parallel data width selection (2-8)
        INTERFACE_TYPE => "RETIMED",        -- "NETWORKING", "NETWORKING_PIPELINED" or "RETIMED" 
        SERDES_MODE => "NONE"               -- "NONE", "MASTER" or "SLAVE" 
    )
    port map (
        CFB0 => open,                       -- 1-bit output: Clock feed-through route output
        CFB1 => open,                       -- 1-bit output: Clock feed-through route output
        DFB => open,                        -- 1-bit output: Feed-through clock output
        FABRICOUT => open,                  -- 1-bit output: Unsynchrnonized data output
        INCDEC => open,                     -- 1-bit output: Phase detector output
        -- Q1 - Q4: 1-bit (each) output: Registered outputs to FPGA logic
        Q1 => rawSamples(1),
        Q2 => rawSamples(3),
        Q3 => rawSamples(5),
        Q4 => rawSamples(7),
        SHIFTOUT => open,                   -- 1-bit output: Cascade output signal for master/slave I/O
        VALID => open,                      -- 1-bit output: Output status of the phase detector
        BITSLIP => '0',                     -- 1-bit input: Bitslip enable input
        CE0 => '1',                         -- 1-bit input: Clock enable input
        CLK0 => clkDoubleDR_io,             -- 1-bit input: I/O clock network input
        CLK1 => '0',                        -- 1-bit input: Secondary I/O clock network input
        CLKDIV => clkHalfDR,                -- 1-bit input: FPGA logic domain clock input
        D => serdata1_master,               -- 1-bit input: Input data
        IOCE => clkDoubleDR_ioce,           -- 1-bit input: Data strobe input
        RST => reset,                       -- 1-bit input: Asynchronous reset input
        SHIFTIN => '0'                      -- 1-bit input: Cascade input signal for master/slave I/O
    );  
    serdes1_slave_inst : ISERDES2
    generic map (
        BITSLIP_ENABLE => FALSE,            -- Enable Bitslip Functionality (TRUE/FALSE)
        DATA_RATE => "SDR",                 -- Data-rate ("SDR" or "DDR")
        DATA_WIDTH => 4,                    -- Parallel data width selection (2-8)
        INTERFACE_TYPE => "RETIMED",        -- "NETWORKING", "NETWORKING_PIPELINED" or "RETIMED" 
        SERDES_MODE => "NONE"               -- "NONE", "MASTER" or "SLAVE" 
    )
    port map (
        CFB0 => open,                       -- 1-bit output: Clock feed-through route output
        CFB1 => open,                       -- 1-bit output: Clock feed-through route output
        DFB => open,                        -- 1-bit output: Feed-through clock output
        FABRICOUT => open,                  -- 1-bit output: Unsynchrnonized data output
        INCDEC => open,                     -- 1-bit output: Phase detector output
        -- Q1 - Q4: 1-bit (each) output: Registered outputs to FPGA logic
        Q1 => rawSamples(0),
        Q2 => rawSamples(2),
        Q3 => rawSamples(4),
        Q4 => rawSamples(6),
        SHIFTOUT => open,                   -- 1-bit output: Cascade output signal for master/slave I/O
        VALID => open,                      -- 1-bit output: Output status of the phase detector
        BITSLIP => '0',                     -- 1-bit input: Bitslip enable input
        CE0 => '1',                         -- 1-bit input: Clock enable input
        CLK0 => clkDoubleDR_io,             -- 1-bit input: I/O clock network input
        CLK1 => '0',                        -- 1-bit input: Secondary I/O clock network input
        CLKDIV => clkHalfDR,                -- 1-bit input: FPGA logic domain clock input
        D => serdata1_slave,                -- 1-bit input: Input data
        IOCE => clkDoubleDR_ioce,           -- 1-bit input: Data strobe input
        RST => reset,                       -- 1-bit input: Asynchronous reset input
        SHIFTIN => '0'                      -- 1-bit input: Cascade input signal for master/slave I/O
    );

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

