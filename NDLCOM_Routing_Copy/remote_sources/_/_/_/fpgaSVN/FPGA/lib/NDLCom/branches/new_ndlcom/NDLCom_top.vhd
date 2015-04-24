---------------------------------------------------------------------------------
--! @file   NDLCom_top.vhd
--! @author Tobias Stark (tobias.stark@dfki.de)
--! @date   22.01.2015
--!
--! @brief  Top-level module for NDLCom.
--!
--! Top-level module for NDLCom. This module can handle HSComm as well as normal
--! lowspeed communication ports (could be configured via generics). When using
--! more than two ports this module work as a router. At startup the routing table
--! is initialized to send broadcast messages over all ports, but when receiving
--! messages the routing table is updated correspondingly.\n\n
--!
--! German Research Center for Artificial Intelligence
---------------------------------------------------------------------------------
-- Last Commit: 
-- $LastChangedRevision: 3958 $
-- $LastChangedBy: tstark $
-- $LastChangedDate: 2015-04-17 18:05:25 +0200 (Fri, 17 Apr 2015) $
---------------------------------------------------------------------------------
library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.NDLCom_config.all;
use work.dfki_pack.all;
use work.crc_pack.all;

library Spartan6;
use Spartan6.asynch_sercomm_config_pack.all;

entity NDLCom_top is
    generic ( CLK_FREQ           : natural := 16000000; --! the system clock (in Hz)
              NUMBER_OF_HS_PORTS : natural := 0;        --! number of highspeed communication ports
              NUMBER_OF_LS_PORTS : natural := 1;        --! number of lowspeed communication ports
              LS_BAUD_RATE       : natural := 921600 ); --! baud rate of the lowspeed communication ports
    port (
        CLK     : in std_logic;                     --! system clock (aka clkCommInterface)
        RST     : in std_logic;                     --! system reset
--        clkHalfDR        : in  std_logic;           --! Datarate/2, gclk network
--        clkDoubleDR_ioce : in  std_logic;           --! Datarate/2, special ioce synchronisation network
--        clkDoubleDR_io   : in  std_logic;           --! Datarate*2, BUFIO2 or BUFPLL Clock Region network
        NODE_ID : in std_logic_vector(7 downto 0);  --! the id of this node

        -- Communication pins for highspeed communication
        hs_rx_p : in  std_logic_vector(1-1 downto 0);  --! LVDS positive RX input for highspeed communication
        hs_rx_n : in  std_logic_vector(1-1 downto 0);  --! LVDS negative RX input for highspeed communication
        hs_tx_p : out std_logic_vector(1-1 downto 0);  --! LVDS positive TX output for highspeed communication
        hs_tx_n : out std_logic_vector(1-1 downto 0);  --! LVDS negative RX output for highspeed communication

        -- Communication pins for lowspeed communication
        ls_rx : in  std_logic_vector(NUMBER_OF_LS_PORTS-1 downto 0);    --! RX input for lowspeed communication
        ls_tx : out std_logic_vector(NUMBER_OF_LS_PORTS-1 downto 0);    --! TX output for lowspeed communication

        -- ----------------- --
        --       DEBUG       --
        -- ----------------- --
       -- hs_txData         : out Array2x8;
        hs_txData_Kflag   : out std_logic_vector(1 downto 0);
        hs_txData_trigger : in  std_logic_vector(1 downto 0);
       -- hs_rxData         : in  Array2x8;
        hs_rxData_Kflag   : in  std_logic_vector(1 downto 0);
        hs_rxData_CodeErr : in  std_logic_vector(1 downto 0);
        hs_rxData_DispErr : in  std_logic_vector(1 downto 0);
        hs_rxData_trigger : in  std_logic_vector(1 downto 0);
        ls_txData  : out std_logic_vector(7 downto 0);
        ls_txReady : in  std_logic;
        ls_startTx : out std_logic;
        ls_rxData  : in  std_logic_vector(7 downto 0);
        ls_newData : in  std_logic;
        ls_dataAck : out std_logic;
        ls_rxErr   : in  std_logic;

        -- ------ signals for sending messages ------ --
        readyToSend      : out std_logic;                     --! ready to send output signal
        startSending     : in  std_logic;                     --! start sending input signal
        sendReceiver     : in  std_logic_vector(7 downto 0);  --! the receiver ID of the message
        sendFrameCounter : in  std_logic_vector(7 downto 0);  --! the frame counter of the message
        sendLength       : in  std_logic_vector(7 downto 0);  --! the length (in bytes) of the data
        send_wea         : in  std_logic_vector(0 downto 0);  --! write enable of the input data buffer
        send_addr        : in  std_logic_vector(7 downto 0);  --! actual write address input of the input data buffer
        send_data        : in  std_logic_vector(7 downto 0);  --! data input of the input data buffer

        -- ------ signals for receiving messages ------ --
        newData          : out std_logic;                     --! new data output signal
        dataAck          : in  std_logic;                     --! data acknowledge input signal
        recvSender       : out std_logic_vector(7 downto 0);  --! the sender ID of received message
        recvFrameCounter : out std_logic_vector(7 downto 0);  --! the frame counter of the received message
        recvLength       : out std_logic_vector(7 downto 0);  --! the length (in bytes) of the data in the received message
        recv_addr        : in  std_logic_vector(7 downto 0);  --! actual read address input of the output data buffer
        recv_data        : out std_logic_vector(7 downto 0);  --! data output of the output data buffer
        
        error            : out std_logic;                     --! error flag
        last_error       : out std_logic_vector(15 downto 0);  --! vector which shows the last error
        clear_last_error : in std_logic;
        error_debug1     : out std_logic_vector(15 downto 0);
        error_debug2     : out std_logic_vector(15 downto 0) );
end NDLCom_top;

