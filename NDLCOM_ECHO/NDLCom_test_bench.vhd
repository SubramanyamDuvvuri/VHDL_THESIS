--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:54:56 03/12/2015
-- Design Name:   
-- Module Name:   /home/sduvvuri/thesis.git/NDLCOM_ECHO/NDLCom_test_bench.vhd
-- Project Name:  NDLCOM_ECHO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: NDLComBasicExample
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
 
ENTITY NDLCom_test_bench IS
END NDLCom_test_bench;
 
ARCHITECTURE behavior OF NDLCom_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT NDLComBasicExample
    PORT(
         CLK_IN : IN  std_logic;
         nRST_IN : IN  std_logic;
         LED : OUT  std_logic_vector(1 downto 0);
         RX1 : IN  std_logic;
         TX1 : OUT  std_logic;
         RX2 : IN  std_logic;
         TX2 : OUT  std_logic;
         PROM_nCS : OUT  std_logic;
         PROM_CLK : OUT  std_logic;
         PROM_nWP : OUT  std_logic;
         PROM_nHOLD : OUT  std_logic;
         PROM_MISO : IN  std_logic;
         PROM_MOSI : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_IN : std_logic := '0';
   signal nRST_IN : std_logic := '0';
   signal RX1 : std_logic := '0';
   signal RX2 : std_logic := '0';
   signal PROM_MISO : std_logic := '0';

 	--Outputs
   signal LED : std_logic_vector(1 downto 0);
   signal TX1 : std_logic;
   signal TX2 : std_logic;
   signal PROM_nCS : std_logic;
   signal PROM_CLK : std_logic;
   signal PROM_nWP : std_logic;
   signal PROM_nHOLD : std_logic;
   signal PROM_MOSI : std_logic;

   -- Clock period definitions
   constant CLK_IN_period : time := 10 ns;
   constant PROM_CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: NDLComBasicExample PORT MAP (
          CLK_IN => CLK_IN,
          nRST_IN => nRST_IN,
          LED => LED,
          RX1 => RX1,
          TX1 => TX1,
          RX2 => RX2,
          TX2 => TX2,
          PROM_nCS => PROM_nCS,
          PROM_CLK => PROM_CLK,
          PROM_nWP => PROM_nWP,
          PROM_nHOLD => PROM_nHOLD,
          PROM_MISO => PROM_MISO,
          PROM_MOSI => PROM_MOSI
        );

   -- Clock process definitions
   CLK_IN_process :process
   begin
		CLK_IN <= '0';
		wait for CLK_IN_period/2;
		CLK_IN <= '1';
		wait for CLK_IN_period/2;
   end process;
 
   PROM_CLK_process :process
   begin
		PROM_CLK <= '0';
		wait for PROM_CLK_period/2;
		PROM_CLK <= '1';
		wait for PROM_CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_IN_period*10;
	
      -- insert stimulus here 

      wait;
   end process;

END;
