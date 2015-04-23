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
						 BAUD_RATE     :  integer :=  926100);	
	port ( 	CLK    : in std_logic;
				RST : in std_logic;
				RX : in std_logic_vector(0 downto 0) ;
				TX : out std_logic_vector( 0 downto 0);
				en : in std_logic;
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
	
	type array_data is array ( 0 to 6)  of std_logic_vector (7 downto 0);
   signal arr : array_data := (others => ( others => '0'));	
	
	type send_packets is (idle,write_data, transmit_data) ;
	signal send_packet : send_packets;	
	
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
				LED <= '1' ;
			
			arr (0)<= x"88";
			arr (1)<= x"cc";
			arr (2)<= x"dd";
			arr (3) <= x"ee";
			arr (5) <= x"01";
			
			process (CLK)
			variable i : integer := 0 ;
			variable idleflag : integer := 0;	
			begin 
			  if (clk'event and clk ='1') then
					if RST = '1' then
						 send_addr <= (others => '1');
						 send_packet<= write_data;	
					else 
						-- defaults
						 startsending <= '0';		
						 send_wea <= "0";
						
						 if en = '1' then 					-- interface to start sending
							 if idleflag = 1 then 
								 idleflag := 0 ;
							 else	
								 case send_packet is 
										when idle =>
														if readyToSend = '1' then
															send_packet <= write_data;
														else
															send_packet <= idle ; 	
														end if;		
										when	write_data =>								
														if (i < 6 ) then
															 send_data <= arr(i);
															 send_addr <= send_addr + 1;
															 send_wea  <= "1";
															 i := i + 1;	
															 send_packet <= write_data;
														else
															 send_packet <= transmit_data;			
														end if;
										when	transmit_data	=>
														i := 0;
														startSending  <= '1';
														sendFrameCounter <= sendFrameCounter +1;
														send_addr <= (others => '1');
														send_packet <= idle ;							
								 end case; 
							 end if;	
						 end if;	
					end if;		
				end if;
			end process;
end Behavioral;