architecture Behavioral of NDLCom_top is

    constant NUMBER_OF_PORTS : natural := NUMBER_OF_HS_PORTS + NUMBER_OF_LS_PORTS;

    type ByteArray is array(natural range <>) of std_logic_vector(7 downto 0);

    signal sendHeader : header_type;
    signal recvHeader : header_type;

    type routingTable_type is array(0 to 255) of integer range 0 to NUMBER_OF_PORTS;
    signal routingTable  : routingTable_type;
    signal sender_id     : ByteArray(NUMBER_OF_PORTS-1 downto 0);
    signal new_sender_id : std_logic_vector(NUMBER_OF_PORTS-1 downto 0);

    signal input_mem_addr_out : std_logic_vector(7 downto 0);
    signal input_mem_data_out : std_logic_vector(7 downto 0);

    signal output_mem_wea     : std_logic_vector(0 downto 0);
    signal output_mem_addr_in : std_logic_vector(7 downto 0);
    signal output_mem_data_in : std_logic_vector(7 downto 0);

    signal output_fifo_wr    : std_logic;
    signal output_fifo_din   : std_logic_vector(7 downto 0);
    signal output_fifo_full  : std_logic;
    signal output_fifo_remaining : std_logic_vector(MEM_ADDR_WIDTH downto 0);

    signal send_fifo_ready    : std_logic_vector(NUMBER_OF_PORTS-1 downto 0);
    signal send_fifo_wr       : std_logic_vector(NUMBER_OF_PORTS-1 downto 0);
    signal send_fifo_din      : ByteArray(NUMBER_OF_PORTS-1 downto 0);
    signal receive_fifo_empty : std_logic_vector(NUMBER_OF_PORTS-1 downto 0);
    signal receive_fifo_rd    : std_logic_vector(NUMBER_OF_PORTS-1 downto 0);
    signal receive_fifo_dout  : ByteArray(NUMBER_OF_PORTS-1 downto 0);
    signal forward_fifo_empty : std_logic_vector(NUMBER_OF_PORTS downto 0);  -- incl. output fifo
    signal forward_fifo_rd    : std_logic_vector(NUMBER_OF_PORTS downto 0);  -- incl. output fifo
    signal forward_fifo_dout  : ByteArray(NUMBER_OF_PORTS downto 0);         -- incl. output fifo

    -- encoder signals
    type encoderStates is (idle, writeStartFlag, writeHeaderByte, writeData,
                           writeCRCUpperByte, writeCRCLowerByte, writeStopFlag);
    signal encoderState : encoderStates;
    signal inputBufferReady : std_logic;

    -- decoder signals
    type decoderStates is (checkFifos, readStartFlag, readReceiverId,
                           readHeaderByte, readData, readCRCLowerByte,
                           readCRCUpperByte, readStopFlag);
    signal decoderState : decoderStates;
    signal dataTrigger  : std_logic;

    -- receive handshake signals
    type rxHandShakeStates is (idle, waitAck, waitTrigger);
    signal rxHandShakeState : rxHandShakeStates;
    signal newData_int : std_logic;

    -- forward signals (demux, mux)
    type demuxStates is (readStartFlag, readReceiverId,
                         waitAck, broadcast_setRequest1, broadcast_setRequest2, broadcast_waitAck,
                         writeStartFlag, writeReceiverId, forwardData );
    type demuxState_t is array(NUMBER_OF_PORTS downto 0) of demuxStates;
    signal demuxState : demuxState_t;
    type muxStates is (waitRequest, writeData);
    type muxState_t is array(NUMBER_OF_PORTS-1 downto 0) of muxStates;
    signal muxState : muxState_t;
    
    type ForwardRequest_t is array(NUMBER_OF_PORTS downto 0) of std_logic_vector(NUMBER_OF_PORTS-1 downto 0);
    type ForwardAck_t     is array(NUMBER_OF_PORTS-1 downto 0) of std_logic_vector(NUMBER_OF_PORTS downto 0);
    signal broadcast_request  : std_logic_vector(NUMBER_OF_PORTS downto 0);
    signal forward_request    : ForwardRequest_t;
    signal forward_ack        : ForwardAck_t;
    signal forward_data       : ByteArray(NUMBER_OF_PORTS downto 0);
    signal forward_data_valid : std_logic_vector(NUMBER_OF_PORTS downto 0);
    signal forward_tmp_data   : ByteArray(NUMBER_OF_PORTS downto 0);
    signal forward_tmp_valid  : std_logic_vector(NUMBER_OF_PORTS downto 0);
    signal forward_active     : std_logic_vector(NUMBER_OF_PORTS downto 0);

    -- CRC --
    constant CRC_POLYNOMIAL_C : std_logic_vector := Polynomial16_c;
    constant CRC_INIT_C       : std_logic_vector := Crc16Init_c;
    constant CRC_SYNDROM_C    : std_logic_vector := Crc16Syndrom_c;
    signal crc_i_s            : crc_i_t;
    signal crc_o_s            : crc_o_t;

    -- timeout signals
    constant TIMEOUT_COUNTER_MAX : integer := CLK_FREQ * TIMEOUT_MS/1000;
    type timerState_t is (idle, active);
    signal startDemuxTimer : std_logic_vector(NUMBER_OF_PORTS downto 0);
    signal demux_timeout   : std_logic_vector(NUMBER_OF_PORTS downto 0);
    signal decoder_timeout : std_logic;

    -- Errors --
    signal err_decode         : std_logic;
    signal err_demux          : std_logic_vector(NUMBER_OF_PORTS downto 0);
    signal err_hs_sendTimeout : std_logic_vector(NUMBER_OF_HS_PORTS-1 downto 0);
    signal err_hs_decoderCode : std_logic_vector(NUMBER_OF_HS_PORTS-1 downto 0);
    signal err_hs_decoderDisp : std_logic_vector(NUMBER_OF_HS_PORTS-1 downto 0);
    signal err_hs_bufferFull  : std_logic_vector(NUMBER_OF_HS_PORTS-1 downto 0);
    signal err_hs_brokenMsg   : std_logic_vector(NUMBER_OF_HS_PORTS-1 downto 0);
    signal err_ls_uartRx      : std_logic_vector(NUMBER_OF_LS_PORTS-1 downto 0);
    signal err_ls_bufferFull  : std_logic_vector(NUMBER_OF_LS_PORTS-1 downto 0);
    signal err_ls_brokenMsg   : std_logic_vector(NUMBER_OF_LS_PORTS-1 downto 0);

