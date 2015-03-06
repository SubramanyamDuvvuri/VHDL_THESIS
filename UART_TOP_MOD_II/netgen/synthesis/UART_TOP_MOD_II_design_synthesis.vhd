--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.20131013
--  \   \         Application: netgen
--  /   /         Filename: UART_TOP_MOD_II_design_synthesis.vhd
-- /___/   /\     Timestamp: Fri Mar  6 15:55:05 2015
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -filter /home/sduvvuri/thesis.git/UART_TOP_MOD_II/iseconfig/filter.filter -intstyle ise -ar Structure -tm UART_TOP_MOD_II_design -w -dir netgen/synthesis -ofmt vhdl -sim UART_TOP_MOD_II_design.ngc UART_TOP_MOD_II_design_synthesis.vhd 
-- Device	: xc3s400a-4-ft256
-- Input file	: UART_TOP_MOD_II_design.ngc
-- Output file	: /home/sduvvuri/thesis.git/UART_TOP_MOD_II/netgen/synthesis/UART_TOP_MOD_II_design_synthesis.vhd
-- # of Entities	: 1
-- Design Name	: UART_TOP_MOD_II_design
-- Xilinx	: /home/sduvvuri/Documents/Xilinx/Xilinx/14.7/ISE_DS/ISE/
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity UART_TOP_MOD_II_design is
  port (
    RESET : in STD_LOGIC := 'X'; 
    CLOCK : in STD_LOGIC := 'X'; 
    RX : in STD_LOGIC := 'X'; 
    TX : out STD_LOGIC 
  );
end UART_TOP_MOD_II_design;

architecture Structure of UART_TOP_MOD_II_design is
  signal CLOCK_BUFGP_1 : STD_LOGIC; 
  signal N1 : STD_LOGIC; 
  signal N101 : STD_LOGIC; 
  signal N103 : STD_LOGIC; 
  signal N108 : STD_LOGIC; 
  signal N110 : STD_LOGIC; 
  signal N112 : STD_LOGIC; 
  signal N114 : STD_LOGIC; 
  signal N116 : STD_LOGIC; 
  signal N118 : STD_LOGIC; 
  signal N119 : STD_LOGIC; 
  signal N12 : STD_LOGIC; 
  signal N121 : STD_LOGIC; 
  signal N125 : STD_LOGIC; 
  signal N127 : STD_LOGIC; 
  signal N129 : STD_LOGIC; 
  signal N130 : STD_LOGIC; 
  signal N133 : STD_LOGIC; 
  signal N134 : STD_LOGIC; 
  signal N135 : STD_LOGIC; 
  signal N137 : STD_LOGIC; 
  signal N139 : STD_LOGIC; 
  signal N14 : STD_LOGIC; 
  signal N141 : STD_LOGIC; 
  signal N143 : STD_LOGIC; 
  signal N145 : STD_LOGIC; 
  signal N149 : STD_LOGIC; 
  signal N150 : STD_LOGIC; 
  signal N151 : STD_LOGIC; 
  signal N152 : STD_LOGIC; 
  signal N153 : STD_LOGIC; 
  signal N154 : STD_LOGIC; 
  signal N155 : STD_LOGIC; 
  signal N156 : STD_LOGIC; 
  signal N157 : STD_LOGIC; 
  signal N158 : STD_LOGIC; 
  signal N159 : STD_LOGIC; 
  signal N16 : STD_LOGIC; 
  signal N160 : STD_LOGIC; 
  signal N161 : STD_LOGIC; 
  signal N162 : STD_LOGIC; 
  signal N164 : STD_LOGIC; 
  signal N165 : STD_LOGIC; 
  signal N166 : STD_LOGIC; 
  signal N167 : STD_LOGIC; 
  signal N168 : STD_LOGIC; 
  signal N169 : STD_LOGIC; 
  signal N170 : STD_LOGIC; 
  signal N171 : STD_LOGIC; 
  signal N172 : STD_LOGIC; 
  signal N173 : STD_LOGIC; 
  signal N174 : STD_LOGIC; 
  signal N175 : STD_LOGIC; 
  signal N176 : STD_LOGIC; 
  signal N177 : STD_LOGIC; 
  signal N178 : STD_LOGIC; 
  signal N179 : STD_LOGIC; 
  signal N180 : STD_LOGIC; 
  signal N20 : STD_LOGIC; 
  signal N28 : STD_LOGIC; 
  signal N30 : STD_LOGIC; 
  signal N32 : STD_LOGIC; 
  signal N34 : STD_LOGIC; 
  signal N36 : STD_LOGIC; 
  signal N41 : STD_LOGIC; 
  signal N42 : STD_LOGIC; 
  signal N47 : STD_LOGIC; 
  signal N51 : STD_LOGIC; 
  signal N53 : STD_LOGIC; 
  signal N55 : STD_LOGIC; 
  signal N56 : STD_LOGIC; 
  signal N60 : STD_LOGIC; 
  signal N61 : STD_LOGIC; 
  signal N67 : STD_LOGIC; 
  signal N7 : STD_LOGIC; 
  signal N72 : STD_LOGIC; 
  signal N73 : STD_LOGIC; 
  signal N80 : STD_LOGIC; 
  signal N82 : STD_LOGIC; 
  signal N84 : STD_LOGIC; 
  signal N86 : STD_LOGIC; 
  signal N88 : STD_LOGIC; 
  signal N96 : STD_LOGIC; 
  signal N97 : STD_LOGIC; 
  signal RESET_IBUF_86 : STD_LOGIC; 
  signal RX_IBUF_88 : STD_LOGIC; 
  signal UART_CONTROLLER_portmap_start_tx_flag_sig_98 : STD_LOGIC; 
  signal UART_MOD_portmap_Madd_txWaitCnt_addsub0000_cy_2_Q : STD_LOGIC; 
  signal UART_MOD_portmap_Madd_txWaitCnt_addsub0000_cy_4_Q : STD_LOGIC; 
  signal UART_MOD_portmap_N01 : STD_LOGIC; 
  signal UART_MOD_portmap_N10 : STD_LOGIC; 
  signal UART_MOD_portmap_N11 : STD_LOGIC; 
  signal UART_MOD_portmap_N13 : STD_LOGIC; 
  signal UART_MOD_portmap_N14 : STD_LOGIC; 
  signal UART_MOD_portmap_N17 : STD_LOGIC; 
  signal UART_MOD_portmap_N30 : STD_LOGIC; 
  signal UART_MOD_portmap_N5 : STD_LOGIC; 
  signal UART_MOD_portmap_N59 : STD_LOGIC; 
  signal UART_MOD_portmap_N6 : STD_LOGIC; 
  signal UART_MOD_portmap_N63 : STD_LOGIC; 
  signal UART_MOD_portmap_N64 : STD_LOGIC; 
  signal UART_MOD_portmap_N65 : STD_LOGIC; 
  signal UART_MOD_portmap_N66 : STD_LOGIC; 
  signal UART_MOD_portmap_N67 : STD_LOGIC; 
  signal UART_MOD_portmap_N68 : STD_LOGIC; 
  signal UART_MOD_portmap_N7 : STD_LOGIC; 
  signal UART_MOD_portmap_N70 : STD_LOGIC; 
  signal UART_MOD_portmap_N8 : STD_LOGIC; 
  signal UART_MOD_portmap_Result_0_1 : STD_LOGIC; 
  signal UART_MOD_portmap_Result_1_1_127 : STD_LOGIC; 
  signal UART_MOD_portmap_Result_2_1_129 : STD_LOGIC; 
  signal UART_MOD_portmap_dataCnt_mux0000_3_13_137 : STD_LOGIC; 
  signal UART_MOD_portmap_dataCnt_mux0000_3_29_138 : STD_LOGIC; 
  signal UART_MOD_portmap_dataCnt_mux0000_3_42_139 : STD_LOGIC; 
  signal UART_MOD_portmap_dataCnt_mux0000_3_49 : STD_LOGIC; 
  signal UART_MOD_portmap_highCnt_mux0000_0_116_148 : STD_LOGIC; 
  signal UART_MOD_portmap_highCnt_mux0000_0_130_149 : STD_LOGIC; 
  signal UART_MOD_portmap_highCnt_mux0000_0_143_150 : STD_LOGIC; 
  signal UART_MOD_portmap_highCnt_mux0000_0_15_151 : STD_LOGIC; 
  signal UART_MOD_portmap_highCnt_mux0000_5_13_156 : STD_LOGIC; 
  signal UART_MOD_portmap_highCnt_mux0000_5_35_157 : STD_LOGIC; 
  signal UART_MOD_portmap_highCnt_mux0000_5_48_158 : STD_LOGIC; 
  signal UART_MOD_portmap_highCnt_mux0000_5_75_159 : STD_LOGIC; 
  signal UART_MOD_portmap_highCnt_mux0000_5_78_160 : STD_LOGIC; 
  signal UART_MOD_portmap_rxData_o_0_not0001 : STD_LOGIC; 
  signal UART_MOD_portmap_rxData_o_1_not0001 : STD_LOGIC; 
  signal UART_MOD_portmap_rxData_o_2_not0001 : STD_LOGIC; 
  signal UART_MOD_portmap_rxData_o_3_not0001 : STD_LOGIC; 
  signal UART_MOD_portmap_rxData_o_4_not0001 : STD_LOGIC; 
  signal UART_MOD_portmap_rxData_o_5_not0001 : STD_LOGIC; 
  signal UART_MOD_portmap_rxData_o_6_not0001 : STD_LOGIC; 
  signal UART_MOD_portmap_rxData_o_7_not0001 : STD_LOGIC; 
  signal UART_MOD_portmap_rxInput_cmp_gt00001 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_FSM_FFd1_186 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_FSM_FFd1_In_187 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_FSM_FFd2_188 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_FSM_FFd2_In1_189 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_FSM_FFd3_190 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_FSM_FFd3_In2_191 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_FSM_FFd3_In33_192 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_FSM_FFd3_In52 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_FSM_FFd3_In9_194 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_cmp_eq0000 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_cmp_gt0000 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_cmp_le0000 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_cmp_lt0000 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_cmp_lt00001 : STD_LOGIC; 
  signal UART_MOD_portmap_rxState_cmp_lt0001 : STD_LOGIC; 
  signal UART_MOD_portmap_rxSync_201 : STD_LOGIC; 
  signal UART_MOD_portmap_rxSync_not0001 : STD_LOGIC; 
  signal UART_MOD_portmap_rxWeight_not0001 : STD_LOGIC; 
  signal UART_MOD_portmap_sampleCnt_mux0002_0_Q_214 : STD_LOGIC; 
  signal UART_MOD_portmap_sampleCnt_mux0002_0_214_215 : STD_LOGIC; 
  signal UART_MOD_portmap_sampleCnt_mux0002_0_2144_216 : STD_LOGIC; 
  signal UART_MOD_portmap_sampleCnt_mux0002_0_2156_217 : STD_LOGIC; 
  signal UART_MOD_portmap_sampleCnt_mux0002_1_Q : STD_LOGIC; 
  signal UART_MOD_portmap_sampleCnt_mux0002_2_1_219 : STD_LOGIC; 
  signal UART_MOD_portmap_sampleCnt_mux0002_3_27_220 : STD_LOGIC; 
  signal UART_MOD_portmap_sampleCnt_mux0002_3_48 : STD_LOGIC; 
  signal UART_MOD_portmap_sampleCnt_mux0002_4_Q_222 : STD_LOGIC; 
  signal UART_MOD_portmap_sampleCnt_mux0002_5_Q : STD_LOGIC; 
  signal UART_MOD_portmap_sampleCnt_mux0002_6_Q_224 : STD_LOGIC; 
  signal UART_MOD_portmap_sampleCnt_mux0002_6_311 : STD_LOGIC; 
  signal UART_MOD_portmap_txBitCnt_not0001 : STD_LOGIC; 
  signal UART_MOD_portmap_txBitCnt_or0000_230 : STD_LOGIC; 
  signal UART_MOD_portmap_txState_FSM_FFd1_231 : STD_LOGIC; 
  signal UART_MOD_portmap_txState_FSM_FFd1_In : STD_LOGIC; 
  signal UART_MOD_portmap_txState_FSM_FFd2_233 : STD_LOGIC; 
  signal UART_MOD_portmap_txState_FSM_FFd2_In_234 : STD_LOGIC; 
  signal UART_MOD_portmap_txState_cmp_eq0000 : STD_LOGIC; 
  signal UART_MOD_portmap_txState_cmp_lt0000 : STD_LOGIC; 
  signal UART_MOD_portmap_tx_o_251 : STD_LOGIC; 
  signal UART_MOD_portmap_tx_o_mux0001 : STD_LOGIC; 
  signal UART_MOD_portmap_tx_o_mux0001109_253 : STD_LOGIC; 
  signal UART_MOD_portmap_tx_o_mux0001114_254 : STD_LOGIC; 
  signal UART_MOD_portmap_tx_o_mux0001150_255 : STD_LOGIC; 
  signal UART_MOD_portmap_tx_o_mux0001185_256 : STD_LOGIC; 
  signal UART_MOD_portmap_tx_o_mux000119_257 : STD_LOGIC; 
  signal UART_MOD_portmap_tx_o_mux0001198_258 : STD_LOGIC; 
  signal UART_MOD_portmap_tx_o_mux00013 : STD_LOGIC; 
  signal UART_MOD_portmap_tx_o_mux000135_260 : STD_LOGIC; 
  signal UART_MOD_portmap_tx_o_mux000150_261 : STD_LOGIC; 
  signal UART_MOD_portmap_tx_o_mux000182_262 : STD_LOGIC; 
  signal UART_CONTROLLER_portmap_byte_in2uart_tx_sig : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal UART_MOD_portmap_Madd_highCnt_share0000_cy : STD_LOGIC_VECTOR ( 3 downto 2 ); 
  signal UART_MOD_portmap_Madd_sampleCnt_share0000_cy : STD_LOGIC_VECTOR ( 4 downto 3 ); 
  signal UART_MOD_portmap_Result : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal UART_MOD_portmap_dataCnt : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal UART_MOD_portmap_dataCnt_mux0000 : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal UART_MOD_portmap_highCnt : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal UART_MOD_portmap_highCnt_mux0000 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal UART_MOD_portmap_rxData_o : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal UART_MOD_portmap_rxInput : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal UART_MOD_portmap_rxWeight : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal UART_MOD_portmap_sampleCnt : STD_LOGIC_VECTOR ( 6 downto 0 ); 
  signal UART_MOD_portmap_txBitCnt : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal UART_MOD_portmap_txWaitCnt : STD_LOGIC_VECTOR ( 6 downto 0 ); 
  signal UART_MOD_portmap_txWaitCnt_mux0000 : STD_LOGIC_VECTOR ( 6 downto 0 ); 
