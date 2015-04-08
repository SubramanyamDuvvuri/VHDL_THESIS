---------------------------------------------------------------------------------
--! @file NDLCom.vhd
--! @date 2011

--! @addtogroup group_NDLCom
--! @{

--! @defgroup group_NDLCom_vhdl VHDL-Implementation
--! @brief   VHDL implementation of the NDLCom protocol for a two-port node.
--!
--! VHDL implementation of the NDLCom protocol for a two-port node.\n
--! This module can generate, read and forward messages with the NDLCom protocol.\n
--! This means if the ReceiverID in a received message matches the NODE_ID then
--! the message will be outputted otherwise forwarded to the other port.\n
--! It is also possible to send new messages from within the current node.\n
--!
--! To use the NDLCom VHDL implematation within your design you have to create
--! a NDLCom wrapper that handles the received messages as well as the messages
--! to be send.\n
--! For this you can start with the NDLCom_wrapper_example which is originally
--! written for testing with the Spartan3a eval board and adapt it to your
--! needs.\n
--!
--! You can use this modul with a normal UART module as well as with the new
--! highspeed communication by selection the appropriate BAUD_RATE:\n
--! 1. BAUD_RATE/=0: normal communication\n
--! 2. BAUD_RATE=0 : highspeed communication\n\n
--!
--! German Research Center for Artificial Intelligence\n
--! Project: iStruct
--! @{

--! @class   NDLCom
--! @brief   A VHDL module that implements the NDLCom protocol.
--!
--! German Research Center for Artificial Intelligence\n
--! Project: iStruct
--!
--! @date   18.12.2010
--! @author Tobias Stark (tobias.stark@dfki.de)
---------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

library work;
use work.NDLCom_config.all;
use work.crc_pack.all;


entity NDLCom is
    generic (
        CLK_FREQ  : integer := 16000000; --! the system clock (in Hz)
        BAUD_RATE : integer := 115200);  --! the baud rate of this uart, if BAUD_RATE=0, the highspeed communication interface is activated
    port (
        CLK     : in std_logic;                     --! system clock
        RST     : in std_logic;                     --! system reset
        NODE_ID : in std_logic_vector(7 downto 0);  --! the id of this node /Sender_id

        -- Communication pins for normal communication mode (only used if BAUD_RATE/=0)
        RX : in  std_logic := '0';      --! RX input for normal communication mode
        TX : out std_logic;             --! RX output for normal communication mode

        -- Communication pins for highspeed communication mode (only used if BAUD_RATE=0)
        rxPPin : in  std_logic := '0';  --! LVDS positive RX input for highspeed communication mode
        rxNPin : in  std_logic := '0';  --! LVDS negative RX input for highspeed communication mode
        txPPin : out std_logic;         --! LVDS positive TX output for highspeed communication mode
        txNPin : out std_logic;         --! LVDS negative RX output for highspeed communication mode

        -- ------ signals for sending messages ------ --
        readyToSend      : out std_logic;                     --! ready to send output signal / is asserted when the packet is ready to send 
        startSending     : in  std_logic;                     --! start sending input signal
        --Header inputs:receiverid , Nodeid , frame_counter , datalength 
		  sendReceiver     : in  std_logic_vector(7 downto 0);  --! the receiver ID of the message
        sendFrameCounter : in  std_logic_vector(7 downto 0);  --! the frame counter of the message
        sendLength       : in  std_logic_vector(7 downto 0);  --! the length (in bytes) of the data
		  
        -- Buffer IO
		  
		  send_wea         : in  std_logic_vector(0 downto 0);  --! write enable of the input data buffer
        send_addr        : in  std_logic_vector(7 downto 0);  --! actual write address input of the input data buffer
        send_data        : in  std_logic_vector(7 downto 0);  --! data input of the input data buffer

        -- ------ signals for receiving messages ------ --
        
		  newData          : out std_logic;                     --! new data output signal/ is assertd when a data is received
        dataAck          : in  std_logic;                     --! data acknowledge input signal
		  
		  -- Header signals 
        recvSender       : out std_logic_vector(7 downto 0);  --! the sender ID of received message/ node_id of the sender
        recvFrameCounter : out std_logic_vector(7 downto 0);  --! the frame counter of the received message 
        recvLength       : out std_logic_vector(7 downto 0);  --! the length (in bytes) of the data in the received message
		  
		  --buffer IO
		  
        recv_addr        : in  std_logic_vector(7 downto 0);  --! actual read address input of the output data buffer
        recv_data        : out std_logic_vector(7 downto 0);  --! data output of the output data buffer
        recv_error       : out std_logic );                   --! receive error output signal
end NDLCom;

architecture Behavioral of NDLCom is

		-- Header  of four bytes, with Receiver_id , sender_id(Node_id) , Packet_number , Data_length
		
    signal sendHeader : header_type;			
															
	 
    signal recvHeader : header_type;
----------------------------------------------------------------
---Buffer Reading and Writing
----------------------------------------------------------------
    signal send_mem_wea      : std_logic_vector(0 downto 0);				    -- To enable write in a buffer || INPUT
    signal send_mem_addr_in  : std_logic_vector(MEM_ADDR_WIDTH-1 downto 0); -- Address to which data has to be written || INPUT 
    signal send_mem_data_in  : std_logic_vector(7 downto 0);					 -- Data that has to be written || INPUT	
    signal send_mem_addr_out : std_logic_vector(MEM_ADDR_WIDTH-1 downto 0); -- Address from which the data has to be read || INPUT
    signal send_mem_data_out : std_logic_vector(7 downto 0);					 -- Data that is read || out	 

    signal forward_mem_wea      : std_logic_vector(0 downto 0);					-- To enable write in a buffer || INPUT
    signal forward_mem_addr_in  : std_logic_vector(MEM_ADDR_WIDTH-1 downto 0);-- Address to which data has to be written || INPUT 
    signal forward_mem_data_in  : std_logic_vector(7 downto 0);					-- Data that has to be written || INPUT
    signal forward_mem_addr_out : std_logic_vector(MEM_ADDR_WIDTH-1 downto 0);-- Address from which the data has to be read || INPUT
    signal forward_mem_data_out : std_logic_vector(7 downto 0);					-- Data that is read || out	

    signal input_mem_addr_out : std_logic_vector(7 downto 0);						-- Address from which the data has to be read || INPUT 
    signal input_mem_data_out : std_logic_vector(7 downto 0);						-- Data that is read || out

    signal output_mem_wea     : std_logic_vector(0 downto 0);						-- To enable write in a buffer || INPUT
    signal output_mem_addr_in : std_logic_vector(7 downto 0);						-- Address to which data has to be written || INPUT
    signal output_mem_data_in : std_logic_vector(7 downto 0);						-- Data that has to be written || INPUT

------------------------------------------------------------
--							UART signals
------------------------------------------------------------

    signal uart_txData  : std_logic_vector(7 downto 0); 				-- 1 byte  of data || input
    signal uart_txReady : std_logic;										-- asserting when ready for transmission || output
    signal uart_startTx : std_logic;										-- for starting the transmission || INPUT 
    signal uart_rxData  : std_logic_vector(7 downto 0);				-- data that is received and displayed as a byte|| output
    signal uart_newData : std_logic;										-- Assertd when a new data is received || output 
    signal uart_dataAck : std_logic;										
    signal uart_rxErr   : std_logic;

    -- timeout signals
    constant TIMEOUT_COUNTER_MAX : integer := CLK_FREQ/10;
    signal startTimeoutCounter   : std_logic;
    signal timeout               : std_logic;

    signal inputBufferReady : std_logic;

    type readInputStates is (idle, 
									  writeStartFlag, 
										checkHeaderByte, 
										writeHeaderByte,
                             checkData,
									  writeData,
									  inputAddrInc,
                             checkCRCUpperByte, 
									  writeCRCUpperByte, 
									  checkCRCLowerByte, 
									  writeCRCLowerByte, 
									  writeStopFlag
									  );
									  
    signal readInputState : readInputStates;
	 
	 

    type recvUARTStates is (receiveStartFlag,
									 receiveReceiverID, 
									 checkReceiverID,
                            writeReceiverID,
									 receiveHeaderByte, 
									 receiveData,
                            outputAddrInc, 
									 receiveCRCUpperByte, 
									 receiveCRCLowerByte, 
									 receiveStopFlag);
									 
    signal recvUARTState : recvUARTStates;
	 
	 
	 
	 

    signal dataTrigger : std_logic;

    type sendStates is (idleState, 
								sendSendDataState, 
								sendForwardDataState,		--
                        sendAddrInc,
								forwardAddrInc);
    
	 signal sendState : sendStates;
	 

    type rxHandShakeStates is (idle, waitAck, waitTrigger);
    signal rxHandShakeState : rxHandShakeStates;

    signal newData_int : std_logic;

    -- CRC --
    constant CRC_POLYNOMIAL_C : std_logic_vector := Polynomial16_c;
    constant CRC_INIT_C       : std_logic_vector := Crc16Init_c;
    constant CRC_SYNDROM_C    : std_logic_vector := Crc16Syndrom_c;
    signal crc_i_s            : crc_i_t;
    signal crc_o_s            : crc_o_t;

begin

    -- concurrent send input header assignments
    sendHeader(0) <= sendReceiver;
    sendHeader(1) <= NODE_ID;
    sendHeader(2) <= sendFrameCounter;
    sendHeader(3) <= sendLength;

    -- concurrent receive header assignment
    recvSender       <= recvHeader(1);
    recvFrameCounter <= recvHeader(2);
    recvLength       <= recvHeader(3);

    -- send buffer (simple dual-port ram 1024x8) --
    send_buffer_inst : entity work.bram_dp_simple
        generic map (ADDRWIDTH => MEM_ADDR_WIDTH,
                     DATAWIDTH => 8)
        port map (clk   => CLK,
                  we    => send_mem_wea(0),
                  waddr => send_mem_addr_in,
                  wdata => send_mem_data_in,
                  raddr => send_mem_addr_out,
                  rdata => send_mem_data_out);

    -- forward buffer (simple dual-port ram 1024x8) --
    -- Sends messages which were received via UART but are not meant for this NODE_ID
    forward_buffer_inst : entity work.bram_dp_simple
        generic map (ADDRWIDTH => MEM_ADDR_WIDTH,
                     DATAWIDTH => 8)
        port map (clk   => CLK,
                  we    => forward_mem_wea(0),
                  waddr => forward_mem_addr_in,
                  wdata => forward_mem_data_in,
                  raddr => forward_mem_addr_out,
                  rdata => forward_mem_data_out);

    -- input buffer (simple dual-port ram 256x8) --
    input_buffer_inst : entity work.bram_dp_simple
        generic map (ADDRWIDTH => 8,
                     DATAWIDTH => 8)
        port map (clk   => CLK,
                  we    => send_wea(0),
                  waddr => send_addr,
                  wdata => send_data,
                  raddr => input_mem_addr_out,
                  rdata => input_mem_data_out);

    -- output buffer (simple dual-port ram 256x8) --
    output_buffer_inst : entity work.bram_dp_simple
        generic map (ADDRWIDTH  => 8,
                     DATAWIDTH => 8)
        port map (
            clk   => CLK,
            we    => output_mem_wea(0),
            waddr => output_mem_addr_in,
            wdata => output_mem_data_in,
            raddr => recv_addr,
            rdata => recv_data);

    -- uart --
    -- For operation with normal uart --
    ls_mode_gen : if BAUD_RATE /= 0 generate
        UART_inst : entity work.UART_mod(Behavioral)
            generic map (
                SYSTEM_SPEED => CLK_FREQ,
                BAUD_rate    => BAUD_RATE,
                EVEN_parity  => 0,
                ODD_parity   => 0)
            port map (
                CLK     => CLK,
                RST     => RST,
                TX      => TX,
                RX      => RX,
                txData  => uart_txData,
                txReady => uart_txReady,
                startTx => uart_startTx,
                rxData  => uart_rxData,
                newData => uart_newData,
                dataAck => uart_dataAck,
                rxErr   => uart_rxErr);
    end generate ls_mode_gen;

    -- For high speed LVDS communication  --
    hs_mode_gen : if BAUD_RATE = 0 generate
        uart_hs_inst : entity work.uart_hs_mod
            generic map (
                DEVICE_ZYNQ => false,
                CLK_FREQ    => CLK_FREQ,
                BAUD_rate   => BAUD_RATE)
            port map (
                txPPin  => txPPin,
                txNPin  => txNPin,
                rxPPin  => rxPPin,
                rxNPin  => rxNPin,
                txData  => uart_txData,
                txReady => uart_txReady,
                startTx => uart_startTx,
                rxData  => uart_rxData,
                newData => uart_newData,
                dataAck => uart_dataAck,
                rxErr   => uart_rxErr,
                clk     => clk,
                rst     => rst);
    end generate hs_mode_gen;

    -----------------------------------------------------------------------------
    -- Crc Module instantiation
    -----------------------------------------------------------------------------
    crcGen : entity work.crc_par_mod(Behavioral)
        generic map (
            INIT_VALUE => CRC_INIT_c,
            POLYNOMIAL => CRC_POLYNOMIAL_C,
            DATA_WIDTH => 8,
            SYNC_RESET => 1)
        port map (
            clk_i   => clk,
            rst_i   => crc_i_s.crc_gen_reset,
            clken_i => crc_i_s.crc_gen_buf_new_byte ,
            data_i  => crc_i_s.crc_gen_buf,
            match_o => open,
            crc_o   => crc_o_s.crc_gen_value);

    crcCheck : entity work.crc_par_mod(Behavioral)
        generic map (
            INIT_VALUE => CRC_INIT_C,
            POLYNOMIAL => CRC_POLYNOMIAL_C,
            DATA_WIDTH => 8,
            SYNC_RESET => 1)
        port map (
            clk_i   => clk,
            rst_i   => crc_i_s.crc_check_reset,
            clken_i => crc_i_s.crc_check_buf_new_byte,
            data_i  => crc_i_s.crc_check_buf,
            match_o => crc_o_s.crc_check_match,
            crc_o   => crc_o_s.crc_check_value);

    -- ------------------------ --
    -- process that handles the --
    -- incoming data stream     --
    -- ------------------------ --
    recvUARTMonitor : process (clk)
        variable receiverID_buf : std_logic_vector(7 downto 0);
        variable headerCounter  : integer range 0 to HEADER_LENGTH-1;
        variable idleFlag       : std_logic;
        variable escapeFlag     : std_logic;
        variable outputData     : std_logic;
        variable forwardData    : std_logic;
    begin
        if clk = '1' and clk'event then

            if rst = '1' then
                crc_i_s.crc_check_buf_new_byte <= '0';
                crc_i_s.crc_check_reset        <= '1';
                receiverID_buf                 := (others => '0');
                headerCounter                  := 0;
                idleFlag                       := '0';
                escapeFlag                     := '0';
                outputData                     := '0';
                forwardData                    := '0';

                forward_mem_data_in <= (others => '0');
                forward_mem_wea     <= "0";
                forward_mem_addr_in <= (others => '0');
                output_mem_addr_in  <= (others => '0');
                output_mem_wea      <= "0";
                output_mem_data_in  <= (others => '0');

                for i in 0 to HEADER_LENGTH-1 loop
                    recvHeader(i) <= (others => '0');
                end loop;
                recv_error <= '0';

                uart_dataAck <= '0';
                dataTrigger  <= '0';

                recvUARTState <= receiveStartFlag;

            else
                -- defaults
                forward_mem_wea <= "0";
                output_mem_wea  <= "0";
                uart_dataAck    <= '0';
                dataTrigger     <= '0';

                crc_i_s.crc_check_buf_new_byte <= '0';
                crc_i_s.crc_check_reset        <= '0';

                if idleFlag = '1' then
                    idleFlag := '0';
                else

                    if uart_rxErr = '1' then
                        -- first check for rxErr !!
                        escapeFlag    := '0';
                        recv_error    <= '1';
                        recvUARTState <= receiveStartFlag;
                    else

                        case recvUARTState is

                            when receiveStartFlag =>
                                if uart_newData = '1' then
                                    uart_dataAck   <= '1';
                                    if uart_rxData = FLAG_BYTE then
                                        -- we received a flag byte
                                        -- perhaps the start of a message
                                        crc_i_s.crc_check_buf   <= (others => '0');
                                        crc_i_s.crc_check_reset <= '1';
                                        escapeFlag              := '0';
                                        recv_error              <= '0';
                                        recvUARTState           <= receiveReceiverID;
                                    else
                                        recv_error    <= '1';
                                        recvUARTState <= receiveStartFlag;
                                    end if;
                                else
                                    recvUARTState <= receiveStartFlag;
                                end if;

                            when receiveReceiverID =>
                                if uart_newData = '1' then
                                    uart_dataAck <= '1';
                                    recv_error   <= '0';

                                    -- initialize counters and others stuff
                                    headerCounter      := 1;
                                    output_mem_addr_in <= (others => '0');

                                    if uart_rxData = FLAG_BYTE then
                                        -- last byte was not the start
                                        -- flag - perhaps this one
                                        crc_i_s.crc_check_buf   <= (others => '0');
                                        crc_i_s.crc_check_reset <= '1';
                                        escapeFlag              := '0';
                                        recvUARTState           <= receiveReceiverID;

                                    elsif uart_rxData = ESCAPE_BYTE then
                                        -- escape this byte
                                        escapeFlag    := '1';
                                        recvUARTSTate <= receiveReceiverID;

                                    elsif (escapeFlag = '0' and uart_rxData = NODE_ID) or
                                        (escapeFlag = '1' and (uart_rxData xor x"20") = NODE_ID) then
                                        -- message is for this node
                                        escapeFlag                     := '0';
                                        outputData                     := '1';
                                        forwardData                    := '0';
                                        crc_i_s.crc_check_buf_new_byte <= '1';
                                        crc_i_s.crc_check_buf          <= NODE_ID;
                                        recvUARTState                  <= receiveHeaderByte;

                                    elsif (escapeFlag = '0' and uart_rxData = BROADCAST_ID) or
                                        (escapeFlag = '1' and (uart_rxData xor x"20") = BROADCAST_ID) then
                                        -- broadcast message
                                        -- -> write start flag and
                                        --    actual byte to RAM
                                        escapeFlag                     := '0';
                                        outputData                     := '1';
                                        forwardData                    := '1';
                                        crc_i_s.crc_check_buf_new_byte <= '1';
                                        crc_i_s.crc_check_buf          <= BROADCAST_ID;
                                        receiverID_buf                 := BROADCAST_ID;
                                        forward_mem_data_in            <= FLAG_BYTE;
                                        forward_mem_wea                <= "1";
                                        forward_mem_addr_in            <= forward_mem_addr_in + 1;
                                        recvUARTState                  <= checkReceiverID;

                                    else
                                        -- message is not for this node
                                        -- -> write 1.+2. start byte and
                                        --    actual byte to RAM
                                        if escapeFlag = '1' then
                                            receiverID_buf := uart_rxData xor x"20";
                                        else
                                            receiverID_buf := uart_rxData;
                                        end if;
                                        escapeFlag          := '0';
                                        outputData          := '0';
                                        forwardData         := '1';
                                        forward_mem_data_in <= FLAG_BYTE;
                                        forward_mem_wea     <= "1";
                                        forward_mem_addr_in <= forward_mem_addr_in + 1;
                                        recvUARTState       <= checkReceiverID;
                                    end if;
                                else
                                    recvUARTState <= receiveReceiverID;
                                end if;

                            when checkReceiverID =>
                                if receiverID_buf = FLAG_BYTE or receiverID_buf = ESCAPE_BYTE then
                                    escapeFlag          := '1';
                                    forward_mem_data_in <= ESCAPE_BYTE;
                                    forward_mem_wea     <= "1";
                                    forward_mem_addr_in <= forward_mem_addr_in + 1;
                                else
                                    escapeFlag := '0';
                                end if;
                                recvUARTState <= writeReceiverID;

                            when writeReceiverID =>
                                if escapeFlag = '1' then
                                    forward_mem_data_in <= receiverID_buf xor x"20";
                                else
                                    forward_mem_data_in <= receiverID_buf;
                                end if;
                                forward_mem_wea     <= "1";
                                forward_mem_addr_in <= forward_mem_addr_in + 1;
                                recvUARTState       <= receiveHeaderByte;

                            when receiveHeaderByte =>
                                -- receive remaining header bytes
                                -- (without receiver ID byte)
                                if uart_newData = '1' then
                                    uart_dataAck <= '1';

                                    if uart_rxData = ESCAPE_BYTE then
                                        -- escape this byte
                                        escapeFlag := '1';
                                        if forwardData = '1' then
                                            forward_mem_data_in <= ESCAPE_BYTE;
                                            forward_mem_wea     <= "1";
                                            forward_mem_addr_in <= forward_mem_addr_in + 1;
                                        end if;
                                        recvUARTSTate <= receiveHeaderByte;

                                    elsif uart_rxData = FLAG_BYTE then
                                        -- here shouldn't be a flag byte,
                                        -- the actual message is broken
                                        -- but this could be the beginning
                                        -- of the next message
                                        crc_i_s.crc_check_buf   <= (others => '0');
                                        crc_i_s.crc_check_reset <= '1';
                                        escapeFlag              := '0';
                                        recv_error              <= '1';
                                        recvUARTState           <= receiveReceiverID;

                                    else
                                        -- receive next header byte
                                        crc_i_s.crc_check_buf_new_byte <= '1';
                                        if escapeFlag = '1' then
                                            recvHeader(headerCounter)         <= uart_rxData xor x"20";
                                            crc_i_s.crc_check_buf(7 downto 0) <= uart_rxData xor x"20";
                                        else
                                            recvHeader(headerCounter) <= uart_rxData;
                                            crc_i_s.crc_check_buf     <= uart_rxData;
                                        end if;

                                        if forwardData = '1' then
                                            forward_mem_data_in <= uart_rxData;
                                            forward_mem_wea     <= "1";
                                            forward_mem_addr_in <= forward_mem_addr_in + 1;
                                        end if;

                                        if headerCounter < HEADER_LENGTH-1 then
                                            headerCounter := headerCounter + 1;
                                            recvUARTState <= receiveHeaderByte;
                                        else
                                            if (escapeFlag = '0' and uart_rxData = x"00") or
                                                (escapeFlag = '1' and (uart_rxData xor x"20") = x"00") then
                                                recvUARTState <= receiveCRCLowerByte;
                                            else
                                                recvUARTState <= receiveData;
                                            end if;
                                        end if;

                                        escapeFlag := '0';
                                    end if;
                                else
                                    recvUARTState <= receiveHeaderByte;
                                end if;

                            when receiveData =>
                                -- receive data bytes
                                if uart_newData = '1' then
                                    uart_dataAck <= '1';

                                    if uart_rxData = ESCAPE_BYTE then
                                        -- escape this byte
                                        escapeFlag := '1';
                                        if forwardData = '1' then
                                            forward_mem_data_in <= ESCAPE_BYTE;
                                            forward_mem_wea     <= "1";
                                            forward_mem_addr_in <= forward_mem_addr_in + 1;
                                        end if;
                                        recvUARTSTate <= receiveData;

                                    elsif uart_rxData = FLAG_BYTE then
                                        -- here shouldn't be a flag byte,
                                        -- the actual message is broken
                                        -- but this could be the beginning
                                        -- of the next message
                                        crc_i_s.crc_check_buf   <= (others => '0');
                                        crc_i_s.crc_check_reset <= '1';
                                        escapeFlag              := '0';
                                        recv_error              <= '1';
                                        recvUARTState           <= receiveReceiverID;

                                    else
                                        crc_i_s.crc_check_buf_new_byte <= '1';
                                        -- receive next data byte
                                        if escapeFlag = '1' then
                                            output_mem_data_in    <= uart_rxData xor x"20";
                                            crc_i_s.crc_check_buf <= uart_rxData xor x"20";
                                        else
                                            output_mem_data_in    <= uart_rxData;
                                            crc_i_s.crc_check_buf <= uart_rxData;
                                        end if;
                                        output_mem_wea <= "1";

                                        if forwardData = '1' then
                                            forward_mem_data_in <= uart_rxData;
                                            forward_mem_wea     <= "1";
                                            forward_mem_addr_in <= forward_mem_addr_in + 1;
                                        end if;

                                        escapeFlag    := '0';
                                        recvUARTState <= outputAddrInc;
                                    end if;
                                else
                                    recvUARTState <= receiveData;
                                end if;


                            when outputAddrInc =>
                                if output_mem_addr_in >= recvHeader(headerCounter)-1 then
                                    recvUARTState <= receiveCRCLowerByte;
                                else
                                    output_mem_addr_in <= output_mem_addr_in + 1;
                                    idleFlag           := '1';
                                    recvUARTState      <= receiveData;
                                end if;

                            when receiveCRCLowerByte =>
                                if uart_newData = '1' then
                                    uart_dataAck <= '1';

                                    if uart_rxData = ESCAPE_BYTE then
                                        -- escape this byte
                                        escapeFlag := '1';
                                        if forwardData = '1' then
                                            forward_mem_data_in <= ESCAPE_BYTE;
                                            forward_mem_wea     <= "1";
                                            forward_mem_addr_in <= forward_mem_addr_in + 1;
                                        end if;
                                        recvUARTState <= receiveCRCLowerByte;

                                    elsif uart_rxData = FLAG_BYTE then
                                        -- here shouldn't be a flag byte,
                                        -- the actual message is broken
                                        -- but this could be the beginning
                                        -- of the next message
                                        crc_i_s.crc_check_buf   <= (others => '0');
                                        crc_i_s.crc_check_reset <= '1';
                                        escapeFlag              := '0';
                                        recv_error              <= '1';
                                        recvUARTState           <= receiveReceiverID;

                                    else
                                        -- receive and check the checksum
                                        if outputData = '1' then
                                            -- receive and check the checksum
                                            if (escapeFlag = '0' and uart_rxData = crc_o_s.crc_check_value(7 downto 0)) or
                                                (escapeFlag = '1' and (uart_rxData xor x"20") = crc_o_s.crc_check_value(7 downto 0)) then
                                                -- Correct CRC lower byte -> receive upper byte
                                                recvUARTState <= receiveCRCUpperByte;
                                            else
                                                -- wrong CRC
                                                recv_error    <= '1';
                                                recvUARTState <= receiveStartFlag;
                                            end if;
                                        else
                                            recvUARTState <= receiveCRCUpperByte;
                                        end if;
                                        escapeFlag := '0';

                                        if forwardData = '1' then
                                            forward_mem_data_in <= uart_rxData;
                                            forward_mem_wea     <= "1";
                                            forward_mem_addr_in <= forward_mem_addr_in + 1;
                                        end if;
                                    end if;
                                else
                                    recvUARTState <= receiveCRCLowerByte;
                                end if;

                            when receiveCRCUpperByte =>
                                if uart_newData = '1' then
                                    uart_dataAck <= '1';
                                    if uart_rxData = ESCAPE_BYTE then
                                        -- escape this byte
                                        escapeFlag := '1';
                                        if forwardData = '1' then
                                            forward_mem_data_in <= ESCAPE_BYTE;
                                            forward_mem_wea     <= "1";
                                            forward_mem_addr_in <= forward_mem_addr_in + 1;
                                        end if;
                                        recvUARTState <= receiveCRCUpperByte;
                                    elsif uart_rxData = FLAG_BYTE then
                                        -- here shouldn't be a flag byte,
                                        -- the actual message is broken
                                        -- but this could be the beginning
                                        -- of the next message
                                        crc_i_s.crc_check_buf   <= (others => '0');
                                        crc_i_s.crc_check_reset <= '1';
                                        escapeFlag              := '0';
                                        recv_error              <= '1';
                                        recvUARTState           <= receiveReceiverId;
                                    else
                                        -- Data is for this node
                                        if outputData = '1' then
                                            --receive and check the checksum
                                            if (escapeFlag = '0' and uart_rxData = crc_o_s.crc_check_value(15 downto 8)) or
                                                (escapeFlag = '1' and (uart_rxData xor x"20") = crc_o_s.crc_check_value(15 downto 8)) then
                                                -- Correct CRC -> trigger data output
                                                dataTrigger   <= '1';
                                                recvUARTState <= receiveStopFlag;
                                            else
                                                -- wrong CRC
                                                recv_error    <= '1';
                                                recvUARTState <= receiveStartFlag;
                                            end if;
                                        else
                                            recvUARTState <= receiveStopFlag;
                                        end if;
                                        escapeFlag := '0';
                                        if forwardData = '1' then
                                            forward_mem_data_in <= uart_rxData;
                                            forward_mem_wea     <= "1";
                                            forward_mem_addr_in <= forward_mem_addr_in + 1;
                                        end if;

                                    end if;
                                else
                                    recvUARTState <= receiveCRCUpperByte;
                                end if;

                            when receiveStopFlag =>
                                if uart_newData = '1' then
                                    uart_dataAck <= '1';
                                    if uart_rxData = FLAG_BYTE then
                                        crc_i_s.crc_check_buf   <= (others => '0');
                                        crc_i_s.crc_check_reset <= '1';

                                        if forwardData = '1' then
                                            forward_mem_data_in <= FLAG_BYTE;
                                            forward_mem_wea     <= "1";
                                            forward_mem_addr_in <= forward_mem_addr_in + 1;
                                        end if;

                                    else
                                        recv_error <= '1';
                                    end if;

                                    recvUARTState <= receiveReceiverID;
                                else
                                    recvUARTState <= receiveStopFlag;
                                end if;

                        end case;
                    end if;

                end if;
            end if;
        end if;
    end process recvUARTMonitor;


    -- ------------------------ --
    -- process that handles the --
    -- incoming data stream     --
    -- ------------------------ --
    readInputMonitor : process (CLK)
        variable headerCounter  : integer range 0 to HEADER_LENGTH-1;
        variable escapeFlag     : std_logic;
        variable outputData     : std_logic;
        variable forwardData    : std_logic;
        variable idleFlag       : std_logic;
    begin
        if CLK = '1' and CLK'event then

            if RST = '1' then
                crc_i_s.crc_gen_reset        <= '1';
                crc_i_s.crc_gen_buf_new_byte <= '0';

                headerCounter                := 0;
                escapeFlag                   := '0';
                idleFlag                     := '0';

                send_mem_data_in   <= (others => '0');
                send_mem_wea       <= "0";
                send_mem_addr_in   <= (others => '0');
                input_mem_addr_out <= (others => '0');

                inputBufferReady <= '1';

                readInputState <= idle;

            else
                -- defaults
                send_mem_wea                 <= "0";
                crc_i_s.crc_gen_reset        <= '0';
                crc_i_s.crc_gen_buf_new_byte <= '0';
                if idleFlag = '1' then
                    idleFlag := '0';
                else

                    case readInputState is

                        when idle =>
                            if startSending = '1' then
                                inputBufferReady <= '0';
                                readInputState   <= writeStartFlag;
                            else
                                readInputState <= idle;
                            end if;

                        when writeStartFlag =>
                            headerCounter      := 0;
                            input_mem_addr_out <= (others => '0');

                            send_mem_data_in <= FLAG_BYTE;
                            send_mem_wea     <= "1";
                            send_mem_addr_in <= send_mem_addr_in + 1;
                            readInputState   <= checkHeaderByte;

                        when checkHeaderByte =>
                            if sendHeader(headerCounter) = FLAG_BYTE or
                                sendHeader(headerCounter) = ESCAPE_BYTE then
                                escapeFlag       := '1';
                                send_mem_data_in <= ESCAPE_BYTE;
                                send_mem_wea     <= "1";
                                send_mem_addr_in <= send_mem_addr_in + 1;
                            else
                                escapeFlag := '0';
                            end if;
                            readInputState <= writeHeaderByte;

                        when writeHeaderByte =>
                            crc_i_s.crc_gen_buf_new_byte <= '1';
                            crc_i_s.crc_gen_buf          <= sendHeader(headerCounter);
                            if escapeFlag = '1' then
                                send_mem_data_in <= sendHeader(headerCounter) xor x"20";
                            else
                                send_mem_data_in <= sendHeader(headerCounter);
                            end if;
                            send_mem_wea     <= "1";
                            send_mem_addr_in <= send_mem_addr_in + 1;
                            if headerCounter < HEADER_LENGTH-1 then
                                headerCounter  := headerCounter + 1;
                                readInputState <= checkHeaderByte;
                            else
                                if sendHeader(headerCounter) = x"00" then
                                    readInputState <= checkCRCUpperByte;
                                else
                                    readInputState <= checkData;
                                end if;
                            end if;

                        when checkData =>
                            if input_mem_data_out = FLAG_BYTE or input_mem_data_out = ESCAPE_BYTE then
                                escapeFlag       := '1';
                                send_mem_data_in <= ESCAPE_BYTE;
                                send_mem_wea     <= "1";
                                send_mem_addr_in <= send_mem_addr_in + 1;
                            else
                                escapeFlag := '0';
                            end if;
                            readInputState <= writeData;

                        when writeData =>
                            crc_i_s.crc_gen_buf_new_byte <= '1';
                            crc_i_s.crc_gen_buf          <= input_mem_data_out;
                            if escapeFlag = '1' then
                                send_mem_data_in <= input_mem_data_out xor x"20";
                            else
                                send_mem_data_in <= input_mem_data_out;
                            end if;
                            send_mem_wea     <= "1";
                            send_mem_addr_in <= send_mem_addr_in + 1;
                            readInputState   <= inputAddrInc;

                        when inputAddrInc =>
                            if input_mem_addr_out >= sendLength-1 then
                                readInputState <= checkCRCLowerByte;
                            else
                                input_mem_addr_out <= input_mem_addr_out + 1;
                                idleFlag           := '1';
                                readInputState     <= checkData;
                            end if;

                        when checkCRCLowerByte =>
                            if crc_o_s.crc_gen_value(7 downto 0) = FLAG_BYTE or crc_o_s.crc_gen_value(7 downto 0) = ESCAPE_BYTE then
                                escapeFlag       := '1';
                                send_mem_data_in <= ESCAPE_BYTE;
                                send_mem_wea     <= "1";
                                send_mem_addr_in <= send_mem_addr_in + 1;
                            else
                                escapeFlag := '0';
                            end if;
                            readInputState <= writeCRCLowerByte;

                        when writeCRCLowerByte =>
                            if escapeFlag = '1' then
                                send_mem_data_in <= crc_o_s.crc_gen_value(7 downto 0) xor X"20";
                            else
                                send_mem_data_in <= crc_o_s.crc_gen_value(7 downto 0);
                            end if;
                            send_mem_wea     <= "1";
                            send_mem_addr_in <= send_mem_addr_in + 1;
                            readInputState   <= checkCRCUpperbyte;

                        when checkCRCUpperByte =>
                            if crc_o_s.crc_gen_value(15 downto 8) = FLAG_BYTE or crc_o_s.crc_gen_value(15 downto 8) = ESCAPE_BYTE then
                                escapeFlag       := '1';
                                send_mem_data_in <= ESCAPE_BYTE;
                                send_mem_wea     <= "1";
                                send_mem_addr_in <= send_mem_addr_in + 1;
                            else
                                escapeFlag := '0';
                            end if;
                            readInputState <= writeCRCUpperByte;

                        when writeCRCUpperByte =>
                            if escapeFlag = '1' then
                                send_mem_data_in <= crc_o_s.crc_gen_value(15 downto 8) xor X"20";
                            else
                                send_mem_data_in <= crc_o_s.crc_gen_value(15 downto 8);
                            end if;
                            send_mem_wea     <= "1";
                            send_mem_addr_in <= send_mem_addr_in + 1;
                            readInputState   <= writeStopFlag;

                        when writeStopFlag =>
                            crc_i_s.crc_gen_reset <= '1';
                            send_mem_data_in <= FLAG_BYTE;
                            send_mem_wea     <= "1";
                            send_mem_addr_in <= send_mem_addr_in + 1;
                            inputBufferReady <= '1';
                            readInputState   <= idle;
                            
                    end case;

                end if;
            end if;
        end if;
    end process readInputMonitor;

    -- ----------------------------------- --
    -- check if a new message              --
    -- could be send by checking the       --
    -- remaining size of the send ring     --
    -- buffer and the signal from the      --
    -- readInputMonitor.                   --
    -- ----------------------------------- --

    readyToSend <= '0' when inputBufferReady = '0' or startSending = '1' or
							((send_mem_addr_in > send_mem_addr_out and
                     (send_mem_addr_out - send_mem_addr_in) < MAX_PACKET_SIZE) or
                    (send_mem_addr_in <= send_mem_addr_out and
                     (MEM_SIZE-1 - send_mem_addr_in + send_mem_addr_out) < MAX_PACKET_SIZE))
                   else '1';

    timeoutProcess : process (CLK)
        variable timeoutCounter : integer range 0 to TIMEOUT_COUNTER_MAX;
    begin
        if CLK = '1' and CLK'event then
            if RST = '1' then
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

-- ------------------------ --
-- process that handles the --
-- outgoing TX data stream  --
-- ------------------------ --
    sendMonitor : process (clk)
        variable idleFlag  : std_logic;
        variable startFlag : std_logic;
    begin
        if clk = '1' and clk'event then
            if rst = '1' then
                idleFlag             := '0';
                startFlag            := '0';
                send_mem_addr_out    <= (others => '0');
                forward_mem_addr_out <= (others => '0');
                uart_txData          <= (others => '0');
                uart_startTx         <= '0';
                startTimeoutCounter  <= '0';
                sendState            <= idleState;

            else
                -- defaults
                uart_startTx        <= '0';
                startTimeoutCounter <= '0';

                if idleFlag = '1' then
                    idleFlag := '0';
                else

                    case sendState is
                        when idleState =>
                            if uart_txReady = '1' and forward_mem_addr_in /= forward_mem_addr_out then
                                idleFlag             := '1';
                                startFlag            := '1';
                                forward_mem_addr_out <= forward_mem_addr_out + 1;
                                sendState            <= sendForwardDataState;
                            elsif uart_txReady = '1' and send_mem_addr_in /= send_mem_addr_out then
                                idleFlag          := '1';
                                startFlag         := '1';
                                send_mem_addr_out <= send_mem_addr_out + 1;
                                sendState         <= sendSendDataState;
                            else
                                sendState <= idleState;
                            end if;

                        when sendSendDataState =>
                            uart_txData  <= send_mem_data_out;
                            uart_startTx <= '1';
                            if startFlag = '0' and send_mem_data_out = FLAG_BYTE then
                                sendState <= idleState;
                            else
                                startTimeoutCounter <= '1';
                                sendState           <= sendAddrInc;
                            end if;
                            startFlag := '0';

                        when sendAddrInc =>
                            if timeout = '1' then
                                sendState <= idleState;
                            elsif uart_txReady = '1' and send_mem_addr_in /= send_mem_addr_out then
                                idleFlag          := '1';
                                send_mem_addr_out <= send_mem_addr_out + 1;
                                sendState         <= sendSendDataState;
                            else
                                sendState <= sendAddrInc;
                            end if;

                        when sendForwardDataState =>
                            uart_txData  <= forward_mem_data_out;
                            uart_startTx <= '1';
                            if startFlag = '0' and forward_mem_data_out = FLAG_BYTE then
                                sendState <= idleState;
                            else
                                startTimeoutCounter <= '1';
                                sendState           <= forwardAddrInc;
                            end if;
                            startFlag := '0';

                        when forwardAddrInc =>
                            if timeout = '1' then
                                sendState <= idleState;
                            elsif uart_txReady = '1' and forward_mem_addr_in /= forward_mem_addr_out then
                                idleFlag             := '1';
                                forward_mem_addr_out <= forward_mem_addr_out + 1;
                                sendState            <= sendForwardDataState;
                            else
                                sendState <= forwardAddrInc;
                            end if;

                    end case;

                end if;
            end if;
        end if;
    end process sendMonitor;

-- ------------------------ --
-- process that handles the --
-- rx hand shake            --
-- ------------------------ --
    rxHandShakeHandler : process (clk, rst)
    begin
        if rst = '1' then
            newData_int      <= '0';
            rxHandShakeState <= idle;

        elsif rising_edge(clk) then

            case rxHandShakeState is

                when idle =>
                    if dataTrigger = '1' then
                        newData_int      <= '1';
                        rxHandShakeState <= waitAck;
                    else
                        rxHandShakeState <= idle;
                    end if;

                when waitAck =>
                    if dataAck = '1' then
                        newData_int      <= '0';
                        rxHandShakeState <= waitTrigger;
                    else
                        rxHandShakeState <= waitAck;
                    end if;

                when waitTrigger =>
                    if dataAck = '0' and dataTrigger = '0' then
                        rxHandShakeState <= idle;
                    else
                        rxHandShakeState <= waitTrigger;
                    end if;

            end case;

        end if;
    end process rxHandShakeHandler;

    newData <= newData_int and not dataAck;
end Behavioral;

--! @}

--! @}