begin

    error <= '1' when err_decode='1' or
             to_integer(unsigned(err_demux))/=0 or
             to_integer(unsigned(err_hs_sendTimeout))/=0 or
             to_integer(unsigned(err_hs_decoderCode))/=0 or
             to_integer(unsigned(err_hs_decoderDisp))/=0 or
             to_integer(unsigned(err_hs_bufferFull))/=0 or
             to_integer(unsigned(err_hs_brokenMsg))/=0 or
             to_integer(unsigned(err_ls_uartRx))/=0 or
             to_integer(unsigned(err_ls_bufferFull))/=0 or
             to_integer(unsigned(err_ls_brokenMsg))/=0
             else '0';

    error_latch : process (clk)
    begin
        if clk'event and clk='1' then
            if rst='1' then
                last_error <= (others => '0');
                error_debug1 <= (others => '0');
                error_debug2 <= (others => '0');
            else
                if clear_last_error='1' then
                    last_error <= (others => '0');
                    error_debug1 <= (others => '0');
                    error_debug2 <= (others => '0');
                else
                    if err_decode='1' then                               -- 0x200
                        last_error(10) <= '1';
                    end if;
                    if to_integer(unsigned(err_demux))/=0 then           -- 0x100
                        last_error(8) <= '1';
                        error_debug1(3 downto 0) <= std_logic_vector(resize(unsigned(err_demux),4));
                    end if;
                    if to_integer(unsigned(err_hs_sendTimeout))/=0 then  -- 0x80
                        last_error(7) <= '1';
                    end if;
                    if to_integer(unsigned(err_hs_decoderCode))/=0 then  -- 0x40
                        last_error(6) <= '1';
                        error_debug2(3 downto 0) <= std_logic_vector(resize(unsigned(err_hs_decoderCode),4));
                    end if;
                    if to_integer(unsigned(err_hs_decoderDisp))/=0 then  -- 0x20
                        last_error(5) <= '1';
                        error_debug2(7 downto 4) <= std_logic_vector(resize(unsigned(err_hs_decoderDisp),4));
                    end if;
                    if to_integer(unsigned(err_hs_bufferFull))/=0 then   -- 0x10
                        last_error(4) <= '1';
                        error_debug2(11 downto 8) <= std_logic_vector(resize(unsigned(err_hs_bufferFull),4));
                    end if;
                    if to_integer(unsigned(err_hs_brokenMsg))/=0 then    -- 0x8
                        last_error(3) <= '1';
                        error_debug2(15 downto 12) <= std_logic_vector(resize(unsigned(err_hs_brokenMsg),4));
                    end if;
                    if to_integer(unsigned(err_ls_uartRx))/=0 then       -- 0x4
                        last_error(2) <= '1';
                    end if;
                    if to_integer(unsigned(err_ls_bufferFull))/=0 then   -- 0x2
                        last_error(1) <= '1';
                    end if;
                    if to_integer(unsigned(err_ls_brokenMsg))/=0 then    -- 0x1
                        last_error(0) <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;
