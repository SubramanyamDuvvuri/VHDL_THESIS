----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:13:38 03/13/2015 
-- Design Name: 
-- Module Name:    NDLCOM_CONTROLLER - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NDLCOM_CONTROLLER is
	
		port ( clk : in std_logic;
				 rst : in std_logic;
				 rx_in: in std_logic;
				 check : out std_logic	
				);
end NDLCOM_CONTROLLER;

architecture Behavioral of NDLCOM_CONTROLLER is

begin
					process ( clk )
					begin
					if ( clk'event and clk = '1') then 	
							if ( rx_in = '1') then
								  check <= '1';
							end if;		
					end if;			
					end process;		

end Behavioral;

