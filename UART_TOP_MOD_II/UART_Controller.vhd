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
				byte_in2uart_tx			: out std_logic_vector( 7 downto 0);		-- input to be given to UART mod
				start_tx_flag				: out std_logic;									-- starts transmitting as soon as it goes high
				transmission_ready_flag : in std_logic;									-- flag is asserted when ready to transmit
				rx2tx_connection			: in std_logic_vector ( 7 downto 0);		-- giving the ouptput of the uart mod as an input.
				reveivedNewData_flag		: in std_logic 
			 );
				
				
				
	
end UART_Controller;

architecture Behavioral of UART_Controller is
signal byte_in2uart_tx_sig	: std_logic_vector (7 downto 0);
signal start_tx_flag_sig: std_logic;
---------------------------------------------------------------------
--Introducing new signals and states for controlled transfer of bytes
---------------------------------------------------------------------- 
type state_type is ( idle, waiting , forwarding) ;		-- state machine for byte tranfer
signal present_state, next_state : state_type;
	
begin
		
--		process ( clk,rst )
--		begin
--				if (clk'event and clk ='1') then
--						if (rst = '1' ) then 
--							start_tx_flag_sig <= '0' ;
--						else		
--							 start_tx_flag_sig <= '1';
--							 byte_in2uart_tx_sig 	<=	rx2tx_connection 	;
--						end if ;
--				end if;		
--							
--		end process;



		CLOCK_TICK:process (clk,rst)
		begin
		if( clk'event and clk = '1') then
			if ( rst = '1' ) then
				present_state <= idle;
			else
				present_state <= next_state;
			end if;
		end if;
		end process;	
		
		
		FSM:process(next_state, reveivedNewData_flag,rx2tx_connection, present_state)
		begin
				case present_state is
				
					when waiting 	=> if ( reveivedNewData_flag = '0')then 
														start_tx_flag_sig <= '0';
														next_state<= waiting;
															
											elsif( reveivedNewData_flag = '1') then 
																	
														next_state<= forwarding; 	
															
											end if;
					when forwarding => 						
															start_tx_flag_sig <= '1';
															byte_in2uart_tx_sig(7 downto 0 ) <= rx2tx_connection( 7 downto 0);
															
															if ( reveivedNewData_flag = '0') then 
													
																	next_state<= waiting;													
															else		
																	next_state<= forwarding; 	
															
															end if;			
			

					when idle => 
											
											next_state<= waiting;				
			
					end case;
		end process;			
		
byte_in2uart_tx	<= byte_in2uart_tx_sig;
start_tx_flag 		<= start_tx_flag_sig;					
				
		
end Behavioral;