----
    -- concurrent input header assignments for sending
    sendHeader(0) <= sendReceiver;
    sendHeader(1) <= NODE_ID;
    sendHeader(2) <= sendFrameCounter;
    sendHeader(3) <= sendLength;

    -- concurrent received header assignment for output
    recvSender       <= recvHeader(1);
    recvFrameCounter <= recvHeader(2);
    recvLength       <= recvHeader(3);

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

    -- output fifo (1024 bytes)
    output_fifo : entity work.fast_fifo
        generic map ( ADDRWIDTH => MEM_ADDR_WIDTH,
                      DATAWIDTH => 8 )
        port map ( clk   => clk,
                   rst   => rst,
                   wr    => output_fifo_wr,
                   din   => output_fifo_din,
                   rd    => forward_fifo_rd(NUMBER_OF_PORTS),
                   dout  => forward_fifo_dout(NUMBER_OF_PORTS),
                   empty => forward_fifo_empty(NUMBER_OF_PORTS),
                   full  => output_fifo_full,
                   remaining => output_fifo_remaining );

    NDLComHS_Ports : for I in 0 to NUMBER_OF_HS_PORTS-1 generate
        NDLComHS_Port : entity work.NDLComHS
            port map ( CLK                => CLK,
                       RST                => RST,
                       clkHalfDR          => '0',
                       clkDoubleDR_ioce   => '0',
                       clkDoubleDR_io     => '0',
                       NODE_ID            => NODE_ID,
                       TX_P               => hs_tx_p(I),
                       TX_N               => hs_tx_n(I),
                       RX_P               => hs_rx_p(I),
                       RX_N               => hs_rx_n(I),
                       txData_sim         => open,--hs_txData(I),
                       txData_Kflag_sim   => open, --hs_txData_Kflag(I),
                       txData_trigger_sim => '0', --hs_txData_trigger(I),
                       rxData_sim         => (others => '0'), --hs_rxData(I),
                       rxData_Kflag_sim   => '0', --hs_rxData_Kflag(I),
                       rxData_CodeErr_sim => '0', --hs_rxData_CodeErr(I),
                       rxData_DispErr_sim => '0', --hs_rxData_DispErr(I),
                       rxData_trigger_sim => '0', --hs_rxData_trigger(I),
                       send_fifo_ready    => send_fifo_ready(I),
                       send_fifo_wr       => send_fifo_wr(I),
                       send_fifo_din      => send_fifo_din(I),
                       receive_fifo_empty => receive_fifo_empty(I),
                       receive_fifo_rd    => receive_fifo_rd(I),
                       receive_fifo_dout  => receive_fifo_dout(I),
                       forward_fifo_empty => forward_fifo_empty(I),
                       forward_fifo_rd    => forward_fifo_rd(I),
                       forward_fifo_dout  => forward_fifo_dout(I),
                       sender_id          => sender_id(I),
                       new_sender_id      => new_sender_id(I),
                       error_sendTimeout  => err_hs_sendTimeout(I),
                       error_decoderCode  => err_hs_decoderCode(I),
                       error_decoderDisp  => err_hs_decoderDisp(I),
                       error_bufferFull   => err_hs_bufferFull(I),
                       error_brokenMsg    => err_hs_brokenMsg(I) );
    end generate;

    NDLComLS_Ports : for I in NUMBER_OF_HS_PORTS to NUMBER_OF_HS_PORTS+NUMBER_OF_LS_PORTS-1 generate
        NDLComLS_Port : entity work.NDLComLS
            generic map ( CLK_FREQ      => CLK_FREQ,
                          BAUD_RATE     => LS_BAUD_RATE,
                          STORE_FORWARD => true )
            port map ( CLK                => CLK,
                       RST                => RST,
                       NODE_ID            => NODE_ID,
                       TX                 => ls_tx(I-NUMBER_OF_HS_PORTS),
                       RX                 => ls_rx(I-NUMBER_OF_HS_PORTS),
                       txData_sim  => ls_txData,
                       txReady_sim => ls_txReady,
                       startTx_sim => ls_startTx,
                       rxData_sim  => ls_rxData,
                       newData_sim => ls_newData,
                       dataAck_sim => ls_dataAck,
                       rxErr_sim   => ls_rxErr,
                       send_fifo_ready    => send_fifo_ready(I),
                       send_fifo_wr       => send_fifo_wr(I),
                       send_fifo_din      => send_fifo_din(I),
                       receive_fifo_empty => receive_fifo_empty(I),
                       receive_fifo_rd    => receive_fifo_rd(I),
                       receive_fifo_dout  => receive_fifo_dout(I),
                       forward_fifo_empty => forward_fifo_empty(I),
                       forward_fifo_rd    => forward_fifo_rd(I),
                       forward_fifo_dout  => forward_fifo_dout(I),
                       sender_id          => sender_id(I),
                       new_sender_id      => new_sender_id(I),
                       error_uartRx       => err_ls_uartRx(I-NUMBER_OF_HS_PORTS),
                       error_bufferFull   => err_ls_bufferFull(I-NUMBER_OF_HS_PORTS),
                       error_brokenMsg    => err_ls_brokenMsg(I-NUMBER_OF_HS_PORTS) );
    end generate;

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

    -- check if a new message could be send by checking the remaining
    -- size of the send fifo and the signal from the readInputMonitor
    readyToSend <= '0' when inputBufferReady = '0' or startSending = '1' or
                   unsigned(output_fifo_remaining) < MAX_PACKET_SIZE
                   else '1';

    -- ------------------------------------ --
    -- process that handles and encodes the --
    -- data stream which should be send     --
    -- ------------------------------------ --
    encoder : process (CLK)
        variable byteCounter   : integer range 0 to 255;
        variable escapeFlag    : std_logic;
        variable outputData    : std_logic;
        variable forwardData   : std_logic;
        variable readNextInput : std_logic;
        variable inputFifo     : std_logic_vector(15 downto 0);
        variable escapeFifo    : std_logic_vector(1 downto 0);
        variable actualByte    : std_logic_vector(7 downto 0);
        variable crcByte      : std_logic_vector(7 downto 0);
    begin
        if CLK = '1' and CLK'event then

            if RST = '1' then
                byteCounter   := 0;
                escapeFlag    := '0';
                outputData    := '0';
                forwardData   := '0';
                readNextInput := '0';
                inputFifo     := (others => '0');
                escapeFifo    := (others => '0');
                actualByte    := (others => '0');
                crcByte       := (others => '0');

                crc_i_s.crc_gen_reset        <= '1';
                crc_i_s.crc_gen_buf_new_byte <= '0';

                output_fifo_din    <= (others => '0');
                output_fifo_wr     <= '0';
                input_mem_addr_out <= (others => '0');

                inputBufferReady <= '1';

                encoderState <= idle;

            else
                -- defaults
                output_fifo_wr <= '0';
                crc_i_s.crc_gen_reset        <= '0';
                crc_i_s.crc_gen_buf_new_byte <= '0';

                -- prefetching of the next input bytes to enable
                -- writing a byte per cycle into output buffer
                -- (incl. last bytes for resyncing on escape bytes)
                -- -> inputFifo(15 downto 8)  : actual byte
                --    inputFifo(7 downto 0)   : next byte (for crc-calc)
                inputFifo := inputFifo(7 downto 0) & input_mem_data_out;
                if readNextInput = '1' then
                    readNextInput      := '0';
                    input_mem_addr_out <= incr_f(input_mem_addr_out);
                end if;
                
                -- when a byte was escaped we have to use old
                -- input bytes before resyncing
                -- (for the actual data byte use old crc byte)
                escapeFifo := escapeFifo(0) & escapeFlag;
                actualByte := crc_i_s.crc_gen_buf;
                if escapeFifo(1 downto 0) /= "00" then
                    crcByte := inputFifo(15 downto 8);
                else
                    crcByte := inputFifo(7 downto 0);
                end if;

                -- start of state machine
                case encoderState is

                    when idle =>
                        if startSending = '1' then
                            inputBufferReady <= '0';
                            encoderState   <= writeStartFlag;
                        else
                            encoderState <= idle;
                        end if;

                    when writeStartFlag =>
                        -- write the start flag
                        byteCounter        := 0;
                        escapeFlag         := '0';
                        input_mem_addr_out <= (others => '0');

                        output_fifo_din <= FLAG_BYTE;
                        output_fifo_wr  <= '1';

                        -- write first header byte into crc-calc
                        crc_i_s.crc_gen_buf_new_byte <= '1';
                        crc_i_s.crc_gen_buf <= sendHeader(0);

                        encoderState <= writeHeaderByte;

                    when writeHeaderByte =>
                        if (sendHeader(byteCounter) = FLAG_BYTE or
                            sendHeader(byteCounter) = ESCAPE_BYTE) and escapeFlag='0' then
                            -- escape actual header byte
                            escapeFlag      := '1';
                            output_fifo_din <= ESCAPE_BYTE;
                            output_fifo_wr  <= '1';
                            encoderState    <= writeHeaderByte;
                        else
                            -- write actual header byte
                            if escapeFlag = '1' then
                                output_fifo_din <= sendHeader(byteCounter) xor x"20";
                            else
                                output_fifo_din <= sendHeader(byteCounter);
                            end if;
                            output_fifo_wr <= '1';
                            escapeFlag     := '0';

                            -- write next byte into crc-calc
                            crc_i_s.crc_gen_buf_new_byte <= '1';
                            if byteCounter = 3 then
                                crc_i_s.crc_gen_buf <= crcByte;
                            else
                                crc_i_s.crc_gen_buf <= sendHeader(byteCounter+1);
                            end if;

                            -- start prefetching of input bytes
                            -- (only if not escaping)
                            if byteCounter > 0 then
                                readNextInput := '1';
                            end if;

                            if byteCounter < HEADER_LENGTH-1 then
                                byteCounter    := byteCounter + 1;
                                encoderState <= writeHeaderByte;
                            else
                                if sendHeader(byteCounter) = x"00" then
                                    -- length=0 -> no data to be written
                                    encoderState <= writeCRCLowerByte;
                                else
                                    byteCounter    := 0;
                                    encoderState <= writeData;
                                end if;
                            end if;
                        end if;

                    when writeData =>
                        if (actualByte = FLAG_BYTE or
                            actualByte = ESCAPE_BYTE) and escapeFlag='0' then
                            -- escape the actual data byte
                            escapeFlag      := '1';
                            output_fifo_din <= ESCAPE_BYTE;
                            output_fifo_wr  <= '1';
                            encoderState    <= writeData;
                        else
                            -- write the actual data byte
                            if escapeFlag = '1' then
                                output_fifo_din <= actualByte xor x"20";
                            else
                                output_fifo_din <= actualByte;
                            end if;
                            output_fifo_wr <= '1';
                            escapeFlag     := '0';

                            if byteCounter+1 >= to_integer(unsigned(sendLength)) then
                                encoderState <= writeCRCLowerByte;
                            else
                                -- write next byte into crc-calc
                                crc_i_s.crc_gen_buf_new_byte <= '1';
                                crc_i_s.crc_gen_buf <= crcByte;

                                -- prefetch the next byte
                                -- (only when not escaping)
                                readNextInput := '1';

                                byteCounter    := byteCounter + 1;
                                encoderState <= writeData;
                            end if;
                        end if;

                    when writeCRCLowerByte =>
                        if (crc_o_s.crc_gen_value(7 downto 0) = FLAG_BYTE or
                            crc_o_s.crc_gen_value(7 downto 0) = ESCAPE_BYTE) and escapeFlag='0' then
                            -- escape actual crc byte
                            escapeFlag      := '1';
                            output_fifo_din <= ESCAPE_BYTE;
                            output_fifo_wr  <= '1';
                            encoderState    <= writeCRCLowerByte;
                        else
                            -- write actual crc byte
                            if escapeFlag = '1' then
                                output_fifo_din <= crc_o_s.crc_gen_value(7 downto 0) xor X"20";
                            else
                                output_fifo_din <= crc_o_s.crc_gen_value(7 downto 0);
                            end if;
                            output_fifo_wr <= '1';
                            escapeFlag     := '0';
                            encoderState   <= writeCRCUpperbyte;
                        end if;

                    when writeCRCUpperByte =>
                        if (crc_o_s.crc_gen_value(15 downto 8) = FLAG_BYTE or
                            crc_o_s.crc_gen_value(15 downto 8) = ESCAPE_BYTE) and escapeFlag='0' then
                            -- escape actual crc byte
                            escapeFlag      := '1';
                            output_fifo_din <= ESCAPE_BYTE;
                            output_fifo_wr  <= '1';
                            encoderState    <= writeCRCUpperByte;
                        else
                            -- write actual crc byte
                            if escapeFlag = '1' then
                                output_fifo_din <= crc_o_s.crc_gen_value(15 downto 8) xor X"20";
                            else
                                output_fifo_din <= crc_o_s.crc_gen_value(15 downto 8);
                            end if;
                            output_fifo_wr <= '1';
                            escapeFlag     := '0';
                            encoderState   <= writeStopFlag;
                        end if;

                    when writeStopFlag =>
                        -- write the stop flag
                        crc_i_s.crc_gen_reset <= '1';
                        output_fifo_din  <= FLAG_BYTE;
                        output_fifo_wr   <= '1';
                        inputBufferReady <= '1';
                        encoderState     <= idle;
                        
                end case;
            end if;
        end if;
    end process;
