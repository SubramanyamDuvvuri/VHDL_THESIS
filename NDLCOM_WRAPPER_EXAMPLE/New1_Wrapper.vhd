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
					BAUD_RATE     : integer := 115200);	
		port ( 
				CLK : in std_logic ; 
				RESET: in std_logic ;
				--NODEID : in std_logic_vector := "00001010" ;
				starttx : in std_logic;
 				en : in std_logic;
				RX : in std_logic ;
				TX : out std_logic;
				LED : out std_logic		
				);
end New1_Wrapper;

architecture Behavioral of New1_Wrapper is

 signal readyToSend :     std_logic := '1';
 signal startSending:     std_logic := '0';
 signal sendReceiver:     std_logic_vector(7 downto 0) :="00000001";
 signal sendFrameCounter: std_logic_vector(7 downto 0) := "00000000";
 signal sendLength :      std_logic_vector(7 downto 0) :=x"02" ;
 signal send_wea  :       std_logic_vector(0 downto 0) := "1";
 signal send_addr :       std_logic_vector(7 downto 0) := "00000000";
 signal  send_data:       std_logic_vector (7 downto 0); 
 signal newData  :        std_logic  := '0';
 signal dataAck  :        std_logic  := '1';
 signal recvSender :      std_logic_vector(7 downto 0) := "00000000";
 signal recvFrameCounter: std_logic_vector(7 downto 0) := "00000000";
 signal recvLength:       std_logic_vector(7 downto 0) := "00000000";
 signal recv_addr:        std_logic_vector(7 downto 0) := "00000000";
 signal recv_data:        std_logic_vector(7 downto 0) := "00000000";
 signal recv_error:       std_logic := '0'; 
 --############################################################
--			signal sendLength_counter : std_logic_vector (7 downto 0) := "00000001";
--			signal send_addr_counter : std_logic_vector (7 downto 0) := "00000000";
--			signal sendFrameCounter_counter : std_logic_vector (7 downto 0) := "00000001";
--			signal send_data_counter : std_logic_vector (7 downto 0) := x"aa";
--			signal counter : std_logic_vector ( 7 downto 0 ) := "00000000";



type send_frames is ( input,output );
	signal send_frame : send_frames;
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
                   recv_addr        => recv_addr,
                   recv_data        => recv_data,
                   recv_error       => recv_error 
						);

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
			LED <= '1';
			

--	process(clk)
--	variable length_counter : std_logic_vector( 7 downto 0):= "00000000";
--	variable length_counter2 : std_logic_vector( 7 downto 0)	:= "00000000";
--	begin 
--		if ( clk' event and clk = '1' ) then 
--			if en = '1' then
--		
--				case send_frame is
--						when input =>
--										if ( length_counter /= sendLength) then
--												length_counter :=length_counter + 1;
--												send_frame <= output;
--												
--										end if;
--										send_frame <= output;
--										--startSending <= '1' ;
--						when output => 
--												startSending <= '1';
--											if (length_counter2 /= length_counter) then
--												send_addr <= send_addr + '1';
--												send_data <= send_data + '1';
--												--sendFrameCounter <= sendFrameCounter + '1' ;
--												send_frame <=input;
--												startSending <= '0'
--											end if;
--											sendFrameCounter <= sendFrameCounter + '1';
--											--startSending <= '0' ;
--				end case;
--			else
--				startSending <= '0';
--			end if;	
--		end if;		
--	end process;

process(clk)
	variable length_counter : std_logic_vector( 7 downto 0):= "00000000";
	variable length_counter2 : std_logic_vector( 7 downto 0)	:= "00000000";
	begin 
		if ( clk' event and clk = '1' ) then 
			if en = '1' then
		
				case send_frame is
						when input =>
										if ( length_counter /= sendLength) then
												length_counter :=length_counter + 1;
												send_frame <= output;
												
										end if;
										send_frame <= output;
										startSending <= '1' ;
						when output => 
												startSending <= '1';
											if (length_counter2 /= length_counter) then
												send_addr <= send_addr + '1';
												send_data <= send_data + '1';
												sendFrameCounter <= sendFrameCounter + '1' ;
												send_frame <=input;
												startSending <= '0';
											end if;
											sendFrameCounter <= sendFrameCounter + '1';
											startSending <= '0' ;
				end case;
			else
				startSending <= '0';
			end if;	
		end if;		
	end process;

			
--			SEND_CONTROL:process(clk,sendLength,send_addr,send_data,sendFrameCounter )
----			variable sendLength_counter : std_logic_vector (7 downto 0) := "00000000";
----			variable send_addr_counter : std_logic_vector (7 downto 0) := "00000000";
----			variable sendFrameCounter_counter : std_logic_vector (7 downto 0) := "00000001";
----			variable send_data_counter : std_logic_vector (7 downto 0) := x"aa";
----			variable counter : std_logic_vector ( 7 downto 0 ) := "00000000";
--			begin
--				if (CLK'event and CLK = '1' ) then 
--					if (counter = "00001010") then
--						counter <= "00000000";	
--						sendLength_counter <= "00000001";
--						send_addr_counter <= "00000000";
--						send_data_counter <= x"aa";	
--					else	
--						sendFrameCounter<= sendFrameCounter_counter 
--						sendLength <= sendLength_counter;
--						send_addr	<= send_addr_counter;
--						send_data	<= send_data_counter;
--						sendFrameCounter<= sendFrameCounter_counter ;
--						--############################################
--						counter <= counter +"00000001";
--						sendLength_counter <= sendLength_counter +"00000001";
--						sendFrameCounter_counter <= sendFrameCounter_counter +'1';
--						send_addr_counter <= send_addr_counter +"00000001" ;
--						send_data_counter <= send_data_counter +"00000001" ;
--					end if;
--				end if;
--			end process SEND_CONTROL; 

-------------------------------------------------------
-- variable giving the input
-------------------------------------------------------

																											
--process
--   variable cntvar: std_logic_vector (7 downto 0):= "00000000" ;
--begin
--   cntvar := send_data;
--   for i in 0 to 10 loop
--       cntvar := cntvar + 1;
--   end loop;
--   send_data <= cntvar;
--end process;

-------------------------------------------------------------


	




















	
end Behavioral;

