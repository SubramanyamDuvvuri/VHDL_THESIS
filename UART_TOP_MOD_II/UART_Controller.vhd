----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:57:56 03/06/2015 
-- Design Name: 
-- Module Name:    UART_Controller - Behavioral 
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

entity UART_Controller is
			
		port( clk 						   : in std_logic;
				rst 						   : in std_logic;
				byte_in2uart_tx			: out std_logic_vector( 7 downto 0);
				start_tx_flag				: out std_logic;
				transmission_ready_flag : in std_logic;
				rx2tx_connection			: in std_logic_vector ( 7 downto 0);
				reveivedNewData_flag		: in std_logic 
			 );
				
				
				
	
end UART_Controller;

architecture Behavioral of UART_Controller is
signal byte_in2uart_tx_sig	: std_logic_vector (7 downto 0):= "00000000";
signal start_tx_flag_sig: std_logic;	
begin
		
		process ( clk,rst )
		begin
				if (clk'event and clk ='1') then
						if (rst = '1' ) then 
							start_tx_flag_sig <= '0' ;
						else		
							 start_tx_flag_sig <= '1';
							 byte_in2uart_tx_sig 	<=	rx2tx_connection 	;
						end if ;
				end if;		
							
		end process;
		
byte_in2uart_tx	<= byte_in2uart_tx_sig;
start_tx_flag 		<= start_tx_flag_sig;					
				
		
end Behavioral;