----
----    -- ------------------------------------- --
----    -- process that checks the receive fifos --
----    -- and decodes incoming data stream      --
----    -- ------------------------------------- --
    decoder : process (clk)
        variable actualPort     : natural;
        variable break_loop     : std_logic;
        variable escapeFlag     : std_logic;
        variable headerCounter  : integer range 0 to HEADER_LENGTH-1;
        variable crc_recv_value : std_logic_vector(15 downto 0);
    begin
        if clk = '1' and clk'event then

            if rst = '1' then
                actualPort     := 0;
                break_loop     := '0';
                escapeFlag     := '0';
                headerCounter  := 0;
                crc_recv_value := (others => '0');
                
                crc_i_s.crc_check_buf_new_byte <= '0';
                crc_i_s.crc_check_reset        <= '1';

                receive_fifo_rd     <= (others => '0');
                output_mem_addr_in  <= (others => '0');
                output_mem_wea      <= "0";
                output_mem_data_in  <= (others => '0');

                for i in 0 to HEADER_LENGTH-1 loop
                    recvHeader(i) <= (others => '0');
                end loop;

                err_decode   <= '0';
                dataTrigger  <= '0';

                decoderState <= checkFifos;

            else
                -- defaults
                crc_i_s.crc_check_buf_new_byte <= '0';
                crc_i_s.crc_check_reset        <= '0';
                output_mem_wea    <= "0";
                err_decode  <= '0';
                dataTrigger <= '0';
                
                -- one idle cycle after setting the rd-flag to
                -- get the next data at the receive fifo output
                -- (todo: this could be optimized)
                if receive_fifo_rd(actualPort)='1' then
                    receive_fifo_rd <= (others => '0');
                else

                    if decoder_timeout='1' then
                        err_decode   <= '1';
                        decoderState <= checkFifos;
                    else
                        
                        case decoderState is

                            when checkFifos =>
                                -- check receive fifos and if a fifo
                                -- is not empty start reading it
                                break_loop := '0';
                                escapeFlag := '0';
                                for I in 0 to NUMBER_OF_PORTS-1 loop
                                    if break_loop='0' and receive_fifo_empty(I)='0' then
                                        break_loop   := '1';
                                        actualPort   := I;
                                        decoderState <= readStartFlag;
                                    end if;
                                end loop;

                            when readStartFlag =>
                                -- at first position in the fifo there
                                -- should be a flag byte
                                if receive_fifo_empty(actualPort)='0' then
                                    receive_fifo_rd(actualPort) <= '1';
                                    
                                    if receive_fifo_dout(actualPort) = FLAG_BYTE then
                                        -- we received a flag byte
                                        -- this should be the start of a message
                                        crc_i_s.crc_check_buf   <= (others => '0');
                                        crc_i_s.crc_check_reset <= '1';
                                        escapeFlag   := '0';
                                        decoderState <= readReceiverId;
                                    else
                                        -- no start flag
                                        err_decode   <= '1';
                                        decoderState <= checkFifos;
                                    end if;
                                end if;

                            when readReceiverId =>
                                -- double check the receiver id
                                -- (normally there should be only messages
                                -- for this node in the receive buffers)
                                if receive_fifo_empty(actualPort)='0' then
                                    receive_fifo_rd(actualPort) <= '1';

                                    -- initialize counters and others stuff
                                    headerCounter      := 1;
                                    output_mem_addr_in <= (others => '1');

                                    if receive_fifo_dout(actualPort) = FLAG_BYTE then
                                        -- here shouldn't be a flag byte
                                        -- (the actual message is broken)
                                        --err_decode   <= '1';  -- todo: here is a bug !?
                                        decoderState <= readReceiverId;

                                    elsif receive_fifo_dout(actualPort) = ESCAPE_BYTE then
                                        -- next byte is escaped
                                        escapeFlag   := '1';
                                        decoderState <= readReceiverId;

                                    elsif (escapeFlag = '0' and receive_fifo_dout(actualPort) = NODE_ID) or
                                        (escapeFlag = '1' and (receive_fifo_dout(actualPort) xor x"20") = NODE_ID) or
                                        (escapeFlag = '0' and receive_fifo_dout(actualPort) = BROADCAST_ID) or
                                        (escapeFlag = '1' and (receive_fifo_dout(actualPort) xor x"20") = BROADCAST_ID) then
                                        -- message is for this node -> receive it
                                        crc_i_s.crc_check_buf_new_byte <= '1';
                                        if escapeFlag = '1' then
                                            recvHeader(0)         <= receive_fifo_dout(actualPort) xor x"20";
                                            crc_i_s.crc_check_buf <= receive_fifo_dout(actualPort) xor x"20";
                                        else
                                            recvHeader(0)         <= receive_fifo_dout(actualPort);
                                            crc_i_s.crc_check_buf <= receive_fifo_dout(actualPort);
                                        end if;
                                        escapeFlag   := '0';
                                        decoderState <= readHeaderByte;

                                    else
                                        -- message is not for this node (this should not happen!)
                                        -- -> wait for the next message
                                        err_decode   <= '1';
                                        decoderState <= checkFifos;
                                    end if;
                                else
                                    decoderState <= readReceiverId;
                                end if;

                            when readHeaderByte =>
                                -- receive remaining header bytes
                                -- (without receiver ID byte)
                                if receive_fifo_empty(actualPort)='0' then
                                    receive_fifo_rd(actualPort) <= '1';

                                    if receive_fifo_dout(actualPort) = ESCAPE_BYTE then
                                        -- next byte is escaped
                                        escapeFlag   := '1';
                                        decoderState <= readHeaderByte;

                                    elsif receive_fifo_dout(actualPort) = FLAG_BYTE then
                                        -- here shouldn't be a flag byte
                                        -- (the actual message is broken)
                                        err_decode   <= '1';
                                        decoderState <= readReceiverId;

                                    else
                                        -- receive next header byte
                                        crc_i_s.crc_check_buf_new_byte <= '1';
                                        if escapeFlag = '1' then
                                            recvHeader(headerCounter) <= receive_fifo_dout(actualPort) xor x"20";
                                            crc_i_s.crc_check_buf     <= receive_fifo_dout(actualPort) xor x"20";
                                        else
                                            recvHeader(headerCounter) <= receive_fifo_dout(actualPort);
                                            crc_i_s.crc_check_buf     <= receive_fifo_dout(actualPort);
                                        end if;
                                        escapeFlag := '0';

                                        if headerCounter < HEADER_LENGTH-1 then
                                            headerCounter := headerCounter + 1;
                                            decoderState  <= readHeaderByte;
                                        else
                                        -- header in complete -> go on
                                            if (escapeFlag = '0' and receive_fifo_dout(actualPort) = x"00") or
                                                (escapeFlag = '1' and (receive_fifo_dout(actualPort) xor x"20") = x"00") then
                                        -- length=0 -> no payload
                                                decoderState <= readCRCLowerByte;
                                            else
                                                decoderState <= readData;
                                            end if;
                                        end if;

                                    end if;
                                else
                                    decoderState <= readHeaderByte;
                                end if;

                            when readData =>
                                -- receive data bytes
                                if receive_fifo_empty(actualPort)='0' then
                                    receive_fifo_rd(actualPort) <= '1';

                                    if receive_fifo_dout(actualPort) = ESCAPE_BYTE then
                                        -- next byte is escaped
                                        escapeFlag   := '1';
                                        decoderState <= readData;

                                    elsif receive_fifo_dout(actualPort) = FLAG_BYTE then
                                        -- here shouldn't be a flag byte
                                        -- (the actual message is broken)
                                        err_decode   <= '1';
                                        decoderState <= readReceiverId;

                                    else
                                        -- receive next data byte
                                        crc_i_s.crc_check_buf_new_byte <= '1';
                                        if escapeFlag = '1' then
                                            output_mem_data_in    <= receive_fifo_dout(actualPort) xor x"20";
                                            crc_i_s.crc_check_buf <= receive_fifo_dout(actualPort) xor x"20";
                                        else
                                            output_mem_data_in    <= receive_fifo_dout(actualPort);
                                            crc_i_s.crc_check_buf <= receive_fifo_dout(actualPort);
                                        end if;
                                        output_mem_addr_in <= incr_f(output_mem_addr_in);
                                        output_mem_wea     <= "1";
                                        escapeFlag         := '0';

                                        if unsigned(output_mem_addr_in)+2 >= unsigned(recvHeader(headerCounter)) then
                                            decoderState <= readCRCLowerByte;
                                        else
                                            decoderState <= readData;
                                        end if;
                                        
                                    end if;
                                else
                                    decoderState <= readData;
                                end if;

                            when readCRCLowerByte =>
                                if receive_fifo_empty(actualPort)='0' then
                                    receive_fifo_rd(actualPort) <= '1';

                                    if receive_fifo_dout(actualPort) = ESCAPE_BYTE then
                                        -- next byte is escaped
                                        escapeFlag   := '1';
                                        decoderState <= readCRCLowerByte;

                                    elsif receive_fifo_dout(actualPort) = FLAG_BYTE then
                                        -- here shouldn't be a flag byte
                                        -- (the actual message is broken)
                                        err_decode   <= '1';
                                        decoderState <= readReceiverId;

                                    else
                                        if escapeFlag = '1' then
                                            crc_recv_value(7 downto 0) := receive_fifo_dout(actualPort) xor x"20";
                                        else
                                            crc_recv_value(7 downto 0) := receive_fifo_dout(actualPort);
                                        end if;
                                        escapeFlag := '0';
                                        decoderState <= readCRCUpperByte;
                                    end if;
                                else
                                    decoderState <= readCRCLowerByte;
                                end if;

                            when readCRCUpperByte =>
                                if receive_fifo_empty(actualPort)='0' then
                                    receive_fifo_rd(actualPort) <= '1';

                                    if receive_fifo_dout(actualPort) = ESCAPE_BYTE then
                                        -- next byte is escaped
                                        escapeFlag   := '1';
                                        decoderState <= readCRCUpperByte;
                                        
                                    elsif receive_fifo_dout(actualPort) = FLAG_BYTE then
                                        -- here shouldn't be a flag byte
                                        -- (the actual message is broken)
                                        err_decode   <= '1';
                                        decoderState <= readReceiverId;
                                        
                                    else
                                        if escapeFlag = '1' then
                                            crc_recv_value(15 downto 8) := receive_fifo_dout(actualPort) xor x"20";
                                        else
                                            crc_recv_value(15 downto 8) := receive_fifo_dout(actualPort);
                                        end if;
                                        escapeFlag := '0';
                                        
                                        -- check the checksum
                                        if crc_recv_value=crc_o_s.crc_check_value then
                                        -- Correct CRC -> trigger data output
                                            dataTrigger  <= '1';
                                        else
                                        -- wrong CRC
                                            err_decode <= '1';
                                        end if;

                                        decoderState <= readStopFlag;

                                    end if;
                                else
                                    decoderState <= readCRCUpperByte;
                                end if;

                            when readStopFlag =>
                                -- at the end of a message there
                                -- should be a flag byte, too
                                if receive_fifo_empty(actualPort)='0' then
                                    receive_fifo_rd(actualPort) <= '1';
                                    
                                    if receive_fifo_dout(actualPort) /= FLAG_BYTE then
                                        -- no stop flag
                                        err_decode <= '1';
                                    end if;
                                    decoderState <= checkFifos;
                                else
                                    decoderState <= readStopFlag;
                                end if;

                        end case;
                    end if;
                end if;
            end if;
        end if;
    end process;