begin
  XST_VCC : VCC
    port map (
      P => N1
    );
  UART_MOD_portmap_txState_FSM_FFd2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_txState_FSM_FFd2_In_234,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_txState_FSM_FFd2_233
    );
  UART_MOD_portmap_txState_FSM_FFd1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_txState_FSM_FFd1_In,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_txState_FSM_FFd1_231
    );
  UART_MOD_portmap_rxState_FSM_FFd1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxState_FSM_FFd1_In_187,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxState_FSM_FFd1_186
    );
  UART_MOD_portmap_txBitCnt_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_txBitCnt_not0001,
      D => UART_MOD_portmap_Result_2_1_129,
      R => UART_MOD_portmap_txBitCnt_or0000_230,
      Q => UART_MOD_portmap_txBitCnt(2)
    );
  UART_MOD_portmap_txBitCnt_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_txBitCnt_not0001,
      D => UART_MOD_portmap_Result_1_1_127,
      R => UART_MOD_portmap_txBitCnt_or0000_230,
      Q => UART_MOD_portmap_txBitCnt(1)
    );
  UART_MOD_portmap_txBitCnt_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_txBitCnt_not0001,
      D => UART_MOD_portmap_Result_0_1,
      R => UART_MOD_portmap_txBitCnt_or0000_230,
      Q => UART_MOD_portmap_txBitCnt(0)
    );
  UART_MOD_portmap_rxWeight_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_rxWeight_not0001,
      D => UART_MOD_portmap_Result(2),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxWeight(2)
    );
  UART_MOD_portmap_rxWeight_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_rxWeight_not0001,
      D => UART_MOD_portmap_Result(1),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxWeight(1)
    );
  UART_MOD_portmap_rxWeight_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_rxWeight_not0001,
      D => UART_MOD_portmap_Result(0),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxWeight(0)
    );
  UART_MOD_portmap_rxData_o_1 : FDRE
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_rxData_o_1_not0001,
      D => UART_MOD_portmap_rxState_cmp_le0000,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxData_o(1)
    );
  UART_MOD_portmap_rxData_o_0 : FDRE
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_rxData_o_0_not0001,
      D => UART_MOD_portmap_rxState_cmp_le0000,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxData_o(0)
    );
  UART_MOD_portmap_rxSync : FDRE
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_rxSync_not0001,
      D => UART_MOD_portmap_rxState_cmp_lt0001,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxSync_201
    );
  UART_MOD_portmap_rxData_o_7 : FDRE
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_rxData_o_7_not0001,
      D => UART_MOD_portmap_rxState_cmp_le0000,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxData_o(7)
    );
  UART_MOD_portmap_rxData_o_5 : FDRE
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_rxData_o_5_not0001,
      D => UART_MOD_portmap_rxState_cmp_le0000,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxData_o(5)
    );
  UART_MOD_portmap_rxData_o_4 : FDRE
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_rxData_o_4_not0001,
      D => UART_MOD_portmap_rxState_cmp_le0000,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxData_o(4)
    );
  UART_MOD_portmap_rxData_o_6 : FDRE
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_rxData_o_6_not0001,
      D => UART_MOD_portmap_rxState_cmp_le0000,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxData_o(6)
    );
  UART_MOD_portmap_rxInput_7 : FDR
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxInput(6),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxInput(7)
    );
  UART_MOD_portmap_rxInput_6 : FDR
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxInput(5),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxInput(6)
    );
  UART_MOD_portmap_rxInput_5 : FDR
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxInput(4),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxInput(5)
    );
  UART_MOD_portmap_rxInput_4 : FDR
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxInput(3),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxInput(4)
    );
  UART_MOD_portmap_rxInput_3 : FDR
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxInput(2),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxInput(3)
    );
  UART_MOD_portmap_rxInput_2 : FDR
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxInput(1),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxInput(2)
    );
  UART_MOD_portmap_rxInput_1 : FDR
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxInput(0),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxInput(1)
    );
  UART_MOD_portmap_rxData_o_3 : FDRE
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_rxData_o_3_not0001,
      D => UART_MOD_portmap_rxState_cmp_le0000,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxData_o(3)
    );
  UART_MOD_portmap_rxData_o_2 : FDRE
    port map (
      C => CLOCK_BUFGP_1,
      CE => UART_MOD_portmap_rxData_o_2_not0001,
      D => UART_MOD_portmap_rxState_cmp_le0000,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_rxData_o(2)
    );
  UART_MOD_portmap_sampleCnt_6 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_sampleCnt_mux0002_0_Q_214,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_sampleCnt(6)
    );
  UART_MOD_portmap_sampleCnt_5 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_sampleCnt_mux0002_1_Q,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_sampleCnt(5)
    );
  UART_MOD_portmap_sampleCnt_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_sampleCnt_mux0002_4_Q_222,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_sampleCnt(2)
    );
  UART_MOD_portmap_sampleCnt_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_sampleCnt_mux0002_5_Q,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_sampleCnt(1)
    );
  UART_MOD_portmap_sampleCnt_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_sampleCnt_mux0002_6_Q_224,
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_sampleCnt(0)
    );
  UART_MOD_portmap_highCnt_4 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_highCnt_mux0000(4),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_highCnt(4)
    );
  UART_MOD_portmap_highCnt_3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_highCnt_mux0000(3),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_highCnt(3)
    );
  UART_MOD_portmap_highCnt_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_highCnt_mux0000(2),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_highCnt(2)
    );
  UART_MOD_portmap_highCnt_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_highCnt_mux0000(1),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_highCnt(1)
    );
  UART_MOD_portmap_highCnt_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_highCnt_mux0000(0),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_highCnt(0)
    );
  UART_MOD_portmap_tx_o : FDS
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_tx_o_mux0001,
      S => RESET_IBUF_86,
      Q => UART_MOD_portmap_tx_o_251
    );
  UART_MOD_portmap_txWaitCnt_6 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_txWaitCnt_mux0000(6),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_txWaitCnt(6)
    );
  UART_MOD_portmap_txWaitCnt_5 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_txWaitCnt_mux0000(5),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_txWaitCnt(5)
    );
  UART_MOD_portmap_txWaitCnt_4 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_txWaitCnt_mux0000(4),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_txWaitCnt(4)
    );
  UART_MOD_portmap_txWaitCnt_3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_txWaitCnt_mux0000(3),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_txWaitCnt(3)
    );
  UART_MOD_portmap_txWaitCnt_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_txWaitCnt_mux0000(2),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_txWaitCnt(2)
    );
  UART_MOD_portmap_txWaitCnt_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_txWaitCnt_mux0000(1),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_txWaitCnt(1)
    );
  UART_MOD_portmap_txWaitCnt_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_txWaitCnt_mux0000(0),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_txWaitCnt(0)
    );
  UART_MOD_portmap_dataCnt_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_dataCnt_mux0000(2),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_dataCnt(2)
    );
  UART_MOD_portmap_dataCnt_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_dataCnt_mux0000(1),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_dataCnt(1)
    );
  UART_MOD_portmap_dataCnt_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_dataCnt_mux0000(0),
      R => RESET_IBUF_86,
      Q => UART_MOD_portmap_dataCnt(0)
    );
  UART_CONTROLLER_portmap_byte_in2uart_tx_sig_7 : FDS
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxData_o(7),
      S => RESET_IBUF_86,
      Q => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(7)
    );
  UART_CONTROLLER_portmap_byte_in2uart_tx_sig_6 : FDS
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxData_o(6),
      S => RESET_IBUF_86,
      Q => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(6)
    );
  UART_CONTROLLER_portmap_byte_in2uart_tx_sig_5 : FDS
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxData_o(5),
      S => RESET_IBUF_86,
      Q => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(5)
    );
  UART_CONTROLLER_portmap_byte_in2uart_tx_sig_4 : FDS
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxData_o(4),
      S => RESET_IBUF_86,
      Q => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(4)
    );
  UART_CONTROLLER_portmap_byte_in2uart_tx_sig_3 : FDS
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxData_o(3),
      S => RESET_IBUF_86,
      Q => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(3)
    );
  UART_CONTROLLER_portmap_byte_in2uart_tx_sig_2 : FDS
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxData_o(2),
      S => RESET_IBUF_86,
      Q => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(2)
    );
  UART_CONTROLLER_portmap_byte_in2uart_tx_sig_1 : FDS
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxData_o(1),
      S => RESET_IBUF_86,
      Q => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(1)
    );
  UART_CONTROLLER_portmap_byte_in2uart_tx_sig_0 : FDS
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxData_o(0),
      S => RESET_IBUF_86,
      Q => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(0)
    );
  UART_CONTROLLER_portmap_start_tx_flag_sig : FDR
    port map (
      C => CLOCK_BUFGP_1,
      D => N1,
      R => RESET_IBUF_86,
      Q => UART_CONTROLLER_portmap_start_tx_flag_sig_98
    );
  UART_MOD_portmap_Mcount_txBitCnt_xor_1_11 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => UART_MOD_portmap_txBitCnt(1),
      I1 => UART_MOD_portmap_txBitCnt(0),
      O => UART_MOD_portmap_Result_1_1_127
    );
  UART_MOD_portmap_Mcount_txBitCnt_xor_2_11 : LUT3
    generic map(
      INIT => X"6C"
    )
    port map (
      I0 => UART_MOD_portmap_txBitCnt(0),
      I1 => UART_MOD_portmap_txBitCnt(2),
      I2 => UART_MOD_portmap_txBitCnt(1),
      O => UART_MOD_portmap_Result_2_1_129
    );
  UART_MOD_portmap_Result_1_1 : LUT4
    generic map(
      INIT => X"8699"
    )
    port map (
      I0 => UART_MOD_portmap_rxWeight(1),
      I1 => UART_MOD_portmap_rxWeight(0),
      I2 => UART_MOD_portmap_rxWeight(2),
      I3 => RX_IBUF_88,
      O => UART_MOD_portmap_Result(1)
    );
  UART_MOD_portmap_Result_2_1 : LUT4
    generic map(
      INIT => X"ECC9"
    )
    port map (
      I0 => RX_IBUF_88,
      I1 => UART_MOD_portmap_rxWeight(2),
      I2 => UART_MOD_portmap_rxWeight(0),
      I3 => UART_MOD_portmap_rxWeight(1),
      O => UART_MOD_portmap_Result(2)
    );
  UART_MOD_portmap_rxWeight_not00011 : LUT4
    generic map(
      INIT => X"37FE"
    )
    port map (
      I0 => UART_MOD_portmap_rxWeight(1),
      I1 => UART_MOD_portmap_rxWeight(2),
      I2 => UART_MOD_portmap_rxWeight(0),
      I3 => RX_IBUF_88,
      O => UART_MOD_portmap_rxWeight_not0001
    );
  UART_MOD_portmap_rxData_o_3_and000211 : LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => UART_MOD_portmap_dataCnt(1),
      I1 => UART_MOD_portmap_dataCnt(3),
      I2 => UART_MOD_portmap_dataCnt(0),
      O => UART_MOD_portmap_N64
    );
  UART_MOD_portmap_rxData_o_2_and000211 : LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => UART_MOD_portmap_dataCnt(1),
      I1 => UART_MOD_portmap_dataCnt(3),
      I2 => UART_MOD_portmap_dataCnt(0),
      O => UART_MOD_portmap_N66
    );
  UART_MOD_portmap_rxData_o_1_and000211 : LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => UART_MOD_portmap_dataCnt(0),
      I1 => UART_MOD_portmap_dataCnt(1),
      I2 => UART_MOD_portmap_dataCnt(3),
      O => UART_MOD_portmap_N65
    );
  UART_MOD_portmap_rxData_o_0_and000211 : LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      I0 => UART_MOD_portmap_dataCnt(1),
      I1 => UART_MOD_portmap_dataCnt(3),
      I2 => UART_MOD_portmap_dataCnt(0),
      O => UART_MOD_portmap_N67
    );
  UART_MOD_portmap_txState_FSM_Out01 : LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => UART_MOD_portmap_txState_FSM_FFd2_233,
      I1 => UART_MOD_portmap_txState_FSM_FFd1_231,
      O => UART_MOD_portmap_txState_cmp_eq0000
    );
  UART_MOD_portmap_txState_FSM_FFd1_In1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => UART_MOD_portmap_txState_cmp_lt0000,
      I1 => UART_MOD_portmap_txState_FSM_FFd2_233,
      I2 => UART_MOD_portmap_txState_FSM_FFd1_231,
      O => UART_MOD_portmap_txState_FSM_FFd1_In
    );
  UART_MOD_portmap_txBitCnt_not00011 : LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => UART_MOD_portmap_txState_FSM_FFd2_233,
      I1 => UART_MOD_portmap_txState_cmp_lt0000,
      I2 => UART_MOD_portmap_txState_FSM_FFd1_231,
      O => UART_MOD_portmap_txBitCnt_not0001
    );
  UART_MOD_portmap_txState_FSM_FFd2_In_SW0 : LUT2
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => UART_CONTROLLER_portmap_start_tx_flag_sig_98,
      I1 => UART_MOD_portmap_txState_FSM_FFd1_231,
      O => UART_MOD_portmap_tx_o_mux00013
    );
  UART_MOD_portmap_txBitCnt_or0000_SW0 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => UART_MOD_portmap_txBitCnt(1),
      I1 => UART_MOD_portmap_txState_FSM_FFd1_231,
      I2 => UART_MOD_portmap_txBitCnt(0),
      I3 => UART_MOD_portmap_txState_FSM_FFd2_233,
      O => N7
    );
  UART_MOD_portmap_txBitCnt_or0000 : LUT4
    generic map(
      INIT => X"FF40"
    )
    port map (
      I0 => N169,
      I1 => UART_MOD_portmap_txBitCnt(2),
      I2 => N7,
      I3 => RESET_IBUF_86,
      O => UART_MOD_portmap_txBitCnt_or0000_230
    );
  UART_MOD_portmap_txWaitCnt_mux0000_0_1 : LUT4
    generic map(
      INIT => X"5702"
    )
    port map (
      I0 => UART_MOD_portmap_txWaitCnt(0),
      I1 => UART_MOD_portmap_txState_FSM_FFd1_231,
      I2 => UART_MOD_portmap_txState_FSM_FFd2_233,
      I3 => UART_MOD_portmap_N17,
      O => UART_MOD_portmap_txWaitCnt_mux0000(0)
    );
  UART_MOD_portmap_txWaitCnt_mux0000_5_1 : LUT4
    generic map(
      INIT => X"D8A8"
    )
    port map (
      I0 => UART_MOD_portmap_txWaitCnt(5),
      I1 => UART_MOD_portmap_txState_cmp_eq0000,
      I2 => UART_MOD_portmap_N17,
      I3 => UART_MOD_portmap_Madd_txWaitCnt_addsub0000_cy_4_Q,
      O => UART_MOD_portmap_txWaitCnt_mux0000(5)
    );
  UART_MOD_portmap_txWaitCnt_mux0000_3_1 : LUT4
    generic map(
      INIT => X"D8A8"
    )
    port map (
      I0 => UART_MOD_portmap_txWaitCnt(3),
      I1 => UART_MOD_portmap_txState_cmp_eq0000,
      I2 => UART_MOD_portmap_N17,
      I3 => UART_MOD_portmap_Madd_txWaitCnt_addsub0000_cy_2_Q,
      O => UART_MOD_portmap_txWaitCnt_mux0000(3)
    );
  UART_MOD_portmap_txWaitCnt_mux0000_1_2 : LUT4
    generic map(
      INIT => X"D8A8"
    )
    port map (
      I0 => UART_MOD_portmap_txWaitCnt(1),
      I1 => UART_MOD_portmap_txState_cmp_eq0000,
      I2 => UART_MOD_portmap_N17,
      I3 => UART_MOD_portmap_txWaitCnt(0),
      O => UART_MOD_portmap_txWaitCnt_mux0000(1)
    );
  UART_MOD_portmap_dataCnt_mux0000_3_29 : LUT4
    generic map(
      INIT => X"AAA8"
    )
    port map (
      I0 => UART_MOD_portmap_dataCnt(3),
      I1 => UART_MOD_portmap_dataCnt_mux0000_3_13_137,
      I2 => UART_MOD_portmap_N59,
      I3 => UART_MOD_portmap_rxState_cmp_lt0001,
      O => UART_MOD_portmap_dataCnt_mux0000_3_29_138
    );
  UART_MOD_portmap_dataCnt_mux0000_3_42 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => UART_MOD_portmap_dataCnt(1),
      I1 => UART_MOD_portmap_dataCnt(0),
      I2 => UART_MOD_portmap_dataCnt(2),
      I3 => UART_MOD_portmap_dataCnt(3),
      O => UART_MOD_portmap_dataCnt_mux0000_3_42_139
    );
  UART_MOD_portmap_rxData_o_7_not00011 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => UART_MOD_portmap_N64,
      I1 => UART_MOD_portmap_dataCnt(2),
      I2 => UART_MOD_portmap_N14,
      O => UART_MOD_portmap_rxData_o_7_not0001
    );
  UART_MOD_portmap_rxData_o_6_not00011 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => UART_MOD_portmap_N66,
      I1 => UART_MOD_portmap_dataCnt(2),
      I2 => N166,
      O => UART_MOD_portmap_rxData_o_6_not0001
    );
  UART_MOD_portmap_rxData_o_5_not00011 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => UART_MOD_portmap_N65,
      I1 => UART_MOD_portmap_dataCnt(2),
      I2 => UART_MOD_portmap_N14,
      O => UART_MOD_portmap_rxData_o_5_not0001
    );
  UART_MOD_portmap_rxData_o_4_not00011 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => UART_MOD_portmap_N67,
      I1 => UART_MOD_portmap_dataCnt(2),
      I2 => UART_MOD_portmap_N14,
      O => UART_MOD_portmap_rxData_o_4_not0001
    );
  UART_MOD_portmap_rxData_o_3_not00011 : LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => UART_MOD_portmap_N64,
      I1 => UART_MOD_portmap_dataCnt(2),
      I2 => UART_MOD_portmap_N14,
      O => UART_MOD_portmap_rxData_o_3_not0001
    );
  UART_MOD_portmap_rxData_o_2_not00011 : LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => UART_MOD_portmap_N66,
      I1 => UART_MOD_portmap_dataCnt(2),
      I2 => UART_MOD_portmap_N14,
      O => UART_MOD_portmap_rxData_o_2_not0001
    );
  UART_MOD_portmap_rxData_o_1_not00011 : LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => UART_MOD_portmap_N65,
      I1 => UART_MOD_portmap_dataCnt(2),
      I2 => UART_MOD_portmap_N14,
      O => UART_MOD_portmap_rxData_o_1_not0001
    );
  UART_MOD_portmap_rxData_o_0_not00011 : LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => UART_MOD_portmap_N67,
      I1 => UART_MOD_portmap_dataCnt(2),
      I2 => UART_MOD_portmap_N14,
      O => UART_MOD_portmap_rxData_o_0_not0001
    );
  UART_MOD_portmap_rxState_cmp_le00001 : LUT4
    generic map(
      INIT => X"084C"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(3),
      I1 => UART_MOD_portmap_highCnt(5),
      I2 => UART_MOD_portmap_highCnt(4),
      I3 => N14,
      O => UART_MOD_portmap_rxState_cmp_le0000
    );
  UART_MOD_portmap_Madd_sampleCnt_share0000_cy_4_11 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(4),
      I1 => N167,
      O => UART_MOD_portmap_Madd_sampleCnt_share0000_cy(4)
    );
  UART_MOD_portmap_Madd_txWaitCnt_addsub0000_cy_4_11 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => UART_MOD_portmap_Madd_txWaitCnt_addsub0000_cy_2_Q,
      I1 => UART_MOD_portmap_txWaitCnt(3),
      I2 => UART_MOD_portmap_txWaitCnt(4),
      O => UART_MOD_portmap_Madd_txWaitCnt_addsub0000_cy_4_Q
    );
  UART_MOD_portmap_Madd_highCnt_share0000_cy_2_11 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(2),
      I1 => UART_MOD_portmap_highCnt(1),
      I2 => UART_MOD_portmap_highCnt(0),
      O => UART_MOD_portmap_Madd_highCnt_share0000_cy(2)
    );
  UART_MOD_portmap_Madd_txWaitCnt_addsub0000_cy_2_11 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => UART_MOD_portmap_txWaitCnt(2),
      I1 => UART_MOD_portmap_txWaitCnt(1),
      I2 => UART_MOD_portmap_txWaitCnt(0),
      O => UART_MOD_portmap_Madd_txWaitCnt_addsub0000_cy_2_Q
    );
  UART_MOD_portmap_sampleCnt_mux0002_6_2_SW0 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I1 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      O => N16
    );
  UART_MOD_portmap_sampleCnt_mux0002_0_214 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => UART_MOD_portmap_rxInput(7),
      I1 => UART_MOD_portmap_rxInput(6),
      I2 => UART_MOD_portmap_rxInput(5),
      I3 => UART_MOD_portmap_rxInput(4),
      O => UART_MOD_portmap_sampleCnt_mux0002_0_214_215
    );
  UART_MOD_portmap_sampleCnt_mux0002_0_2144 : LUT4
    generic map(
      INIT => X"7FFF"
    )
    port map (
      I0 => UART_MOD_portmap_rxInput(7),
      I1 => UART_MOD_portmap_rxInput(6),
      I2 => UART_MOD_portmap_rxInput(5),
      I3 => UART_MOD_portmap_rxInput(4),
      O => UART_MOD_portmap_sampleCnt_mux0002_0_2144_216
    );
  UART_MOD_portmap_rxState_FSM_FFd3_In2 : LUT3
    generic map(
      INIT => X"A8"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I1 => UART_MOD_portmap_N68,
      I2 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      O => UART_MOD_portmap_rxState_FSM_FFd3_In2_191
    );
  UART_MOD_portmap_sampleCnt_mux0002_5_1 : LUT4
    generic map(
      INIT => X"E6A0"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(1),
      I1 => UART_MOD_portmap_sampleCnt(0),
      I2 => UART_MOD_portmap_N11,
      I3 => N176,
      O => UART_MOD_portmap_sampleCnt_mux0002_5_Q
    );
  UART_MOD_portmap_sampleCnt_mux0002_1_1 : LUT4
    generic map(
      INIT => X"E6A0"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(5),
      I1 => UART_MOD_portmap_Madd_sampleCnt_share0000_cy(4),
      I2 => UART_MOD_portmap_N11,
      I3 => UART_MOD_portmap_N6,
      O => UART_MOD_portmap_sampleCnt_mux0002_1_Q
    );
  UART_MOD_portmap_txWaitCnt_mux0000_4_Q : LUT4
    generic map(
      INIT => X"D8A8"
    )
    port map (
      I0 => UART_MOD_portmap_txWaitCnt(4),
      I1 => UART_MOD_portmap_txState_cmp_eq0000,
      I2 => UART_MOD_portmap_N17,
      I3 => N28,
      O => UART_MOD_portmap_txWaitCnt_mux0000(4)
    );
  UART_MOD_portmap_txWaitCnt_mux0000_2_SW0 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => UART_MOD_portmap_txWaitCnt(1),
      I1 => UART_MOD_portmap_txWaitCnt(0),
      O => N30
    );
  UART_MOD_portmap_txWaitCnt_mux0000_2_Q : LUT4
    generic map(
      INIT => X"D8A8"
    )
    port map (
      I0 => UART_MOD_portmap_txWaitCnt(2),
      I1 => UART_MOD_portmap_txState_cmp_eq0000,
      I2 => UART_MOD_portmap_N17,
      I3 => N30,
      O => UART_MOD_portmap_txWaitCnt_mux0000(2)
    );
  UART_MOD_portmap_sampleCnt_mux0002_0_Q : LUT4
    generic map(
      INIT => X"E6A0"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(6),
      I1 => N32,
      I2 => UART_MOD_portmap_N11,
      I3 => UART_MOD_portmap_N6,
      O => UART_MOD_portmap_sampleCnt_mux0002_0_Q_214
    );
  UART_MOD_portmap_rxState_cmp_gt000011 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(5),
      I1 => UART_MOD_portmap_highCnt(4),
      I2 => N170,
      O => UART_MOD_portmap_rxState_cmp_gt0000
    );
  UART_MOD_portmap_tx_o_mux000111 : LUT4
    generic map(
      INIT => X"085D"
    )
    port map (
      I0 => UART_MOD_portmap_txBitCnt(2),
      I1 => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(5),
      I2 => UART_MOD_portmap_txBitCnt(1),
      I3 => N36,
      O => UART_MOD_portmap_N8
    );
  UART_MOD_portmap_sampleCnt_mux0002_6_SW1 : LUT4
    generic map(
      INIT => X"FFD1"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I1 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I2 => UART_MOD_portmap_N13,
      I3 => UART_MOD_portmap_N10,
      O => N42
    );
  UART_MOD_portmap_sampleCnt_mux0002_6_Q : LUT4
    generic map(
      INIT => X"FE54"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(0),
      I1 => N41,
      I2 => N173,
      I3 => N42,
      O => UART_MOD_portmap_sampleCnt_mux0002_6_Q_224
    );
  UART_MOD_portmap_tx_o_mux000135 : LUT4
    generic map(
      INIT => X"A820"
    )
    port map (
      I0 => UART_MOD_portmap_txBitCnt(1),
      I1 => UART_MOD_portmap_txBitCnt(2),
      I2 => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(2),
      I3 => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(6),
      O => UART_MOD_portmap_tx_o_mux000135_260
    );
  UART_MOD_portmap_tx_o_mux000150 : LUT4
    generic map(
      INIT => X"0E04"
    )
    port map (
      I0 => UART_MOD_portmap_txBitCnt(2),
      I1 => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(0),
      I2 => UART_MOD_portmap_txBitCnt(1),
      I3 => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(4),
      O => UART_MOD_portmap_tx_o_mux000150_261
    );
  UART_MOD_portmap_tx_o_mux0001114 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => UART_MOD_portmap_txBitCnt(1),
      I1 => UART_MOD_portmap_txBitCnt(2),
      I2 => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(7),
      I3 => UART_MOD_portmap_tx_o_mux0001109_253,
      O => UART_MOD_portmap_tx_o_mux0001114_254
    );
  UART_MOD_portmap_tx_o_mux0001185 : LUT4
    generic map(
      INIT => X"A280"
    )
    port map (
      I0 => UART_MOD_portmap_txBitCnt(0),
      I1 => UART_MOD_portmap_txState_FSM_FFd1_231,
      I2 => UART_MOD_portmap_tx_o_mux0001150_255,
      I3 => UART_MOD_portmap_N8,
      O => UART_MOD_portmap_tx_o_mux0001185_256
    );
  UART_MOD_portmap_tx_o_mux0001198 : LUT4
    generic map(
      INIT => X"FFDC"
    )
    port map (
      I0 => UART_MOD_portmap_txBitCnt(0),
      I1 => UART_MOD_portmap_tx_o_mux0001114_254,
      I2 => UART_MOD_portmap_tx_o_mux000182_262,
      I3 => UART_MOD_portmap_tx_o_mux0001185_256,
      O => UART_MOD_portmap_tx_o_mux0001198_258
    );
  UART_MOD_portmap_highCnt_mux0000_4_1 : LUT4
    generic map(
      INIT => X"EA60"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(4),
      I1 => UART_MOD_portmap_Madd_highCnt_share0000_cy(3),
      I2 => UART_MOD_portmap_N5,
      I3 => N171,
      O => UART_MOD_portmap_highCnt_mux0000(4)
    );
  UART_MOD_portmap_highCnt_mux0000_3_1 : LUT4
    generic map(
      INIT => X"EA60"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(3),
      I1 => UART_MOD_portmap_Madd_highCnt_share0000_cy(2),
      I2 => N179,
      I3 => UART_MOD_portmap_N01,
      O => UART_MOD_portmap_highCnt_mux0000(3)
    );
  UART_MOD_portmap_highCnt_mux0000_1_1 : LUT4
    generic map(
      INIT => X"EC60"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(0),
      I1 => UART_MOD_portmap_highCnt(1),
      I2 => UART_MOD_portmap_N5,
      I3 => UART_MOD_portmap_N01,
      O => UART_MOD_portmap_highCnt_mux0000(1)
    );
  UART_MOD_portmap_highCnt_mux0000_0_15 : LUT3
    generic map(
      INIT => X"D0"
    )
    port map (
      I0 => UART_MOD_portmap_rxInput(0),
      I1 => UART_MOD_portmap_rxState_cmp_gt0000,
      I2 => N178,
      O => UART_MOD_portmap_highCnt_mux0000_0_15_151
    );
  UART_MOD_portmap_highCnt_mux0000_0_130 : LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I1 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      O => UART_MOD_portmap_highCnt_mux0000_0_130_149
    );
  UART_MOD_portmap_highCnt_mux0000_5_78 : LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt_mux0000_5_75_159,
      I1 => UART_MOD_portmap_N63,
      I2 => UART_MOD_portmap_N70,
      I3 => UART_MOD_portmap_highCnt_mux0000_5_48_158,
      O => UART_MOD_portmap_highCnt_mux0000_5_78_160
    );
  UART_MOD_portmap_rxState_cmp_lt00011 : LUT4
    generic map(
      INIT => X"1333"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(4),
      I1 => UART_MOD_portmap_sampleCnt(6),
      I2 => UART_MOD_portmap_sampleCnt(5),
      I3 => N172,
      O => UART_MOD_portmap_rxState_cmp_lt0001
    );
  UART_MOD_portmap_sampleCnt_mux0002_3_27 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(1),
      I1 => UART_MOD_portmap_sampleCnt(2),
      I2 => UART_MOD_portmap_sampleCnt(0),
      O => UART_MOD_portmap_sampleCnt_mux0002_3_27_220
    );
  UART_MOD_portmap_highCnt_mux0000_2_SW0 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(1),
      I1 => UART_MOD_portmap_highCnt(0),
      O => N53
    );
  UART_MOD_portmap_highCnt_mux0000_2_Q : LUT4
    generic map(
      INIT => X"EA60"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(2),
      I1 => N53,
      I2 => UART_MOD_portmap_N5,
      I3 => UART_MOD_portmap_N01,
      O => UART_MOD_portmap_highCnt_mux0000(2)
    );
  RESET_IBUF : IBUF
    port map (
      I => RESET,
      O => RESET_IBUF_86
    );
  RX_IBUF : IBUF
    port map (
      I => RX,
      O => RX_IBUF_88
    );
  TX_OBUF : OBUF
    port map (
      I => UART_MOD_portmap_tx_o_251,
      O => TX
    );
  UART_MOD_portmap_rxState_FSM_FFd2 : FDRS
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxState_FSM_FFd2_In1_189,
      R => RESET_IBUF_86,
      S => UART_MOD_portmap_rxState_FSM_FFd1_186,
      Q => UART_MOD_portmap_rxState_FSM_FFd2_188
    );
  UART_MOD_portmap_rxState_FSM_FFd3 : FDRS
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxState_FSM_FFd3_In52,
      R => RESET_IBUF_86,
      S => UART_MOD_portmap_rxState_FSM_FFd3_In2_191,
      Q => UART_MOD_portmap_rxState_FSM_FFd3_190
    );
  UART_MOD_portmap_rxState_FSM_FFd3_In521 : LUT3
    generic map(
      INIT => X"BA"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd3_In9_194,
      I1 => UART_MOD_portmap_rxState_cmp_lt0001,
      I2 => UART_MOD_portmap_rxState_FSM_FFd3_In33_192,
      O => UART_MOD_portmap_rxState_FSM_FFd3_In52
    );
  UART_MOD_portmap_rxInput_0 : FDRS
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_rxInput_cmp_gt00001,
      R => RESET_IBUF_86,
      S => UART_MOD_portmap_rxWeight(2),
      Q => UART_MOD_portmap_rxInput(0)
    );
  UART_MOD_portmap_rxInput_cmp_gt000011 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => UART_MOD_portmap_rxWeight(1),
      I1 => UART_MOD_portmap_rxWeight(0),
      O => UART_MOD_portmap_rxInput_cmp_gt00001
    );
  UART_MOD_portmap_sampleCnt_4 : FDRS
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_sampleCnt_mux0002_2_1_219,
      R => RESET_IBUF_86,
      S => UART_MOD_portmap_N10,
      Q => UART_MOD_portmap_sampleCnt(4)
    );
  UART_MOD_portmap_sampleCnt_3 : FDRS
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_sampleCnt_mux0002_3_48,
      R => RESET_IBUF_86,
      S => UART_MOD_portmap_N10,
      Q => UART_MOD_portmap_sampleCnt(3)
    );
  UART_MOD_portmap_highCnt_5 : FDRS
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_highCnt_mux0000_5_78_160,
      R => RESET_IBUF_86,
      S => UART_MOD_portmap_highCnt_mux0000_5_35_157,
      Q => UART_MOD_portmap_highCnt(5)
    );
  UART_MOD_portmap_dataCnt_3 : FDRS
    generic map(
      INIT => '0'
    )
    port map (
      C => CLOCK_BUFGP_1,
      D => UART_MOD_portmap_dataCnt_mux0000_3_49,
      R => RESET_IBUF_86,
      S => UART_MOD_portmap_dataCnt_mux0000_3_29_138,
      Q => UART_MOD_portmap_dataCnt(3)
    );
  UART_MOD_portmap_sampleCnt_mux0002_4_SW3 : LUT4
    generic map(
      INIT => X"EA6A"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(2),
      I1 => UART_MOD_portmap_sampleCnt(0),
      I2 => UART_MOD_portmap_sampleCnt(1),
      I3 => N174,
      O => N56
    );
  UART_MOD_portmap_sampleCnt_mux0002_4_Q : LUT4
    generic map(
      INIT => X"FECE"
    )
    port map (
      I0 => N55,
      I1 => UART_MOD_portmap_N10,
      I2 => UART_MOD_portmap_N7,
      I3 => N56,
      O => UART_MOD_portmap_sampleCnt_mux0002_4_Q_222
    );
  UART_MOD_portmap_sampleCnt_mux0002_2_1 : LUT4
    generic map(
      INIT => X"EA60"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(4),
      I1 => UART_MOD_portmap_Madd_sampleCnt_share0000_cy(3),
      I2 => UART_MOD_portmap_N7,
      I3 => UART_MOD_portmap_N11,
      O => UART_MOD_portmap_sampleCnt_mux0002_2_1_219
    );
  UART_MOD_portmap_sampleCnt_mux0002_0_2167_SW0 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => UART_MOD_portmap_rxSync_201,
      I1 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      O => N67
    );
  UART_MOD_portmap_sampleCnt_mux0002_6_2 : LUT4
    generic map(
      INIT => X"0100"
    )
    port map (
      I0 => N67,
      I1 => N16,
      I2 => UART_MOD_portmap_sampleCnt_mux0002_0_2156_217,
      I3 => UART_MOD_portmap_rxState_cmp_lt0001,
      O => UART_MOD_portmap_N10
    );
  UART_MOD_portmap_sampleCnt_mux0002_6_31_SW0 : LUT4
    generic map(
      INIT => X"3726"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I1 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I2 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I3 => N164,
      O => N72
    );
  UART_MOD_portmap_sampleCnt_mux0002_6_31_SW1 : LUT4
    generic map(
      INIT => X"DFDA"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I1 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I2 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I3 => UART_MOD_portmap_rxState_cmp_eq0000,
      O => N73
    );
  UART_MOD_portmap_tx_o_mux0001150_SW0 : LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(4),
      I1 => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(2),
      I2 => UART_MOD_portmap_txBitCnt(1),
      O => N80
    );
  UART_MOD_portmap_txWaitCnt_mux0000_6_Q : LUT4
    generic map(
      INIT => X"CE82"
    )
    port map (
      I0 => N180,
      I1 => UART_MOD_portmap_txWaitCnt(6),
      I2 => N82,
      I3 => UART_MOD_portmap_txState_cmp_eq0000,
      O => UART_MOD_portmap_txWaitCnt_mux0000(6)
    );
  UART_MOD_portmap_tx_o_mux0001227 : LUT4
    generic map(
      INIT => X"F2F0"
    )
    port map (
      I0 => UART_MOD_portmap_txState_FSM_FFd2_233,
      I1 => UART_MOD_portmap_txState_cmp_lt0000,
      I2 => UART_MOD_portmap_tx_o_mux000119_257,
      I3 => UART_MOD_portmap_tx_o_mux0001198_258,
      O => UART_MOD_portmap_tx_o_mux0001
    );
  UART_MOD_portmap_sampleCnt_mux0002_0_221_SW1 : LUT4
    generic map(
      INIT => X"343C"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(6),
      I1 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I2 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I3 => N175,
      O => N61
    );
  UART_MOD_portmap_dataCnt_mux0000_0_11_SW0 : LUT3
    generic map(
      INIT => X"27"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I1 => UART_MOD_portmap_dataCnt(0),
      I2 => UART_MOD_portmap_dataCnt(3),
      O => N86
    );
  UART_MOD_portmap_dataCnt_mux0000_0_11_SW1 : LUT4
    generic map(
      INIT => X"2A7F"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I1 => UART_MOD_portmap_dataCnt(1),
      I2 => UART_MOD_portmap_dataCnt(0),
      I3 => UART_MOD_portmap_dataCnt(3),
      O => N88
    );
  UART_MOD_portmap_sampleCnt_mux0002_6_SW0 : LUT4
    generic map(
      INIT => X"5355"
    )
    port map (
      I0 => N96,
      I1 => N97,
      I2 => UART_MOD_portmap_sampleCnt_mux0002_0_2156_217,
      I3 => UART_MOD_portmap_rxState_cmp_lt0001,
      O => N41
    );
  UART_MOD_portmap_sampleCnt_mux0002_0_221_SW0 : LUT4
    generic map(
      INIT => X"0222"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I1 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I2 => UART_MOD_portmap_sampleCnt(6),
      I3 => N84,
      O => N60
    );
  UART_MOD_portmap_sampleCnt_mux0002_0_2_SW0 : LUT4
    generic map(
      INIT => X"CFCE"
    )
    port map (
      I0 => UART_MOD_portmap_rxSync_201,
      I1 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I2 => N165,
      I3 => UART_MOD_portmap_sampleCnt_mux0002_0_2156_217,
      O => N101
    );
  UART_MOD_portmap_highCnt_mux0000_5_35 : LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(5),
      I1 => UART_MOD_portmap_highCnt_mux0000_5_13_156,
      I2 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I3 => N103,
      O => UART_MOD_portmap_highCnt_mux0000_5_35_157
    );
  UART_MOD_portmap_highCnt_mux0000_0_211 : LUT4
    generic map(
      INIT => X"007F"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(4),
      I1 => UART_MOD_portmap_sampleCnt(5),
      I2 => N47,
      I3 => N108,
      O => UART_MOD_portmap_N63
    );
  UART_MOD_portmap_highCnt_mux0000_0_22_SW0 : LUT4
    generic map(
      INIT => X"007F"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(4),
      I1 => UART_MOD_portmap_sampleCnt(5),
      I2 => N47,
      I3 => N177,
      O => N51
    );
  UART_MOD_portmap_highCnt_mux0000_0_145_SW0 : LUT3
    generic map(
      INIT => X"F8"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(3),
      I1 => UART_MOD_portmap_sampleCnt(2),
      I2 => UART_MOD_portmap_sampleCnt(4),
      O => N112
    );
  UART_MOD_portmap_rxState_FSM_FFd2_In1_SW0 : LUT4
    generic map(
      INIT => X"A888"
    )
    port map (
      I0 => UART_MOD_portmap_rxInput(0),
      I1 => UART_MOD_portmap_highCnt(5),
      I2 => UART_MOD_portmap_N30,
      I3 => UART_MOD_portmap_highCnt(4),
      O => N114
    );
  UART_MOD_portmap_rxState_FSM_FFd2_In1 : LUT4
    generic map(
      INIT => X"3C1C"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_cmp_lt0000,
      I1 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I2 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I3 => N114,
      O => UART_MOD_portmap_rxState_FSM_FFd2_In1_189
    );
  UART_MOD_portmap_highCnt_mux0000_5_75 : LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(5),
      I1 => UART_MOD_portmap_highCnt(4),
      I2 => UART_MOD_portmap_highCnt(3),
      I3 => UART_MOD_portmap_Madd_highCnt_share0000_cy(2),
      O => UART_MOD_portmap_highCnt_mux0000_5_75_159
    );
  UART_MOD_portmap_txWaitCnt_mux0000_6_SW2 : LUT4
    generic map(
      INIT => X"7FFF"
    )
    port map (
      I0 => UART_MOD_portmap_Madd_txWaitCnt_addsub0000_cy_2_Q,
      I1 => UART_MOD_portmap_txWaitCnt(3),
      I2 => UART_MOD_portmap_txWaitCnt(4),
      I3 => UART_MOD_portmap_txWaitCnt(5),
      O => N82
    );
  UART_MOD_portmap_dataCnt_mux0000_3_491 : LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_cmp_lt0001,
      I1 => UART_MOD_portmap_dataCnt_mux0000_3_42_139,
      I2 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I3 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      O => UART_MOD_portmap_dataCnt_mux0000_3_49
    );
  UART_MOD_portmap_rxData_o_0_not00012_SW0 : LUT3
    generic map(
      INIT => X"DF"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I1 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I2 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      O => N12
    );
  UART_MOD_portmap_rxSync_not00011_SW0 : LUT3
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I1 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I2 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      O => N116
    );
  UART_MOD_portmap_rxSync_not00011 : LUT4
    generic map(
      INIT => X"0133"
    )
    port map (
      I0 => UART_MOD_portmap_rxSync_201,
      I1 => N116,
      I2 => UART_MOD_portmap_sampleCnt_mux0002_0_2156_217,
      I3 => UART_MOD_portmap_rxState_cmp_lt0001,
      O => UART_MOD_portmap_rxSync_not0001
    );
  UART_MOD_portmap_highCnt_mux0000_5_22_SW0_SW0 : LUT3
    generic map(
      INIT => X"F1"
    )
    port map (
      I0 => UART_MOD_portmap_rxInput(0),
      I1 => UART_MOD_portmap_sampleCnt(6),
      I2 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      O => N118
    );
  UART_MOD_portmap_highCnt_mux0000_5_22_SW0_SW1 : LUT4
    generic map(
      INIT => X"FF01"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(4),
      I1 => UART_MOD_portmap_rxInput(0),
      I2 => UART_MOD_portmap_sampleCnt(6),
      I3 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      O => N119
    );
  UART_MOD_portmap_highCnt_mux0000_0_116 : LUT4
    generic map(
      INIT => X"8088"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I1 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I2 => N121,
      I3 => UART_MOD_portmap_rxState_cmp_lt0001,
      O => UART_MOD_portmap_highCnt_mux0000_0_116_148
    );
  UART_MOD_portmap_highCnt_mux0000_0_143 : LUT4
    generic map(
      INIT => X"2223"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt_mux0000_0_130_149,
      I1 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I2 => UART_MOD_portmap_rxInput(0),
      I3 => N125,
      O => UART_MOD_portmap_highCnt_mux0000_0_143_150
    );
  UART_MOD_portmap_highCnt_mux0000_0_3 : MUXF5
    port map (
      I0 => N129,
      I1 => N130,
      S => UART_MOD_portmap_highCnt(0),
      O => UART_MOD_portmap_highCnt_mux0000(0)
    );
  UART_MOD_portmap_highCnt_mux0000_0_3_G : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt_mux0000_0_143_150,
      I1 => UART_MOD_portmap_highCnt_mux0000_0_15_151,
      I2 => UART_MOD_portmap_highCnt_mux0000_0_116_148,
      O => N130
    );
  UART_MOD_portmap_highCnt_mux0000_0_21_SW0 : MUXF5
    port map (
      I0 => N133,
      I1 => N134,
      S => UART_MOD_portmap_rxInput(0),
      O => N127
    );
  UART_MOD_portmap_highCnt_mux0000_0_21_SW0_F : LUT4
    generic map(
      INIT => X"007F"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(4),
      I1 => UART_MOD_portmap_sampleCnt(5),
      I2 => N47,
      I3 => N110,
      O => N133
    );
  UART_MOD_portmap_highCnt_mux0000_0_21_SW0_G : LUT4
    generic map(
      INIT => X"0507"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(6),
      I1 => UART_MOD_portmap_sampleCnt(5),
      I2 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I3 => N112,
      O => N134
    );
  UART_MOD_portmap_highCnt_mux0000_0_3_F_SW0 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => UART_MOD_portmap_rxInput(0),
      I1 => UART_MOD_portmap_N68,
      I2 => N51,
      O => N135
    );
  UART_MOD_portmap_highCnt_mux0000_0_3_F : LUT4
    generic map(
      INIT => X"F2F0"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I1 => UART_MOD_portmap_rxState_cmp_gt0000,
      I2 => UART_MOD_portmap_N63,
      I3 => N135,
      O => N129
    );
  UART_MOD_portmap_txWaitCnt_mux0000_1_11_SW0 : LUT3
    generic map(
      INIT => X"A8"
    )
    port map (
      I0 => UART_MOD_portmap_txWaitCnt(6),
      I1 => N168,
      I2 => UART_MOD_portmap_txWaitCnt(4),
      O => N137
    );
  UART_MOD_portmap_Madd_highCnt_share0000_cy_3_11 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(3),
      I1 => UART_MOD_portmap_highCnt(2),
      I2 => UART_MOD_portmap_highCnt(1),
      I3 => UART_MOD_portmap_highCnt(0),
      O => UART_MOD_portmap_Madd_highCnt_share0000_cy(3)
    );
  UART_MOD_portmap_rxState_FSM_FFd3_In9 : LUT4
    generic map(
      INIT => X"0004"
    )
    port map (
      I0 => UART_MOD_portmap_rxInput(0),
      I1 => UART_MOD_portmap_rxInput(1),
      I2 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I3 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      O => UART_MOD_portmap_rxState_FSM_FFd3_In9_194
    );
  UART_MOD_portmap_txWaitCnt_mux0000_4_SW0 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => UART_MOD_portmap_txWaitCnt(3),
      I1 => UART_MOD_portmap_txWaitCnt(2),
      I2 => UART_MOD_portmap_txWaitCnt(1),
      I3 => UART_MOD_portmap_txWaitCnt(0),
      O => N28
    );
  UART_MOD_portmap_highCnt_mux0000_5_48 : LUT4
    generic map(
      INIT => X"01FF"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(3),
      I1 => UART_MOD_portmap_highCnt(1),
      I2 => UART_MOD_portmap_highCnt(2),
      I3 => UART_MOD_portmap_highCnt(4),
      O => UART_MOD_portmap_highCnt_mux0000_5_48_158
    );
  UART_MOD_portmap_highCnt_mux0000_5_13_SW0 : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(5),
      I1 => UART_MOD_portmap_sampleCnt(2),
      I2 => UART_MOD_portmap_sampleCnt(3),
      O => N139
    );
  UART_MOD_portmap_dataCnt_mux0000_2_SW2 : LUT4
    generic map(
      INIT => X"FFF7"
    )
    port map (
      I0 => UART_MOD_portmap_dataCnt(1),
      I1 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I2 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I3 => UART_MOD_portmap_rxState_cmp_lt0001,
      O => N141
    );
  UART_MOD_portmap_dataCnt_mux0000_2_Q : LUT4
    generic map(
      INIT => X"A0E4"
    )
    port map (
      I0 => UART_MOD_portmap_dataCnt(2),
      I1 => UART_MOD_portmap_dataCnt(0),
      I2 => N20,
      I3 => N141,
      O => UART_MOD_portmap_dataCnt_mux0000(2)
    );
  UART_MOD_portmap_txState_FSM_FFd2_In : LUT4
    generic map(
      INIT => X"8F8A"
    )
    port map (
      I0 => UART_MOD_portmap_txState_FSM_FFd2_233,
      I1 => N143,
      I2 => UART_MOD_portmap_txState_FSM_FFd1_231,
      I3 => UART_CONTROLLER_portmap_start_tx_flag_sig_98,
      O => UART_MOD_portmap_txState_FSM_FFd2_In_234
    );
  UART_MOD_portmap_dataCnt_mux0000_0_2_SW0 : LUT4
    generic map(
      INIT => X"46EE"
    )
    port map (
      I0 => UART_MOD_portmap_dataCnt(0),
      I1 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I2 => UART_MOD_portmap_dataCnt(3),
      I3 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      O => N145
    );
  UART_MOD_portmap_dataCnt_mux0000_0_2 : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => UART_MOD_portmap_dataCnt(0),
      I1 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I2 => UART_MOD_portmap_rxState_cmp_lt0001,
      I3 => N145,
      O => UART_MOD_portmap_dataCnt_mux0000(0)
    );
  CLOCK_BUFGP : BUFGP
    port map (
      I => CLOCK,
      O => CLOCK_BUFGP_1
    );
  UART_MOD_portmap_Result_0_1_INV_0 : INV
    port map (
      I => UART_MOD_portmap_rxWeight(0),
      O => UART_MOD_portmap_Result(0)
    );
  UART_MOD_portmap_Mcount_txBitCnt_xor_0_11_INV_0 : INV
    port map (
      I => UART_MOD_portmap_txBitCnt(0),
      O => UART_MOD_portmap_Result_0_1
    );
  UART_MOD_portmap_rxState_FSM_FFd1_In : MUXF5
    port map (
      I0 => N149,
      I1 => N150,
      S => UART_MOD_portmap_rxState_cmp_lt0001,
      O => UART_MOD_portmap_rxState_FSM_FFd1_In_187
    );
  UART_MOD_portmap_rxState_FSM_FFd1_In_F : LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I1 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I2 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      O => N149
    );
  UART_MOD_portmap_rxState_FSM_FFd1_In_G : LUT4
    generic map(
      INIT => X"8AAA"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I1 => UART_MOD_portmap_rxInput(0),
      I2 => UART_MOD_portmap_rxState_cmp_gt0000,
      I3 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      O => N150
    );
  UART_MOD_portmap_dataCnt_mux0000_1_Q : MUXF5
    port map (
      I0 => N151,
      I1 => N152,
      S => UART_MOD_portmap_dataCnt(1),
      O => UART_MOD_portmap_dataCnt_mux0000(1)
    );
  UART_MOD_portmap_dataCnt_mux0000_1_F : LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_cmp_lt0001,
      I1 => UART_MOD_portmap_dataCnt(0),
      I2 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I3 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      O => N151
    );
  UART_MOD_portmap_dataCnt_mux0000_1_G : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_cmp_lt0001,
      I1 => UART_MOD_portmap_N59,
      I2 => N86,
      O => N152
    );
  UART_MOD_portmap_rxState_FSM_FFd3_In33 : MUXF5
    port map (
      I0 => N153,
      I1 => N154,
      S => UART_MOD_portmap_rxState_FSM_FFd1_186,
      O => UART_MOD_portmap_rxState_FSM_FFd3_In33_192
    );
  UART_MOD_portmap_rxState_FSM_FFd3_In33_F : LUT3
    generic map(
      INIT => X"20"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I1 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I2 => UART_MOD_portmap_dataCnt(3),
      O => N153
    );
  UART_MOD_portmap_rxState_FSM_FFd3_In33_G : LUT4
    generic map(
      INIT => X"3222"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(5),
      I1 => UART_MOD_portmap_rxState_cmp_le0000,
      I2 => UART_MOD_portmap_highCnt(4),
      I3 => UART_MOD_portmap_N30,
      O => N154
    );
  UART_MOD_portmap_sampleCnt_mux0002_3_481 : MUXF5
    port map (
      I0 => N155,
      I1 => N156,
      S => UART_MOD_portmap_sampleCnt(3),
      O => UART_MOD_portmap_sampleCnt_mux0002_3_48
    );
  UART_MOD_portmap_sampleCnt_mux0002_3_481_F : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => UART_MOD_portmap_N7,
      I1 => UART_MOD_portmap_sampleCnt(0),
      I2 => UART_MOD_portmap_sampleCnt(2),
      I3 => UART_MOD_portmap_sampleCnt(1),
      O => N155
    );
  UART_MOD_portmap_sampleCnt_mux0002_3_481_G : LUT3
    generic map(
      INIT => X"EA"
    )
    port map (
      I0 => UART_MOD_portmap_N11,
      I1 => UART_MOD_portmap_N7,
      I2 => UART_MOD_portmap_sampleCnt_mux0002_3_27_220,
      O => N156
    );
  UART_MOD_portmap_highCnt_mux0000_5_13 : MUXF5
    port map (
      I0 => N157,
      I1 => N158,
      S => UART_MOD_portmap_rxState_FSM_FFd3_190,
      O => UART_MOD_portmap_highCnt_mux0000_5_13_156
    );
  UART_MOD_portmap_highCnt_mux0000_5_13_F : LUT2
    generic map(
      INIT => X"7"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I1 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      O => N157
    );
  UART_MOD_portmap_highCnt_mux0000_5_13_G : LUT4
    generic map(
      INIT => X"0133"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(4),
      I1 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I2 => N139,
      I3 => UART_MOD_portmap_sampleCnt(6),
      O => N158
    );
  UART_MOD_portmap_sampleCnt_mux0002_6_2_SW2 : MUXF5
    port map (
      I0 => N159,
      I1 => N160,
      S => UART_MOD_portmap_rxState_FSM_FFd2_188,
      O => N97
    );
  UART_MOD_portmap_sampleCnt_mux0002_6_2_SW2_F : LUT3
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => UART_MOD_portmap_rxInput(0),
      I1 => UART_MOD_portmap_rxInput(1),
      I2 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      O => N159
    );
  UART_MOD_portmap_sampleCnt_mux0002_6_2_SW2_G : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => UART_MOD_portmap_rxSync_201,
      I1 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I2 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      O => N160
    );
  UART_MOD_portmap_sampleCnt_mux0002_0_2156 : MUXF5
    port map (
      I0 => N161,
      I1 => N162,
      S => UART_MOD_portmap_rxInput(1),
      O => UART_MOD_portmap_sampleCnt_mux0002_0_2156_217
    );
  UART_MOD_portmap_sampleCnt_mux0002_0_2156_F : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt_mux0002_0_2144_216,
      I1 => UART_MOD_portmap_rxInput(0),
      I2 => UART_MOD_portmap_rxInput(2),
      I3 => UART_MOD_portmap_rxInput(3),
      O => N161
    );
  UART_MOD_portmap_sampleCnt_mux0002_0_2156_G : LUT4
    generic map(
      INIT => X"F7FF"
    )
    port map (
      I0 => UART_MOD_portmap_rxInput(0),
      I1 => UART_MOD_portmap_rxInput(2),
      I2 => UART_MOD_portmap_sampleCnt_mux0002_0_214_215,
      I3 => UART_MOD_portmap_rxInput(3),
      O => N162
    );
  UART_MOD_portmap_rxState_cmp_lt000011 : LUT4
    generic map(
      INIT => X"0111"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(5),
      I1 => UART_MOD_portmap_sampleCnt(4),
      I2 => UART_MOD_portmap_sampleCnt(3),
      I3 => UART_MOD_portmap_sampleCnt(2),
      O => UART_MOD_portmap_rxState_cmp_lt00001
    );
  UART_MOD_portmap_rxState_cmp_lt00001_f5 : MUXF5
    port map (
      I0 => N1,
      I1 => UART_MOD_portmap_rxState_cmp_lt00001,
      S => UART_MOD_portmap_sampleCnt(6),
      O => UART_MOD_portmap_rxState_cmp_lt0000
    );
  UART_MOD_portmap_sampleCnt_mux0002_6_3111 : LUT4
    generic map(
      INIT => X"EAAA"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(6),
      I1 => N47,
      I2 => UART_MOD_portmap_sampleCnt(5),
      I3 => UART_MOD_portmap_sampleCnt(4),
      O => UART_MOD_portmap_sampleCnt_mux0002_6_311
    );
  UART_MOD_portmap_sampleCnt_mux0002_6_311_f5 : MUXF5
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I1 => UART_MOD_portmap_sampleCnt_mux0002_6_311,
      S => UART_MOD_portmap_rxState_FSM_FFd1_186,
      O => UART_MOD_portmap_N13
    );
  UART_MOD_portmap_rxState_cmp_eq00001 : LUT2_D
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => UART_MOD_portmap_rxInput(1),
      I1 => UART_MOD_portmap_rxInput(0),
      LO => N164,
      O => UART_MOD_portmap_rxState_cmp_eq0000
    );
  UART_MOD_portmap_dataCnt_mux0000_0_111 : LUT2_D
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I1 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      LO => N165,
      O => UART_MOD_portmap_N59
    );
  UART_MOD_portmap_dataCnt_mux0000_3_13 : LUT4_L
    generic map(
      INIT => X"2AAA"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I1 => UART_MOD_portmap_dataCnt(1),
      I2 => UART_MOD_portmap_dataCnt(0),
      I3 => UART_MOD_portmap_dataCnt(2),
      LO => UART_MOD_portmap_dataCnt_mux0000_3_13_137
    );
  UART_MOD_portmap_rxData_o_0_not00012 : LUT4_D
    generic map(
      INIT => X"0051"
    )
    port map (
      I0 => N12,
      I1 => UART_MOD_portmap_rxState_cmp_gt0000,
      I2 => UART_MOD_portmap_rxState_cmp_le0000,
      I3 => UART_MOD_portmap_rxState_cmp_lt0001,
      LO => N166,
      O => UART_MOD_portmap_N14
    );
  UART_MOD_portmap_rxState_cmp_le00001_SW0 : LUT3_L
    generic map(
      INIT => X"A1"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(2),
      I1 => UART_MOD_portmap_highCnt(1),
      I2 => UART_MOD_portmap_highCnt(4),
      LO => N14
    );
  UART_MOD_portmap_Madd_sampleCnt_share0000_cy_3_11 : LUT4_D
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(3),
      I1 => UART_MOD_portmap_sampleCnt(2),
      I2 => UART_MOD_portmap_sampleCnt(1),
      I3 => UART_MOD_portmap_sampleCnt(0),
      LO => N167,
      O => UART_MOD_portmap_Madd_sampleCnt_share0000_cy(3)
    );
  UART_MOD_portmap_txState_cmp_lt00001_SW0 : LUT4_D
    generic map(
      INIT => X"EAAA"
    )
    port map (
      I0 => UART_MOD_portmap_txWaitCnt(3),
      I1 => UART_MOD_portmap_txWaitCnt(2),
      I2 => UART_MOD_portmap_txWaitCnt(1),
      I3 => UART_MOD_portmap_txWaitCnt(0),
      LO => N168,
      O => N34
    );
  UART_MOD_portmap_txState_cmp_lt00001 : LUT4_D
    generic map(
      INIT => X"57FF"
    )
    port map (
      I0 => UART_MOD_portmap_txWaitCnt(6),
      I1 => N34,
      I2 => UART_MOD_portmap_txWaitCnt(4),
      I3 => UART_MOD_portmap_txWaitCnt(5),
      LO => N169,
      O => UART_MOD_portmap_txState_cmp_lt0000
    );
  UART_MOD_portmap_rxState_cmp_gt000021 : LUT3_D
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(3),
      I1 => UART_MOD_portmap_highCnt(2),
      I2 => UART_MOD_portmap_highCnt(1),
      LO => N170,
      O => UART_MOD_portmap_N30
    );
  UART_MOD_portmap_tx_o_mux000111_SW0 : LUT3_L
    generic map(
      INIT => X"35"
    )
    port map (
      I0 => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(1),
      I1 => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(3),
      I2 => UART_MOD_portmap_txBitCnt(1),
      LO => N36
    );
  UART_MOD_portmap_tx_o_mux000119 : LUT4_L
    generic map(
      INIT => X"A820"
    )
    port map (
      I0 => UART_MOD_portmap_tx_o_251,
      I1 => UART_MOD_portmap_txState_FSM_FFd2_233,
      I2 => UART_MOD_portmap_tx_o_mux00013,
      I3 => UART_MOD_portmap_txState_cmp_lt0000,
      LO => UART_MOD_portmap_tx_o_mux000119_257
    );
  UART_MOD_portmap_tx_o_mux000182 : LUT4_L
    generic map(
      INIT => X"FE54"
    )
    port map (
      I0 => UART_MOD_portmap_txState_FSM_FFd1_231,
      I1 => UART_MOD_portmap_tx_o_mux000150_261,
      I2 => UART_MOD_portmap_tx_o_mux000135_260,
      I3 => UART_MOD_portmap_N8,
      LO => UART_MOD_portmap_tx_o_mux000182_262
    );
  UART_MOD_portmap_tx_o_mux0001109 : LUT2_L
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => UART_MOD_portmap_txBitCnt(0),
      I1 => UART_MOD_portmap_txState_FSM_FFd1_231,
      LO => UART_MOD_portmap_tx_o_mux0001109_253
    );
  UART_MOD_portmap_highCnt_mux0000_0_148 : LUT3_D
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt_mux0000_0_143_150,
      I1 => UART_MOD_portmap_highCnt_mux0000_0_15_151,
      I2 => UART_MOD_portmap_highCnt_mux0000_0_116_148,
      LO => N171,
      O => UART_MOD_portmap_N01
    );
  UART_MOD_portmap_rxState_cmp_lt00011_SW0 : LUT4_D
    generic map(
      INIT => X"FFEA"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(3),
      I1 => UART_MOD_portmap_sampleCnt(1),
      I2 => UART_MOD_portmap_sampleCnt(0),
      I3 => UART_MOD_portmap_sampleCnt(2),
      LO => N172,
      O => N47
    );
  UART_MOD_portmap_highCnt_mux0000_0_22 : LUT4_L
    generic map(
      INIT => X"A820"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I1 => UART_MOD_portmap_rxInput(0),
      I2 => N51,
      I3 => UART_MOD_portmap_N68,
      LO => UART_MOD_portmap_N70
    );
  UART_MOD_portmap_sampleCnt_mux0002_6_11 : LUT4_D
    generic map(
      INIT => X"EEF0"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      I1 => N61,
      I2 => N60,
      I3 => UART_MOD_portmap_rxState_cmp_lt0001,
      LO => N173,
      O => UART_MOD_portmap_N7
    );
  UART_MOD_portmap_sampleCnt_mux0002_0_11 : LUT3_D
    generic map(
      INIT => X"35"
    )
    port map (
      I0 => N72,
      I1 => N73,
      I2 => UART_MOD_portmap_rxState_cmp_lt0001,
      LO => N174,
      O => UART_MOD_portmap_N11
    );
  UART_MOD_portmap_tx_o_mux0001150 : LUT4_L
    generic map(
      INIT => X"FBC8"
    )
    port map (
      I0 => UART_CONTROLLER_portmap_byte_in2uart_tx_sig(6),
      I1 => UART_MOD_portmap_txBitCnt(2),
      I2 => UART_MOD_portmap_txBitCnt(1),
      I3 => N80,
      LO => UART_MOD_portmap_tx_o_mux0001150_255
    );
  UART_MOD_portmap_sampleCnt_mux0002_0_221_SW1_SW0 : LUT4_D
    generic map(
      INIT => X"FFF8"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(3),
      I1 => UART_MOD_portmap_sampleCnt(2),
      I2 => UART_MOD_portmap_sampleCnt(4),
      I3 => UART_MOD_portmap_sampleCnt(5),
      LO => N175,
      O => N84
    );
  UART_MOD_portmap_sampleCnt_mux0002_4_SW2 : LUT4_L
    generic map(
      INIT => X"0A22"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(2),
      I1 => N72,
      I2 => N73,
      I3 => UART_MOD_portmap_rxState_cmp_lt0001,
      LO => N55
    );
  UART_MOD_portmap_sampleCnt_mux0002_0_2 : LUT4_D
    generic map(
      INIT => X"F888"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I1 => UART_MOD_portmap_N68,
      I2 => UART_MOD_portmap_rxState_cmp_lt0001,
      I3 => N101,
      LO => N176,
      O => UART_MOD_portmap_N6
    );
  UART_MOD_portmap_rxState_cmp_lt00011_SW3 : LUT4_L
    generic map(
      INIT => X"FDFF"
    )
    port map (
      I0 => UART_MOD_portmap_rxInput(0),
      I1 => UART_MOD_portmap_sampleCnt(6),
      I2 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I3 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      LO => N108
    );
  UART_MOD_portmap_rxState_cmp_lt00011_SW4 : LUT2_D
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(6),
      I1 => UART_MOD_portmap_rxState_FSM_FFd1_186,
      LO => N177,
      O => N110
    );
  UART_MOD_portmap_highCnt_mux0000_0_145 : LUT4_D
    generic map(
      INIT => X"0507"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(6),
      I1 => UART_MOD_portmap_sampleCnt(5),
      I2 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I3 => N112,
      LO => N178,
      O => UART_MOD_portmap_N68
    );
  UART_MOD_portmap_sampleCnt_mux0002_0_SW0 : LUT3_L
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(4),
      I1 => UART_MOD_portmap_Madd_sampleCnt_share0000_cy(3),
      I2 => UART_MOD_portmap_sampleCnt(5),
      LO => N32
    );
  UART_MOD_portmap_sampleCnt_mux0002_6_2_SW1 : LUT4_L
    generic map(
      INIT => X"FEFF"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I1 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I2 => UART_MOD_portmap_rxInput(0),
      I3 => UART_MOD_portmap_rxInput(1),
      LO => N96
    );
  UART_MOD_portmap_highCnt_mux0000_5_22_SW0 : LUT4_L
    generic map(
      INIT => X"EC4C"
    )
    port map (
      I0 => N47,
      I1 => N118,
      I2 => UART_MOD_portmap_sampleCnt(5),
      I3 => N119,
      LO => N103
    );
  UART_MOD_portmap_highCnt_mux0000_0_116_SW0 : LUT4_L
    generic map(
      INIT => X"FEFA"
    )
    port map (
      I0 => UART_MOD_portmap_highCnt(5),
      I1 => UART_MOD_portmap_highCnt(4),
      I2 => UART_MOD_portmap_rxInput(0),
      I3 => UART_MOD_portmap_N30,
      LO => N121
    );
  UART_MOD_portmap_highCnt_mux0000_0_143_SW0 : LUT4_L
    generic map(
      INIT => X"F8F0"
    )
    port map (
      I0 => UART_MOD_portmap_sampleCnt(4),
      I1 => UART_MOD_portmap_sampleCnt(5),
      I2 => UART_MOD_portmap_sampleCnt(6),
      I3 => N47,
      LO => N125
    );
  UART_MOD_portmap_highCnt_mux0000_0_21 : LUT4_D
    generic map(
      INIT => X"F2F0"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I1 => UART_MOD_portmap_rxState_cmp_gt0000,
      I2 => UART_MOD_portmap_N63,
      I3 => N127,
      LO => N179,
      O => UART_MOD_portmap_N5
    );
  UART_MOD_portmap_txWaitCnt_mux0000_1_11 : LUT4_D
    generic map(
      INIT => X"54FC"
    )
    port map (
      I0 => UART_MOD_portmap_txWaitCnt(5),
      I1 => UART_MOD_portmap_txState_FSM_FFd2_233,
      I2 => UART_MOD_portmap_txState_FSM_FFd1_231,
      I3 => N137,
      LO => N180,
      O => UART_MOD_portmap_N17
    );
  UART_MOD_portmap_dataCnt_mux0000_2_SW0 : LUT4_L
    generic map(
      INIT => X"FFFD"
    )
    port map (
      I0 => UART_MOD_portmap_rxState_FSM_FFd2_188,
      I1 => UART_MOD_portmap_rxState_FSM_FFd3_190,
      I2 => N88,
      I3 => UART_MOD_portmap_rxState_cmp_lt0001,
      LO => N20
    );
  UART_MOD_portmap_txState_FSM_FFd2_In_SW2 : LUT4_L
    generic map(
      INIT => X"F7FF"
    )
    port map (
      I0 => UART_MOD_portmap_txBitCnt(0),
      I1 => UART_MOD_portmap_txBitCnt(1),
      I2 => UART_MOD_portmap_txState_cmp_lt0000,
      I3 => UART_MOD_portmap_txBitCnt(2),
      LO => N143
    );

end Structure;

