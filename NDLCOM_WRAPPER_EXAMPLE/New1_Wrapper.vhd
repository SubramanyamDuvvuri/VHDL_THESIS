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
				--starttx : in std_logic;
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
 signal sendFrameCounter: std_logic_vector(7 downto 0) :="00000001";
 signal sendLength :      std_logic_vector(7 downto 0) := x"03" ;
 signal send_wea  :       std_logic_vector(0 downto 0) := "1";
 signal send_addr :       std_logic_vector(7 downto 0) :="00000000";
 signal  send_data:       std_logic_vector (7 downto 0); 
 signal newData  :        std_logic  := '0';
 signal dataAck  :        std_logic  := '1';
 signal recvSender :      std_logic_vector(7 downto 0) := "00000000";
 signal recvFrameCounter: std_logic_vector(7 downto 0) := "00000000";
 signal recvLength:       std_logic_vector(7 downto 0) := "00000000";
 signal recv_addr:        std_logic_vector(7 downto 0) := "00000000";
 signal recv_data:        std_logic_vector(7 downto 0) ;
 signal recv_error:       std_logic := '0'; 
 
 
 
-- signal frameCounter_addr_in  : std_logic_vector(7 downto 0);
-- signal frameCounter_data_in  : std_logic_vector(7 downto 0);
-- signal frameCounter_wea      : std_logic_vector(0 downto 0);
-- signal frameCounter_addr_out : std_logic_vector(7 downto 0);
-- signal frameCounter_data_out : std_logic_vector(7 downto 0);
 --############################################################
--			signal sendLength_counter : std_logic_vector (7 downto 0) := "00000001";
--			signal send_addr_counter : std_logic_vector (7 downto 0) := "00000000";
--			signal sendFrameCounter_counter : std_logic_vector (7 downto 0) := "00000001";
--			signal send_data_counter : std_logic_vector (7 downto 0) := x"aa";
--			signal counter : std_logic_vector ( 7 downto 0 ) := "00000000";



--type send_frames is ( input,output );
--	signal send_frame : send_frames;
----	
constant TIMEOUT_COUNTER_MAX : integer := CLK_FREQ/10;
    signal startTimeoutCounter   : std_logic;
    signal timeout               : std_logic;



type array_data is array ( 0 to 6)  of std_logic_vector (7 downto 0);
signal arr : array_data := (others => ( others => '0'));	
	
--type send_packets is ( write_data, wait_time , transmit_data) ;
----signal send_packet : send_packets;	

type packet_tx is ( idle_state , sendsend_data , add_inc ,write_data); 
signal packet: packet_tx;
	
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
						
----store_data_addr : entity work.bram_dp_simple
----        generic map (ADDRWIDTH => MEM_ADDR_WIDTH,
----                     DATAWIDTH => 8)
----        port map (clk   => CLK,
----                  we    => store_mem_wea(0),
----                  waddr => store_mem_addr_in,
----                  wdata => store_mem_data_in,
----                  raddr => store_mem_addr_out,
----                  rdata => store_mem_data_out
----						);
--				
--						
						
						
--						
--			frameCounter_buffer : entity work.bram_dp_simple
--        generic map ( ADDRWIDTH => 8,
--                      DATAWIDTH => 8 )
--        port map ( clk   => CLK,
--                   we    => frameCounter_wea(0),
--                   waddr => frameCounter_addr_in,
--                   wdata => frameCounter_data_in,
--                   raddr => frameCounter_addr_out,
--                   rdata => frameCounter_data_out);

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
--			

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
--####################################################################
--					USING FSM
--####################################################################
--process(clk)
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
--										end if;
--										send_frame <= output;
--										startSending <= '1' ;
--						when output => 
--												startSending <= '1';
--											if (length_counter2 /= length_counter) then
--												send_addr <= send_addr + '1';
--												send_data <= send_data + '1';
--												sendFrameCounter <= sendFrameCounter + '1' ;
--												send_frame <=input;
--												startSending <= '0';
--											end if;
--											sendFrameCounter <= sendFrameCounter + '1';
--											startSending <= '0' ;
--				end case;
--			else
--				startSending <= '0';
--			end if;	
--		end if;		
--	end process;
----------------------------------------------------------------------------------		 
			
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
-- Using array without for loop or FSM
-------------------------------------------------------------
	arr (0)<= x"88";
	arr (1)<= x"cc";
	arr (2)<= x"dd";
	arr (3) <= x"ee";
	arr (4) <= x"00";
--		process( clk ) 
--		variable i : integer:= 0;
--		begin 
--		if clk'event  and clk = '1' then 
----			if( i /= (to_integer (unsigned (sendLength )))-1) then
--			if( i /= 3) then
--				send_data <= arr(i);
--				send_addr <= send_addr +1 ;
--				i := i+1;
--			end if;	
--		end if;
--		end process;
--------------------------------------------------------------------
--Using array with FSM		
---------------------------------------------------------------------