----
----    -- timeout process which cancels receiving a message after
----    -- a certain amount of time (-> TIMEOUT_MS in NDLCom_config.vhd)
    decoder_timeoutProcess : process (CLK)
        variable timerState : timerState_t;
        variable timeoutCounter : integer range 0 to TIMEOUT_COUNTER_MAX;
    begin
        if CLK = '1' and CLK'event then
            if RST = '1' then
                timeoutCounter  := 0;
                decoder_timeout <= '0';

                timerState := idle;
            else
                -- default
                decoder_timeout <= '0';

                case timerState is

                    when idle =>
                        if to_integer(unsigned(receive_fifo_rd))/=0 then
                            timeoutCounter := 0;
                            timerState     := active;
                        end if;

                    when active =>
                        if to_integer(unsigned(receive_fifo_rd))/=0 then
                            timeoutCounter := 0;
                        elsif decoderState=checkFifos then
                            timerState := idle;
                        else
                            if timeoutCounter < TIMEOUT_COUNTER_MAX then
                                timeoutCounter := timeoutCounter + 1;
                            else
                                decoder_timeout <= '1';
                                timerState := idle;
                            end if;
                        end if;

                end case;
            end if;
        end if;
    end process;
----
----    -- ------------------------ --
----    -- process that handles the --
----    -- rx hand shake            --
----    -- ------------------------ --
    newData <= newData_int and not dataAck;

    rxHandShakeHandler : process (clk)
    begin
        if clk'event and clk='1' then
            if rst = '1' then
                newData_int      <= '0';
                rxHandShakeState <= idle;
            else

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
        end if;
    end process;

