		----------------------------------------------------------------------------------
		-- Company: 
		-- Engineer: 
		-- 
		-- Create Date:    12:08:22 02/26/2015 
		-- Design Name: 
		-- Module Name:    UART_TOP - Behavioral 
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

		entity UART_TOP is 						--TOP MODULE ENTITY
		port (
				 CLOCK 	: in std_logic ;
				 RESET 	: in std_logic; 
				 TX_OUT 	: out std_logic; 
				 RX_in	: in std_logic
				
			  );
		end UART_TOP;

		
		architecture Behavioral of UART_TOP is
		---------------------------------------------
		--SIGNALS
		---------------------------------------------
		signal txStart_sig 	: std_logic;
		signal BITS_INPUT_sig: std_logic_vector (7 downto 0);
		signal rxData_sig 	: std_logic_vector (7 downto 0);

		------------------------------------------------------
		--COMPONENT DECLARATION
		------------------------------------------------------
		--FIRST COMPONENT
		------------------------------------------------------
		component UART_BYTE_SEND is												--component declaration for UART_BYTE_SEND
		generic ( MAX 		: 	integer := 8 ); 									--DEFINING MAX BITS
		port ( 
				 CLK 			: 	in std_logic;
				 RESET		: 	in std_logic;
				 START 		: 	out std_logic;
				 BITS_INPUT	: 	out std_logic_vector( 7 downto 0); 			-- OUTPUT FOR SENDING A BYTE
				 RX 			: 	in std_logic_vector ( 7 downto 0 ) 
			   
			  );
		end component UART_BYTE_SEND;

		------------------------------------------------------------
		--SECOND COMPONENT
		------------------------------------------------------------
	
		component uart_mod is														--COMPONENT DECLARATION FOR UART_MOD
		generic (	
						CLK_FREQ : integer := 18500000;
						BAUDRATE : integer := 115200
				  );  
		port (
		 -- general ports
		 clk_i       : in  std_logic;
		 rst_i       : in  std_logic;
		 -- tx ports
		 tx_o        : out std_logic;        -- transmit data line        
		 txData_i    : in  std_logic_vector(7 downto 0);  -- data to transmit
		 txReady_o   : out std_logic;        -- transmit ready flag
		 txStart_i   : in  std_logic;        -- start transmission signal
		 -- rx ports
		 rx_i        : in  std_logic;        -- receive data line
		 rxData_o    : out std_logic_vector(7 downto 0);  -- received data
		 rxNewData_o : out std_logic;        -- new data received flag
		 rxDataAck_i : in  std_logic;        -- acknowledge of received data signal
		 rxErr_o     : out std_logic);       -- receive error
		end component uart_mod;
		begin
		-----------------------------------------------------------------------
		--PORT MAPPING OF UART BYTE SEND
		-----------------------------------------------------------------------
		UART_BYTE_SEND_PORT_MAP: UART_BYTE_SEND 						
			 port map ( 
						  CLK			 => CLOCK, 									--THE PORT OF THE COMPONENT IS GIVEN IN LHS AND TO WHICH IT IS CONNECTED TO IN THE RIGHT
						  RESET		 => RESET, 
						  START 		 => txStart_sig, 							--PORTS OF ONE DESIGN ARE CONNECTED TO PORTS OF OTHER DESIGN THROUGH SIGNALS
						  BITS_INPUT => BITS_INPUT_sig, 
						  RX         => rxData_sig 
						 );
						 
		-----------------------------------------------------------------------
		--PORT MAPPING OF UART MOD
		-----------------------------------------------------------------------	
						
						
		UART_MOD_PORT_MAP: uart_mod generic map ( CLK_FREQ => 16000000)  -- GENERIC MAP OF THE CLOCK AND OTHER GENEIC TERMS
		port map (
						clk_i 	=> CLOCK,							
						rst_i 	=> RESET,
						tx_o 		=> TX_OUT,												
						txData_i => BITS_INPUT_sig,									--PORTS OF ONE DESIGN ARE CONNECTED TO PORTS OF OTHER DESIGN THROUGH SIGNALS
						txStart_i=> txStart_sig,
						rxData_o => rxData_sig,
						rx_i 		=> RX_IN
					);  

					
	 end Behavioral;

