----------------------------------------------------------------------------------
-- Company:         DFKI Bremen
-- Engineer:        Florian Hühn
-- 
-- Create Date:     15:20:59 02/06/2013 
-- Design Name: 
-- Package Name:    asynch_sercomm_config_pack
-- Project Name: 
-- Target Devices:  Spartan6
-- Tool versions: 
-- Description:     configuration file for asynch-sercomm
--                  CLK_COMM_INTERFACE_FREQ is the clock rate of the local interface
--                  to the asynch_sercomm_*_top modules. This value is dependent on
--                  the datarate and can only be changed in three discrete steps
--                  without changing the datarate. (See CLK_COMM_INTERFACE_DIV)
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library IEEE;
use     IEEE.STD_LOGIC_1164.all;
use     IEEE.NUMERIC_STD.ALL;

package asynch_sercomm_config_pack is

-----------------------------------------------------------------------------
-- Adjustable values:
-- CLK_LO_FREQ_HZ
--      Frequency of local oscillator in Hz
--
-- CLK_LO_PLLMULTIP
--      Multiplicator for PLL
--      PLL Frequency = CLK_LO_FREQ_HZ * CLK_LO_PLLMULTIP
--      PLL Frequency must be between 400MHz and 1000MHz
--
-- CLK_DOUBLE_DR_DIV
--      PLL output divder for double datarate clock
--      Datarate = (PLL Frequency / CLK_DOUBLE_DR_DIV) / 2
--
-- CLK_COMM_INTERFACE_DIV
--      Divder for slower communication clock domain.
--      Possible values between 1 and 4 (inclusive)
--      Frequency of local communication interface clock = (Datarate / 2) / CLK_COMM_INTERFACE_DIV
--
-- ASYNCH_SERCOMM_IOSTANDARD
--      IO standrad that is used by the LVDS transceivers
--      Possible values: "LVDS_25" (bank voltage 2.5V) or "LVDS_33" (bank voltage 3.3V)
--
-- FPGA_SPEEDGRADE
--      Speedgrade of used FPGA. One of "2", "3N" or "3".
--      It's important to stet this to the correct value. Otherwise there will be a much higher Rx error rate.
--
-- ASYNCH_SERCOMM_8b10b_USE_BRAM
--      1 = Use BRAM for 8b10b encoder/decoder
--      0 = Use LUT-Based approach for 8b10b encoder/decoder

constant CLK_LO_FREQ_HZ : natural := 20_000_000;        -- Frequency of local oscillator
constant CLK_LO_PLLMULTIP : natural := 32;              -- PLLFREQ = CLK_LO_FREQ_HZ * CLK_LO_PLLMULTIP; 400MHz < PLLFREQ < 1000MHz
constant CLK_DOUBLE_DR_DIV : natural := 1;              -- DOUBLE_DR_FREQ = PLLFREQ / CLK_DOUBLE_DR_DIV
constant CLK_COMM_INTERFACE_DIV : natural := 4;         -- COMM_INTERFACE_FREQ = HALF_DR_FREQ / CLK_COMM_INTERFACE_DIV = PLLFREQ / (CLK_DOUBLE_DR_DIV * 4 * CLK_COMM_INTERFACE_DIV)
constant ASYNCH_SERCOMM_IOSTANDARD : string := "LVDS_33"; -- IO standrad for LVDS transceivers.
constant ASYNCH_SERCOMM_8b10b_USE_BRAM : integer := 1;  -- 0=LUT-Based, 1=BRAM-Based 
constant FPGA_SPEEDGRADE : string := "3";               -- Speedgrade of used FPGA

-----------------------------------------------------------------------------
-- Do not mess with these
constant CLK_LO_PERIOD_NS : real := 1.0e9/real(CLK_LO_FREQ_HZ);
constant CLK_DOUBLE_DR_PLLDIV : natural := CLK_DOUBLE_DR_DIV;
constant CLK_HALF_DR_PLLDIV : natural := CLK_DOUBLE_DR_DIV*4;
constant CLK_COMM_INTERFACE_PLLDIV : natural := CLK_DOUBLE_DR_PLLDIV*4*CLK_COMM_INTERFACE_DIV;

constant CLK_PLLFREQ : natural := CLK_LO_FREQ_HZ * CLK_LO_PLLMULTIP;
constant CLK_COMM_INTERFACE_FREQ : natural := CLK_PLLFREQ / CLK_COMM_INTERFACE_PLLDIV;

constant ASNYCH_SERCOM_DATARATE : natural := CLK_PLLFREQ / CLK_DOUBLE_DR_PLLDIV / 2;

constant ASYNCH_SERCOMM_IOSTANDARD_RX : string := ASYNCH_SERCOMM_IOSTANDARD;
constant ASYNCH_SERCOMM_IOSTANDARD_TX : string := ASYNCH_SERCOMM_IOSTANDARD;


constant ASYNCH_SERCOMM_K_IDLE : std_logic_vector(7 downto 0) := b"1011_1100"; --Idle Word
constant ASYNCH_SERCOMM_K_28_5 : std_logic_vector(7 downto 0) := b"1011_1100";
constant ASYNCH_SERCOMM_K_SOF  : std_logic_vector(7 downto 0) := b"0011_1100"; --Start of Frame Word
constant ASYNCH_SERCOMM_K_28_1 : std_logic_vector(7 downto 0) := b"0011_1100";

end asynch_sercomm_config_pack;

package body asynch_sercomm_config_pack is

end asynch_sercomm_config_pack;