----
----    -----------------------------------------------------------------------------------------------------------------------------------------
----
    RoutingTableUpdater : process (clk)
    begin
        if clk'event and clk='1' then
            if rst='1' then
                -- initialize routing table with invalid port -> broadcast
                routingTable <= (others => NUMBER_OF_PORTS);
            else
                for I in 0 to NUMBER_OF_PORTS-1 loop
                    if new_sender_id(I)='1' then
                        routingTable(to_integer(unsigned(sender_id(I)))) <= I;
                    end if;
                end loop;
            end if;
        end if;
    end process;
-----------------------------------------------------------------------------------------------------------    
    ForwardDEMUXs : for G in 0 to NUMBER_OF_PORTS generate

        forward_data(G)   <= forward_tmp_data(G) when forward_tmp_valid(G)='1' else forward_fifo_dout(G);
        forward_active(G) <= '1' when forward_tmp_valid(G)='1' or (forward_data_valid(G)='1' and forward_fifo_empty(G)='0') else '0';
        
        ForwardDEMUX : process (clk)
            variable idleFlag     : std_logic;
            variable escapeFlag   : std_logic;
            variable receiverId   : std_logic_vector(7 downto 0);
            variable actualTxPort : integer range 0 to NUMBER_OF_PORTS;
            variable broadcast_acks : std_logic_vector(NUMBER_OF_PORTS downto 0);
            variable got_broadcast_acks : std_logic;
           -- variable demuxState   : demuxStates;
        begin
            if clk'event and clk='1' then
                if rst='1' then
                    idleFlag     := '0';
                    escapeFlag   := '0';
                    receiverId   := (others => '0');
                    actualTxPort := 0;
                    broadcast_acks := (others => '0');
                    got_broadcast_acks := '0';

                    forward_fifo_rd(G)    <= '0';
                    forward_request(G)    <= (others => '0');
                    broadcast_request(G)  <= '0';
                    forward_data_valid(G) <= '0';
                    forward_tmp_valid(G)  <= '0';
                    startDemuxTimer(G) <= '0';
                    err_demux(G)  <= '0';

                    demuxState(G) <= readStartFlag;
                else
                   --  defaults
                    forward_fifo_rd(G)     <= '0';
                    forward_data_valid(G)  <= '0';
                    forward_tmp_valid(G)   <= '0';
                    startDemuxTimer(G) <= '0';
                    err_demux(G)  <= '0';

                    if demux_timeout(G)='1' then
                        err_demux(G)         <= '1';
                        forward_request(G)   <= (others => '0');
                        broadcast_request(G) <= '0';
                        idleFlag      := '0';
                        escapeFlag    := '0';
                        demuxState(G) <= readStartFlag;
                    elsif idleFlag='1' then
                        idleFlag := '0';
                    else

                        case demuxState(G) is

                            when readStartFlag =>
                             --    wait for a start flag
                                if forward_fifo_empty(G)='0' then
                                    forward_fifo_rd(G) <= '1';
                                    idleFlag := '1';

                                    if forward_fifo_dout(G) = FLAG_BYTE then
                                     --    a flag byte
                                      --   this should be a start of a message
                                        escapeFlag := '0';
                                        startDemuxTimer(G) <= '1';
                                        demuxState(G) <= readReceiverId;
                                    end if;
                                end if;

                            when readReceiverId =>
                                -- read the receiver id and lookup the
                               --  port where to forward it
                                if forward_fifo_empty(G)='0' then
                                    forward_fifo_rd(G) <= '1';
                                if forward_fifo_dout(G) = FLAG_BYTE then
--                                         last byte was not the start flag
--                                         perhaps this one
                                        idleFlag   := '1';
                                        escapeFlag := '0';
                                        demuxState(G) <= readReceiverId;
                                        
                                    elsif forward_fifo_dout(G) = ESCAPE_BYTE then
                                 --        next byte is escaped
                                        idleFlag   := '1';
                                        escapeFlag := '1';
                                        demuxState(G) <= readReceiverId;
                                        
                                    else
                                        if escapeFlag='1' then
                                            receiverId := forward_fifo_dout(G) xor x"20";
                                        else
                                            receiverId := forward_fifo_dout(G);
                                        end if;
                                        actualTxPort := routingTable(to_integer(unsigned(receiverId)));

                                        -- check if we should broadcast the message
                                        if receiverId = BROADCAST_ID or          -- broadcast requested
                                            actualTxPort > NUMBER_OF_PORTS-1 or  -- uninitialized routing table
                                            actualTxPort = G then                -- invalid routing table entry
                                            demuxState(G) <= broadcast_setRequest1;
                                        else
                                        --     no broadcast
                                            forward_request(G)(actualTxPort) <= '1';
                                            demuxState(G) <= waitAck;
                                        end if;
                                    end if;
                                end if;

                            when waitAck =>
                                if forward_ack(actualTxPort)(G)='1' then
                                    demuxState(G) <= writeStartFlag;
                                end if;

                            when broadcast_setRequest1 =>
                                if to_integer(unsigned(broadcast_request))=0 then
                                    broadcast_request(G) <= '1';
                                    demuxState(G) <= broadcast_setRequest2;
                                else
                                    broadcast_request(G) <= '0';
                                    demuxState(G) <= broadcast_setRequest1;
                                end if;
                                
                            when broadcast_setRequest2 =>