--		process (CLK)
--		variable i : integer := 0 ; 		
--		begin 
--			if ( clk'event and clk ='1') then
--				if en = '1' then	
--					case send_packet is 
--							
--						when	write_data =>
--												 startSending  <= '0';
--													
--												if( i < (to_integer (unsigned (sendLength )))) then
--															send_data <= arr(i);
--															i := i + 1;
--															send_packet <= wait_time;
--												else
--															sendFrameCounter <= sendFrameCounter +1;
--															send_packet <= transmit_data;
--															
--															
--												end if;
--						when	wait_time => 
--															send_addr  <= send_addr + 1;
--															send_packet <= write_data ;
--															
--						when	transmit_data	=>
--														   i := 0;
--															startSending  <= '1';
--															 
--															send_addr <= "00000000";
--														   send_packet <= write_data;
--															
--														   
--					end case; 
--				end if;		
--			end if;
--		end process;

--------------  process (CLK)
--------------		variable i : integer := 0 ;
--------------		variable idleflag : integer := 0;	
--------------		begin 
--------------			if ( clk'event and clk ='1') then
--------------				if RESET = '1' then
--------------					send_packet<= write_data;	
--------------					else 
--------------					startsending <= '0';		
--------------							if en = '1' then 
--------------								if idleflag = 1 then 
--------------									idleflag := 0 ;
--------------								else	
--------------									case send_packet is 
--------------									when	write_data =>								
--------------												 if( i < 3 ) then
--------------															send_data <= arr(i);
--------------															i := i + 1;	
--------------															--counter := counter - 1 ; 
--------------															send_packet <= wait_time;
--------------												 else
--------------															 
--------------															 send_packet <= transmit_data;			
--------------												 end if;
--------------										when	wait_time => 
--------------															idleflag := 1; 
--------------															send_addr  <= send_addr + 1;
--------------															send_packet<= write_data ;
--------------										when	transmit_data	=>
--------------														   i := 0;
--------------															startSending  <= '1';
--------------															
--------------															sendFrameCounter <= sendFrameCounter +1;
--------------															send_addr <= "00000000";
--------------														   send_packet <= write_data;
--------------															
----------------								when inc_FC =>				
----------------															
----------------														   sendFrameCounter <= sendFrameCounter +1;
----------------															startSending  <= '0';
----------------															send_packet <= write_data;
--------------								   end case; 
--------------							end if;	
--------------						end if;	
--------------				  end if;		
--------------			 end if;
--------------		 end process;

	timeoutProcess : process (CLK)
        variable timeoutCounter : integer range 0 to TIMEOUT_COUNTER_MAX;
    begin
        if CLK = '1' and CLK'event then
            if RESET = '1' then
                timeoutCounter := 0;
                timeout        <= '0';
            else
                -- default
                timeout <= '0';

                if startTimeoutCounter = '1' then
                    timeoutCounter := 0;
                else
                    if timeoutCounter < TIMEOUT_COUNTER_MAX then
                        timeoutCounter := timeoutCounter + 1;
                    else
                        timeout        <= '1';
                        timeoutCounter := 0;
                    end if;
                end if;
            end if;
        end if;
    end process timeoutProcess;
	 
	 
			process ( clk )
			variable flag_start :integer := 0;
			variable flag_idle : integer := 0;
			variable i : integer  := 0 ;
			begin 
					if (clk'event and clk= '1' ) then 
						if reset = '1' then  
							packet <= idle_state;
							flag_start := 0 ;
							flag_idle := 0 ;
							send_addr <= (others =>('0'));
							
							else
							startSending  <= '0';
									if ( en = '1' ) then 
										if (flag_idle = 1) then
											flag_idle := 0 ;
										else
											case packet is
													when idle_state =>
																			if readyToSend = '1' then 
																				Flag_idle  := 1;
																				Flag_start := 1;
																				packet <= write_data ;	
																			end if;
															
													when sendsend_data =>
																				startSending  <= '1';
																			if Flag_start = 0 then 
																				packet <= idle_state;
																			else 
																				startTimeoutcounter <= '1';
																				packet <= write_data;
																			end if;
													when add_inc =>	
																				if timeout <= '1' then
																					packet <= idle_state;
																				else	
																					send_addr  <= send_addr + 1;
																					packet <= write_data;
																				end if;
													when write_data =>			
																																										
																				
																						send_data <= arr(i);
																						i := i + 1;																						
																						packet <= add_inc;
																				else														 
																						packet <= sendsend_data;																											
																						end if;
																						
											end case;
									end if;
								end if;																	
					end if;
				end if;
		end process;			
end Behavioral;


