----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:44:53 04/23/2015 
-- Design Name: 
-- Module Name:    New_NDLCOM_ROUTING_Top - Behavioral 
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
Use IEEE.numeric_std .ALL;
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity New_NDLCOM_ROUTING_Top is
			generic ( CLK_FREQ      : integer := 16000000; 
						 BAUD_RATE     :  integer := 115200);	
	port ( 	CLK    : in std_logic;
				RST : in std_logic;
				RX : in std_logic_vector(0 downto 0) ;
				TX : out std_logic_vector( 0 downto 0);
				--en : in std_logic;
				LED : out std_logic
			);		
end New_NDLCOM_ROUTING_Top;

architecture Behavioral of New_NDLCOM_ROUTING_Top is
	
   signal NODE_ID : std_logic_vector(7 downto 0) := (others => '0');
   signal hs_rx_p : std_logic_vector(1-1 to 0) := (others => '0');
   signal hs_rx_n : std_logic_vector(1-1 to 0) := (others => '0');
   signal ls_rx : std_logic_vector(0 downto 0) := (others => '0');
   signal hs_txData_trigger : std_logic_vector(1 downto 0) := (others => '0');
   signal hs_rxData : std_logic_vector(0 to 1) := (others => '0');
   signal hs_rxData_Kflag : std_logic_vector(1 downto 0) := (others => '0');
   signal hs_rxData_CodeErr : std_logic_vector(1 downto 0) := (others => '0');
   signal hs_rxData_DispErr : std_logic_vector(1 downto 0) := (others => '0');
   signal hs_rxData_trigger : std_logic_vector(1 downto 0) := (others => '0');
   signal ls_txReady : std_logic := '0';
   signal ls_rxData : std_logic_vector(7 downto 0) := (others => '0');
   signal ls_newData : std_logic := '0';
   signal ls_rxErr : std_logic := '0';
   signal startSending : std_logic := '0';
   signal sendReceiver : std_logic_vector(7 downto 0) := (others => '0');
   signal sendFrameCounter : std_logic_vector(7 downto 0) := (others => '0');
   signal sendLength : std_logic_vector(7 downto 0) := (others => '0');
   signal send_wea : std_logic_vector(0 downto 0) := (others => '0');
   signal send_addr : std_logic_vector(7 downto 0) := (others => '0');
   signal send_data : std_logic_vector(7 downto 0) := (others => '0');
   signal dataAck : std_logic := '0';
   signal recv_addr : std_logic_vector(7 downto 0) := (others => '0');
   signal clear_last_error : std_logic := '0';

 	--Outputs
   signal hs_tx_p : std_logic_vector(1-1 to 0);
   signal hs_tx_n : std_logic_vector(1-1 to 0);
   signal ls_tx : std_logic_vector(0 downto 0);
  -- signal hs_txData : std_logic_vector(0 to 1);
   signal hs_txData_Kflag : std_logic_vector(1 downto 0);
   signal ls_txData : std_logic_vector(7 downto 0);
   signal ls_startTx : std_logic;
   signal ls_dataAck : std_logic;
   signal readyToSend : std_logic;
   signal newData : std_logic;
   signal recvSender : std_logic_vector(7 downto 0);
   signal recvFrameCounter : std_logic_vector(7 downto 0);
   signal recvLength : std_logic_vector(7 downto 0);
   signal recv_data : std_logic_vector(7 downto 0);
   signal error : std_logic;
   signal last_error : std_logic_vector(15 downto 0);
   signal error_debug1 : std_logic_vector(15 downto 0);
   signal error_debug2 : std_logic_vector(15 downto 0);
	
	type array_data is array ( 0 to 250)  of std_logic_vector (7 downto 0);
   signal arr : array_data := (others => ( others => '0'));	
	
	type send_packets is (idle,write_data, transmit_data) ;
	signal send_packet : send_packets;	
	
	type receive_packets is ( idle, receive_data , write_data ) ;
	signal receive_packet : receive_packets; 
	
	
	type echo_datas is ( idle , receive , write_data , echo );
	signal echo_data : echo_datas;
	------------------------------------------------------------------
	signal receive_send_recvSender : std_logic_vector (7 downto 0);
	signal receive_send_recvLength : std_logic_vector (7 downto 0) ;	
	signal receive_send_recv_data  : std_logic_vector (7 downto 0) ; 
	
	
	
	
	begin
	routing_test:entity work.NDLCOM_top(Behavioral)
	generic map ( CLK_FREQ  => CLK_FREQ,
                 LS_BAUD_RATE => BAUD_RATE)
	
	port map	 (CLK => CLK,
          RST => RST,
          NODE_ID => X"0a",
          hs_rx_p => hs_rx_p,
          hs_rx_n => hs_rx_n,
          hs_tx_p => hs_tx_p,
          hs_tx_n => hs_tx_n,
          ls_rx => RX,
          ls_tx => TX,
         -- hs_txData => '0',
          hs_txData_Kflag => hs_txData_Kflag,
          hs_txData_trigger => hs_txData_trigger,
         -- hs_rxData => '0',
          hs_rxData_Kflag => hs_rxData_Kflag,
          hs_rxData_CodeErr => hs_rxData_CodeErr,
          hs_rxData_DispErr => hs_rxData_DispErr,
          hs_rxData_trigger => hs_rxData_trigger,
          ls_txData => ls_txData,
          ls_txReady => ls_txReady,
          ls_startTx => ls_startTx,
          ls_rxData => ls_rxData,
          ls_newData => ls_newData,
          ls_dataAck => ls_dataAck,
          ls_rxErr => ls_rxErr,
          readyToSend => readyToSend,
          startSending => startSending,
          sendReceiver => "00000001",
          sendFrameCounter => sendFrameCounter,
          sendLength => x"08",
          send_wea => send_wea,
          send_addr => send_addr,
          send_data => send_data,
          newData => newData,
          dataAck => dataAck,
          recvSender => recvSender,
          recvFrameCounter => recvFrameCounter,
          recvLength => recvLength,
          recv_addr => recv_addr,
          recv_data => recv_data,
          error => error,
          last_error => last_error,
          clear_last_error => clear_last_error,
          error_debug1 => error_debug1,
          error_debug2 => error_debug2
			 );
			 
			 
			 ---LED CHECK----
			  --LED <= '1' ;
			-----------------
		receive_send_recvLength <= recvLength;
		sendLength <= receive_send_recvLength ;
		Sending_Receiving: process (clk)
		variable i : integer := 0;
		variable j : integer := 0 ;
		begin 
			if(clk'event and clk = '1' ) then
				if RST = '1' then 
					startSending <= '0';
					echo_data <= idle;
					i := 0;
					j := 0;
					send_addr <= (others => '0');
					recv_addr <= (others => '0');
				else
						--defaults
					startSending <= '0';
					send_wea <= "0";
					dataack <= '0';
						case echo_data is
									when idle 	 =>   
															if readytosend = '1' then
																  echo_data <= receive;
																  
															else 
																  echo_data <= idle;
															end if;	  
									when receive =>
															if ( i< (to_integer(unsigned (receive_send_recvLength)))) then
																	arr (i)<= recv_data;
																	recv_addr <= recv_addr +1 ;
																	i := i +1;
																	echo_data<= receive;
															else
																	echo_data <= write_data;
															end if;		
									when write_data =>
															if (j < ( to_integer ( unsigned (receive_send_recvLength)))) then
																	send_data <= arr (j) ;
																	send_addr <= send_addr + 1;
																	send_wea  <= "1";
																	j := j + 1 ;
																	echo_data <= write_data;
															elsif (newData = '1')  then
																	dataack <= '1';
																	echo_data <= echo; 
															end if;	
									when echo    => 		
																	i := 0;
																	j := 0 ;
																	startSending <= '1' ;
																	sendFrameCounter <=sendFramecounter+1;
																	send_addr <= (others => '0');
																	recv_addr <= (others => '0');
																	echo_data <= idle ; 
															 
						end case;							
				end if;
			end if;		
		end process;
		
		process (clk)
		
		begin
		    if clk'event and clk='1' then
			     if rst='1' then
				     LED <= '0';
				  else
				     if newData='1' then
					      LED <= '1';
					  end if;
				  end if;
		    end if;
	   end process;

end Behavioral;