--                                 check if all other processes with smaller index
--                                 don't want to broadcast, too
--                                 todo: check if this could be done round-robin
                                if to_integer(unsigned(broadcast_request(G-1 downto 0)))=0 then
                                   --  broadcast if requested or tx-port is unknown (NUMBER_OF_PORTS)
                                    forward_request(G)    <= (others => '1');
                                    if G /= NUMBER_OF_PORTS then
                                       --  don't send message back
                                        forward_request(G)(G) <= '0';
                                    end if;
                                    broadcast_acks := (others => '0');
                                    demuxState(G) <= broadcast_waitAck;
                                else
                                    broadcast_request(G) <= '0';
                                    demuxState(G) <= broadcast_setRequest1;
                                end if;

                            when broadcast_waitAck =>
                                broadcast_acks(G)  := '1';
                                got_broadcast_acks := '1';
                                for I in 0 to NUMBER_OF_PORTS-1 loop
                                    if forward_ack(I)(G)='1' then
                                        broadcast_acks(I) := '1';
                                    end if;
                                    if broadcast_acks(I) = '0' then
                                        got_broadcast_acks := '0';
                                    end if;
                                end loop;
                                if got_broadcast_acks = '1' then
                                    demuxState(G) <= writeStartFlag;
                                end if;

                            when writeStartFlag =>
                                forward_tmp_data(G)   <= FLAG_BYTE;
                                forward_tmp_valid(G)  <= '1';
                                demuxState(G) <= writeReceiverId;

                            when writeReceiverId =>
                                if escapeFlag='1' then
                                   --  receiver id was escaped
                                    escapeFlag := '0';
                                    forward_tmp_data(G)  <= ESCAPE_BYTE;
                                    forward_tmp_valid(G) <= '1';
                                    demuxState(G) <= writeReceiverId;
                                else
                                    if forward_tmp_data(G) = ESCAPE_BYTE then
                                        forward_tmp_data(G) <= receiverId xor x"20";
                                    else
                                        forward_tmp_data(G) <= receiverId;
                                    end if;
                                    forward_tmp_valid(G) <= '1';
                                    demuxState(G) <= forwardData;
                                end if;

                            when forwardData =>
--                                 in this state bytes from forward fifo
--                                 will be written in the corresponding
--                                 send fifo from the forward mux process
--                                 until the end flag will be read
                                if forward_fifo_dout(G) = FLAG_BYTE then
                                  --   this should be the end of the message
                                    forward_fifo_rd(G)    <= '0';
                                    forward_data_valid(G) <= '0';
                                    forward_request(G)    <= (others => '0');
                                    broadcast_request(G)  <= '0';
                                    demuxState(G) <= readStartFlag;
                                else
                                    forward_fifo_rd(G)    <= '1';
                                    forward_data_valid(G) <= '1';
                                    demuxState(G) <= forwardData;
                                end if;

                        end case;
                    end if;
                end if;
            end if;
        end process;

--         timeout process which cancels sending a message after
--         a certain amount of time (-> TIMEOUT_MS in NDLCom_config.vhd)
        demux_timeoutProcess : process (CLK)
            variable timeoutCounter : integer range 0 to TIMEOUT_COUNTER_MAX;
            variable timerState : timerState_t;
        begin
            if CLK = '1' and CLK'event then
                if RST = '1' then
                    timeoutCounter   := 0;
                    demux_timeout(G) <= '0';
                    timerState := idle;
                else
                    -- default
                    demux_timeout(G) <= '0';

                    case timerState is

                        when idle =>
                            if startDemuxTimer(G)='1' then
                                timeoutCounter := 0;
                                timerState     := active;
                            end if;

                        when active =>
                            if startDemuxTimer(G)='1' then
                                timeoutCounter := 0;
                            elsif demuxState(G) = readStartFlag then
                                timerState := idle;
                            else
                                if timeoutCounter < TIMEOUT_COUNTER_MAX then
                                    timeoutCounter   := timeoutCounter + 1;
                                else
                                    demux_timeout(G) <= '1';
                                    timerState := idle;
                                end if;
                            end if;

                    end case;
                end if;
            end if;
        end process;
    end generate;
--
    ForwardMUXs : for G in 0 to NUMBER_OF_PORTS-1 generate
        ForwardMUX : process (clk)
            variable actualRxPort : integer range 0 to NUMBER_OF_PORTS;
            variable lastRxPort   : integer range 0 to NUMBER_OF_PORTS;
            variable break_loop   : std_logic;
            --variable muxState     : muxStates;
        begin
            if clk'event and clk='1' then
                if rst='1' then
                    actualRxPort := 0;
                    lastRxPort   := 0;
                    break_loop   := '0';
                    
                    send_fifo_wr(G)  <= '0';
                    send_fifo_din(G) <= (others => '0');
                    forward_ack(G)   <= (others => '0');
                    
                    muxState(G) <= waitRequest;
                else
                    -- defaults
                    send_fifo_wr(G) <= '0';
                    forward_ack(G)   <= (others => '0');

                    case muxState(G) is

                        when waitRequest =>
                            break_loop := '0';
                            lastRxPort := actualRxPort;
                            for I in 0 to NUMBER_OF_PORTS loop
                                if lastRxPort < NUMBER_OF_PORTS then
                                    lastRxPort := lastRxPort + 1;
                                else
                                    lastRxPort := 0;
                                end if;
                                if break_loop='0' and forward_request(lastRxPort)(G)='1' and send_fifo_ready(G)='1' then
                                    break_loop := '1';
                                    actualRxPort := lastRxPort;
                                    forward_ack(G)(actualRxPort) <= '1';
                                    muxState(G) <= writeData;
                                end if;
                            end loop;

                        when writeData =>
                            lastRxPort := actualRxPort;
                            if forward_active(actualRxPort)='1' then
                                send_fifo_din(G) <= forward_data(actualRxPort);
                                send_fifo_wr(G)  <= '1';
                            end if;
                            if forward_request(actualRxPort)(G)='0' then
                                muxState(G) <= waitRequest;
                            else
                                muxState(G) <= writeData;
                            end if;

                    end case;

                end if;
            end if;
        end process;
    end generate;

end Behavioral;
