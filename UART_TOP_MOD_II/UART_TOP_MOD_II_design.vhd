----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:56:42 03/06/2015 
-- Design Name: 
-- Module Name:    UART_TOP_MOD_II_design - Behavioral 
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

entity UART_TOP_MOD_II_design is
	port ( CLOCK : in std_logic;
			 RESET : in std_logic;
			 TX	 : out std_logic;
			 RX	 : IN std_logic 
			 
		  );
		
end UART_TOP_MOD_II_design;

architecture Behavioral of UART_TOP_MOD_II_design is

		signal txData_i_sig,rxData_o_sig : std_logic_vector ( 7 downto 0) ;
		signal rxNewData_o_sig,rxErr_o_sig,txReady_o_sig,txStart_i_sig : std_logic;
		
		component UART_Controller is
			
		port( clk	 						: in std_logic;
				rst 						: in std_logic;
				byte_in2uart_tx			: out std_logic_vector( 7 downto 0);
				start_tx_flag				: out std_logic;
				transmission_ready_flag : in std_logic;
				rx2tx_connection			: in std_logic_vector (7 downto 0);
				reveivedNewData_flag		: in std_logic 
			 );
		end component UART_Controller;
		
		
	  component uart_mod is
	  generic (CLK_FREQ : integer := 18500000;
				  BAUDRATE : integer := 115200);  
	  port (
		 -- general ports
		 clk_i       : in  std_logic;
		 rst_i       : in  std_logic;
	--	 tx ports
		 tx_o        : out std_logic;        -- transmit data line        
		 txData_i    : in  std_logic_vector(7 downto 0);  -- data to transmit
		 txReady_o   : out std_logic;        -- transmit ready flag
		 txStart_i   : in  std_logic;        -- start transmission signal
	--	 rx ports
		 rx_i        : in  std_logic;        -- receive data line
		 rxData_o    : out std_logic_vector(7 downto 0);  -- received data
		 rxNewData_o : out std_logic;        -- new data received flag
		 rxDataAck_i : in  std_logic;        -- acknowledge of received data signal
		 rxErr_o     : out std_logic);       -- receive error
	 end component uart_mod;



begin

		UART_MOD_portmap:uart_mod generic map ( CLK_FREQ => 12000000 ) 
		port map (
					  clk_i 			=> CLOCK,				-- general port
					  rst_i 			=> RESET,				-- general port 
					 -----------------------------------
					  tx_o  			=> TX,					-- output of the uart_mod connected to the top module output
					 txData_i		=> txData_i_sig,		-- taking input form the output of the uart controller through a signal 
					  txReady_o		=> txReady_o_sig,		-- sending the output of the tx ready status to the uart controller 
					  txStart_i 	=> txStart_i_sig,		--	receiving input from the uart controller
					  -------------------------------
					  rx_i			=> RX,					-- receiver connected as the input to the top module 
					  rxData_o 		=> rxData_o_sig,		-- sending input to the uart controller , which can be transmitter to the output
					  rxNewData_o	=> rxNewData_o_sig,	-- sending the new data receive satus to the uart controller
					  rxdataack_i  => '1'
					 );
					 
		UART_CONTROLLER_portmap : UART_Controller 
		port map (	
						clk							=>	CLOCK , 			
						rst							=>	RESET ,
						-------------------------------------
						byte_in2uart_tx			=>	txData_i_sig,  		-- output sent as an input to the uart mod
						start_tx_flag				=> txStart_i_sig,			-- sending the status of start flag to  the uart mod
						transmission_ready_flag => txReady_o_sig,			-- receiving he status of ready flag from the uert mod
						rx2tx_connection			=>	rxData_o_sig,			-- receiving input fornthe uart mod, which can be sent back to the uart mod 
						reveivedNewData_flag		=> rxNewData_o_sig		-- receiving the status of the received new data flag
					);	
					 

--				UART_TOP_MOD_portmap : uart_mod generic map ( CLK_FREQ => 12000000)
--				port map (
--								clk_i 	=> 	CLOCK ,
--								rst_i 		=> 	RESET , 
--								
--								tx_o 		=> 	TX,
--								txData_i => txData_i_sig,
--								txReady_o=> txReady_o_sig,
--								txStart_i=> txStart_i_sig,
--								
--								rx_i		=> RX,
--								rxData_o => rxData_o_sig,
--								rxNewData_o => rxNewData_o_sig
--								
--							);
--							
--							
--				UART_CONTROLLER_portmap : UART_Controller
--					port map (
--									clk						=> CLOCK,
--									rst						=> RESET,
--									byte_in2uart_tx		=> txData_i_sig,
--									start_tx_flag			=> txStart_i_sig,
--									transmission_ready_flag=> txReady_o_sig,
--									rx2tx_connection		=> rxData_o_sig,
--									reveivedNewData_flag => rxNewData_o_sig
--								);
					 
end Behavioral;

