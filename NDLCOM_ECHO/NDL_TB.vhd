--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:47:53 03/13/2015
-- Design Name:   
-- Module Name:   /home/sduvvuri/thesis.git/NDLCOM_ECHO/NDL_TB.vhd
-- Project Name:  NDLCOM_ECHO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: NDLCOM_ECHO_TOP
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY NDL_TB IS
END NDL_TB;
 
ARCHITECTURE behavior OF NDL_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT NDLCOM_ECHO_TOP
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         RX : IN  std_logic;
         TX : OUT  std_logic;
         pin_check : OUT  std_logic;
         LED : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal RX : std_logic := '0';

 	--Outputs
   signal TX : std_logic;
   signal pin_check : std_logic;
   signal LED : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: NDLCOM_ECHO_TOP PORT MAP (
          CLK => CLK,
          RESET => RESET,
          RX => RX,
          TX => TX,
          pin_check => pin_check,
          LED => LED
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
