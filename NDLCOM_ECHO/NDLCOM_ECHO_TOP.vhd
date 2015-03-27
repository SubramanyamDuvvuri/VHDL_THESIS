----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:06:03 03/12/2015 
-- Design Name: 
-- Module Name:    NDLCOM_ECHO_TOP - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if ,instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NDLCOM_ECHO_TOP is

		PORT ( CLK   : IN STD_LOGIC;
				 RESET : IN STD_LOGIC;
				 RX 	 : IN STD_LOGIC;
				 TX    : OUT STD_LOGIC;
				 LED 	  : out std_logic
				);
end NDLCOM_ECHO_TOP;

		

architecture Behavioral of NDLCOM_ECHO_TOP is

		component NDLComBasicExample is
		port( CLK_IN      : in  std_logic;
          nRST_IN     : in  std_logic;
          LED         : out std_logic_vector(1 downto 0);
          
          -- pins for communication
          RX1         : in  std_logic;
          TX1         : out std_logic;
          RX2         : in  std_logic;
          TX2         : out std_logic;

          -- pins for SPIPROM
          PROM_nCS    : out std_logic;
          PROM_CLK    : out std_logic;
          PROM_nWP    : out std_logic;
          PROM_nHOLD  : out std_logic;
          PROM_MISO   : in  std_logic;
          PROM_MOSI   : out std_logic );
		end component NDLComBasicExample; 
		
begin
			NDLCOM_BASIC: NDLComBasicExample 
			port map (
							CLK_IN => CLK,
							nRST_IN => RESET,
							RX1 => RX,
							TX2 => TX,
							RX2 => '0',
							PROM_MISO => '0'
						);	
--						
--			NDLCOM_CONTROLLER_portmap : NDLCOM_CONTROLLER
--			port map (
--							clk => CLK,
--							rst => RESET,
--							rx_in => RX,
--							check => LED
--							);

				LED <= '1' ; 
				
end Behavioral;

