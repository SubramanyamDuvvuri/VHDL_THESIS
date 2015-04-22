----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:34:09 03/31/2015 
-- Design Name: 
-- Module Name:    New1_Wrapper - Behavioral 
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

entity New1_Wrapper is
		generic ( CLK_FREQ      : integer := 16000000; 
					BAUD_RATE     : integer :=  115200);	
		port ( 
				CLK : in std_logic ; 
				RESET: in std_logic ;
				--NODEID : in std_logic_vector := "00001010" ;
				--starttx : in std_logic;
				--en : in std_logic;
				RX : in std_logic ;
				TX : out std_logic;
				LED : out std_logic		
				);
end New1_Wrapper;

architecture Behavioral of New1_Wrapper is
 signal readyToSend :     std_logic ;
 signal startSending:     std_logic := '0';
 signal sendReceiver:     std_logic_vector(7 downto 0) :="00000001";
 signal sendFrameCounter: std_logic_vector(7 downto 0) :="00000000";
 signal sendLength :      std_logic_vector(7 downto 0) ;
 signal send_wea  :       std_logic_vector(0 downto 0) := "1";
 signal send_addr :       std_logic_vector(7 downto 0) ;
 signal send_data:       std_logic_vector (7 downto 0); 
 signal newData  :        std_logic  ;
 signal dataAck  :        std_logic  ;
 signal recvSender :      std_logic_vector(7 downto 0) ;
 signal recvFrameCounter: std_logic_vector(7 downto 0) ;
 signal recvLength:       std_logic_vector(7 downto 0) ;
 signal recv_addr:        std_logic_vector(7 downto 0);
 signal recv_data:        std_logic_vector(7 downto 0) ;
 signal recv_error:       std_logic := '0';

signal receive_nd_send_data : std_logic_vector (7 downto 0);
signal receive_nd_send_length : std_logic_vector (7 downto 0);
signal receive_nd_send_addr : std_logic_vector (7 downto 0);
signal receive_nd_send_recvSender : std_logic_vector ( 7 downto 0) ;
signal receive_nd_send_recvFrameCounter : std_logic_vector ( 7 downto 0 ) ;
 
type array_data is array ( 0 to 150)  of std_logic_vector (7 downto 0);
signal arr : array_data := (others => ( others => '0'));	

type echo_TXRX is ( idle , receive,write_data, echo );
signal echo_data :echo_TXRX; 
	
begin

NDLCom_example : entity work.NDLCom(Behavioral)
        generic map ( CLK_FREQ  => CLK_FREQ,
                      BAUD_rate => BAUD_RATE)
        port map ( CLK => CLK,
                   RST => RESET,
                   NODE_ID => x"0a",
                   RX  => RX,
                   TX  => TX,
                   
                   readyToSend      => readyToSend,
                   startSending     => startSending,
                   sendReceiver     => "00000001",
                   sendFrameCounter => sendFrameCounter,
                   sendLength       => sendLength,
                   send_wea         => send_wea,
                   send_addr        => send_addr,
                   send_data        => send_data,
                   newData          => newData,
                   dataAck          => dataAck,
                   recvSender       => recvSender,
                   recvFrameCounter => recvFrameCounter,
                   recvLength       => recvLength,
                   recv_addr        => recv_addr ,
                   recv_data        => recv_data,
                   recv_error       => recv_error 
						);
--						
--			START_CONTROL:process (CLK)
--			begin	
--			if ( CLK'event and CLK = '1') then  		
--				if starttx = '1' then
--					startSending <= '1';
--				else
--					startSending <= '0';
--				end if;
--			end if;
--			end process START_CONTROL;
	--LED <= '1';
--
--
--	arr (0)<= x"88";
--	arr (1)<= x"cc";
--	arr (2)<= x"dd";
--	arr (3) <= x"ee";
--	arr (4) <= x"00";
	

--
--Receiving: process (clk)
--variable flag : integer := 0;  
--begin
--		if (clk'event and clk = '1' ) then
--				receive_nd_send_data   <= recv_data;
--				receive_nd_send_length <= recvLength;
--				receive_nd_send_recvFrameCounter<=recvFrameCounter;
--				sendLength <= receive_nd_send_length ;
--				send_data  <= receive_nd_send_data ;
--				sendFrameCounter<= receive_nd_send_recvFrameCounter;
--		end if;
--end process Receiving;		
		Sending_Receiving: process (clk)
		variable i : integer := 0;
		variable j : integer := 0 ;
		begin 
			if(clk'event and clk = '1' ) then
				if RESET = '1' then 
					startSending <= '0';
					echo_data <= idle;
					i := '0';
					j := '0';
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
																  receive_nd_send_length <= recvLength;
																  sendLength <= receive_nd_send_length ;
															else 
																  echo_data <= idle;
															end if;	  
									when receive =>
															if ( i< (to_integer(unsigned (receive_nd_send_length)))) then
																	arr (i)<= recv_data;
																	recv_addr <= recv_addr +1 ;
																	i := i +1;
																	echo_data<= receive;
															else
																	echo_data <= write_data;
															end if;		
									when write_data =>
															if (j < ( to_integer ( unsigned (receive_nd_send_length)))) then
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
			     if reset='1' then
				     LED <= '0';
				  else
				     if newData='1' then
					      LED <= '1';
						else
							LED<= '0';
					  end if;
				  end if;
		    end if;
	   end process;
end Behavioral;
