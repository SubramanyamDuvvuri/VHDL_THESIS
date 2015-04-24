---------------------------------------------------------------------------------
--! @file   NDLComLS.vhd
--! @author Tobias Stark (tobias.stark@dfki.de)
--! @date   22.01.2015
--!
--! @brief  Module for NDLCom with a normal communication interface.
--!
--! Module for NDLCom with a normal communication interface.\n\n
--!
--! German Research Center for Artificial Intelligence
---------------------------------------------------------------------------------
-- Last Commit: 
-- $LastChangedRevision: 3851 $
-- $LastChangedBy: tstark $
-- $LastChangedDate: 2015-03-06 09:37:05 +0100 (Fri, 06 Mar 2015) $
---------------------------------------------------------------------------------
library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.NDLCom_config.all;

--library Spartan6;
--use Spartan6.asynch_sercomm_config_pack.all;

entity NDLComLS is
    generic ( CLK_FREQ      : integer := 16000000; --! the system clock (in Hz)
              BAUD_RATE     : integer := 115200;   --! the baud rate of this uart
              STORE_FORWARD : boolean := false );  --! use store and forward (true) instead of cut-through forwarding (false)
    port (
        CLK     : in std_logic;                     --! system clock (aka clkCommInterface)
        RST     : in std_logic;                     --! system reset
        NODE_ID : in std_logic_vector(7 downto 0);  --! the id of this node

        TX      : out std_logic;                    --! Tx port
        RX      : in  std_logic;                    --! Rx port

        -- ----------------- --
        --       DEBUG       --
        -- ----------------- --
        txData_sim  : out std_logic_vector(7 downto 0);
        txReady_sim : in  std_logic;
        startTx_sim : out std_logic;
        rxData_sim  : in  std_logic_vector(7 downto 0);
        newData_sim : in  std_logic;
        dataAck_sim : out std_logic;
        rxErr_sim   : in  std_logic;

        -- send fifo
        send_fifo_ready : out std_logic;                    --! ready signal of the send fifo
        send_fifo_wr    : in  std_logic;                    --! write signal of the send fifo
        send_fifo_din   : in  std_logic_vector(7 downto 0); --! data in of the send fifo

        -- receive fifo
        receive_fifo_empty : out std_logic;                    --! empty signal for the receive fifo
        receive_fifo_rd    : in  std_logic;                    --! read signal for the receive fifo
        receive_fifo_dout  : out std_logic_vector(7 downto 0); --! data out of the receive fifo

        -- forward fifo
        forward_fifo_empty : out std_logic;                    --! empty signal for the forward fifo
        forward_fifo_rd    : in  std_logic;                    --! read signal for the forward fifo
        forward_fifo_dout  : out std_logic_vector(7 downto 0); --! data out of the forward fifo

        -- signals to update routing table
        sender_id     : out std_logic_vector(7 downto 0);
        new_sender_id : out std_logic;

        -- error signals
        error_uartRx      : out std_logic;
        error_bufferFull  : out std_logic;
        error_brokenMsg   : out std_logic );
end NDLComLS;

architecture Behavioral of NDLComLS is

    type Array3x8 is array(0 to 2) of std_logic_vector(7 downto 0);

    signal send_fifo_rd        : std_logic;
    signal send_fifo_dout      : std_logic_vector(7 downto 0);
    signal send_fifo_empty     : std_logic;
    signal send_fifo_remaining : std_logic_vector(MEM_ADDR_WIDTH downto 0);

    signal receive_fifo_wr        : std_logic;
    signal receive_fifo_din       : std_logic_vector(7 downto 0);
    signal receive_fifo_full      : std_logic;
    signal receive_fifo_remaining : std_logic_vector(MEM_ADDR_WIDTH downto 0);
    
    signal forward_fifo_wr        : std_logic;
    signal forward_fifo_din       : std_logic_vector(7 downto 0);
    signal forward_fifo_full      : std_logic;
    signal forward_fifo_remaining : std_logic_vector(MEM_ADDR_WIDTH downto 0);
    signal forward_fifo_empty_int : std_logic;
    signal forward_msg_available  : std_logic;

    signal txReady : std_logic;
    signal startTx : std_logic;
    signal txData  : std_logic_vector(7 downto 0);

    signal rxData  : std_logic_vector(7 downto 0);
    signal newData : std_logic;
    signal dataAck : std_logic;
    signal rxErr   : std_logic;

    type receiveStates is (receiveStartFlag, receiveReceiverId,
                           receiveSenderId, receiveData);
    signal receiveState : receiveStates;

    type forwardStates is (readReceiverId, waitAck, readData);
    signal forwardState : forwardStates;

    signal error_bufferFull_int : std_logic;
    signal readyToReceive : std_logic;

    signal startTx_int : std_logic;

begin

    -- check if a new message could be send by
    -- checking the remaining size of the send fifo
    send_fifo_ready <= '0' when unsigned(send_fifo_remaining) < MAX_PACKET_SIZE else '1';

    error_bufferFull <= '1' when error_bufferFull_int='1' or readyToReceive='0' else '0';

    readyToReceive <= '0' when unsigned(receive_fifo_remaining) < MAX_PACKET_SIZE or
                      unsigned(forward_fifo_remaining) < MAX_PACKET_SIZE
                      else '1';

    forward_fifo_empty <= forward_fifo_empty_int when STORE_FORWARD=false else
                          not forward_msg_available or forward_fifo_empty_int;

    -- send fifo (1024 bytes)
    send_fifo : entity work.fast_fifo
        generic map ( ADDRWIDTH => MEM_ADDR_WIDTH,
                      DATAWIDTH => 8 )
        port map ( clk   => clk,
                   rst   => rst,
                   wr    => send_fifo_wr,
                   din   => send_fifo_din,
                   rd    => send_fifo_rd,
                   dout  => send_fifo_dout,
                   empty => send_fifo_empty,
                   full  => open,
                   remaining => send_fifo_remaining );

    -- receive fifo (1024 bytes)
    receive_fifo : entity work.fast_fifo
        generic map ( ADDRWIDTH => MEM_ADDR_WIDTH,
                      DATAWIDTH => 8 )
        port map ( clk   => clk,
                   rst   => rst,
                   wr    => receive_fifo_wr,
                   din   => receive_fifo_din,
                   rd    => receive_fifo_rd,
                   dout  => receive_fifo_dout,
                   empty => receive_fifo_empty,
                   full  => receive_fifo_full,
                   remaining => receive_fifo_remaining );

    -- forward fifo (1024 bytes)
    forward_fifo : entity work.fast_fifo
        generic map ( ADDRWIDTH => MEM_ADDR_WIDTH,
                      DATAWIDTH => 8 )
        port map ( clk   => clk,
                   rst   => rst,
                   wr    => forward_fifo_wr,
                   din   => forward_fifo_din,
                   rd    => forward_fifo_rd,
                   dout  => forward_fifo_dout,
                   empty => forward_fifo_empty_int,
                   full  => forward_fifo_full,
                   remaining => forward_fifo_remaining );

    sim : if SIMULATION=true generate
        txData_sim <= txData;
        txReady <= txReady_sim;
        startTx_sim <= startTx;
        rxData <= rxData_sim;
        newData <= newData_sim;
        dataAck_sim <= dataAck;
        rxErr <= rxErr_sim;
    end generate;
    
    re : if SIMULATION=false generate
        UART_inst : entity work.UART_mod
            generic map ( CLK_FREQ => CLK_FREQ,
                          BAUDRATE => BAUD_RATE )
            port map ( clk_i => clk,
                       rst_i => rst,
                       tx_o  => TX,
                       rx_i  => RX,
                       txData_i    => txData,
                       txReady_o   => txReady,
                       txStart_i   => startTx,
                       rxData_o    => rxData,
                       rxNewData_o => newData,
                       rxDataAck_i => dataAck,
                       rxErr_o     => rxErr );
    end generate;

    error_uartRx <= rxErr;

    -- -------------------------- --
    -- process that handles the   --
    -- outgoing data stream which --
    -- switches between the fifos --
    -- -------------------------- --
    txData <= send_fifo_dout;
    startTx <= startTx_int and not send_fifo_empty;
    
    sendMonitor : process (clk)
    begin
        if clk'event and clk='1' then
            if rst='1' then
                send_fifo_rd <= '0';
                startTx_int  <= '0';
                --txData       <= (others => '0');
            else
                -- defaults
                send_fifo_rd <= '0';
                startTx_int  <= '0';
                
                -- check fifo buffer and uart ready
                if send_fifo_empty='0' and txReady='1' then
                    send_fifo_rd <= '1';
                    startTx_int  <= '1';
                    --txData       <= send_fifo_dout;
                end if;
                
            end if;
        end if;
    end process;

    -- This process receives the incoming data stream and checks if the message
    -- should be received or forwarded or both and writes the data in the corresponding
    -- buffer(s).
    -- To be able to handle one data byte per clock cycle the first bytes (before
    -- receiver id) are buffered and then written in the correct buffer(s) (recv and/
    -- or forward).
    -- Additionally this process checks the sender id and outputs it. So an upper
    -- module can update a routing table.
	 
    receiveMonitor : process (clk)
        variable escapeFlag  : std_logic;
        variable receiveFlag : std_logic;
        variable forwardFlag : std_logic;
        variable receive_buffer_data    : Array3x8;
        variable receive_buffer_counter : natural range 0 to 3;
        variable forward_buffer_data    : Array3x8;
        variable forward_buffer_counter : natural range 0 to 3;
    begin
        if clk'event and clk='1' then
            if rst='1' then
                escapeFlag  := '0';
                receiveFlag := '0';
                forwardFlag := '0';
                receive_buffer_data    := (others => (others => '0'));
                receive_buffer_counter := 0;
                forward_buffer_data    := (others => (others => '0'));
                forward_buffer_counter := 0;

                receive_fifo_din <= (others => '0');
                receive_fifo_wr  <= '0';
                forward_fifo_din <= (others => '0');
                forward_fifo_wr  <= '0';
                forward_msg_available <= '0';
                dataAck <= '0';

                sender_id     <= (others => '0');
                new_sender_id <= '0';

                error_bufferFull_int <= '0';
                error_brokenMsg  <= '0';
                
                receiveState <= receiveStartFlag;
            else
                -- defaults
                receive_fifo_wr <= '0';
                forward_fifo_wr <= '0';
                dataAck         <= '0';
                new_sender_id   <= '0';
                error_brokenMsg  <= '0';

                if forward_fifo_empty_int='1' then
                    forward_msg_available <= '0';
                end if;

                -- first check for rxErr or buffer full!!
                if rxErr='1' or error_bufferFull_int='1' then
                    escapeFlag   := '0';
                    receiveFlag  := '0';
                    forwardFlag  := '0';
                    error_bufferFull_int <= '0';
                    receiveState <= receiveStartFlag;
                else

                    case receiveState is

                        when receiveStartFlag =>
                            if newData='1' and readyToReceive='1' then
                                dataAck <= '1';
                                
                                if rxData = FLAG_BYTE then
                                    -- we received a flag byte
                                    -- perhaps the start of a message
                                    escapeFlag   := '0';
                                    receiveState <= receiveReceiverId;
                                else
                                    error_brokenMsg <= '1';
                                    receiveState    <= receiveStartFlag;
                                end if;
                            else
                                receiveState <= receiveStartFlag;
                            end if;
                            
                        when receiveReceiverId =>
                            -- receive receiver id and check if this message
                            -- should be received or forwarded or both
                            if readyToReceive='0' then
                                -- skip the next message because
                                -- we are not ready to receive it
                                escapeFlag   := '0';
                                receiveFlag  := '0';
                                forwardFlag  := '0';
                                receiveState <= receiveStartFlag;
                                
                            elsif newData='1' then
                                dataAck <= '1';

                                if rxData = FLAG_BYTE then
                                    -- last byte was not the start flag
                                    -- perhaps this one
                                    escapeFlag   := '0';
                                    receiveFlag  := '0';
                                    forwardFlag  := '0';
                                    receiveState <= receiveReceiverId;

                                elsif rxData = ESCAPE_BYTE then
                                    -- next byte is escaped
                                    escapeFlag   := '1';
                                    receiveFlag  := '0';
                                    forwardFlag  := '0';
                                    receiveState <= receiveReceiverId;

                                elsif (escapeFlag = '0' and rxData = NODE_ID) or
                                    (escapeFlag = '1' and (rxData xor x"20") = NODE_ID) then
                                    -- message is for this node (receiving)
                                    receiveFlag  := '1';
                                    forwardFlag  := '0';
                                    receiveState <= receiveSenderId;

                                elsif (escapeFlag ='0' and rxData = BROADCAST_ID) or
                                    (escapeFlag = '1' and (rxData xor x"20") = BROADCAST_ID) then
                                    -- broadcast message (receiving and forwarding)
                                    receiveFlag  := '1';
                                    forwardFlag  := '1';
                                    receiveState <= receiveSenderId;

                                else
                                    -- message is not for this node (fowarding)
                                    receiveFlag  := '0';
                                    forwardFlag  := '1';
                                    receiveState <= receiveSenderId;
                                end if;

                                -- write first bytes into the corresponding buffers
                                if receiveFlag='1' then
                                    receive_buffer_data(0) := FLAG_BYTE;
                                    if escapeFlag='1' then
                                        receive_buffer_data(1) := ESCAPE_BYTE;
                                        receive_buffer_data(2) := rxData;
                                        receive_buffer_counter := 3;
                                    else
                                        receive_buffer_data(1) := rxData;
                                        receive_buffer_counter := 2;
                                    end if;
                                end if;
                                if forwardFlag='1' then
                                    forward_buffer_data(0) := FLAG_BYTE;
                                    if escapeFlag='1' then
                                        forward_buffer_data(1) := ESCAPE_BYTE;
                                        forward_buffer_data(2) := rxData;
                                        forward_buffer_counter := 3;
                                    else
                                        forward_buffer_data(1) := rxData;
                                        forward_buffer_counter := 2;
                                    end if;
                                end if;
                                escapeFlag := '0';
                                
                            else
                                receiveState <= receiveReceiverId;
                            end if;

                        when receiveSenderId =>
                            -- receive sender id to update the routing table
                            -- in the upper module correspondingly
                            if newData='1' then
                                dataAck <= '1';

                                if rxData = FLAG_BYTE then
                                    -- here shouldn't be a flag byte
                                    -- but perhaps this is a start of a message
                                    escapeFlag      := '0';
                                    error_brokenMsg <= '1';
                                    receiveState    <= receiveReceiverId;

                                else
                                    
                                    if receiveFlag='1' then
                                        receive_buffer_data(receive_buffer_counter) := rxData;
                                        receive_buffer_counter := receive_buffer_counter + 1;
                                    end if;
                                    
                                    if forwardFlag='1' then
                                        forward_buffer_data(forward_buffer_counter) := rxData;
                                        forward_buffer_counter := forward_buffer_counter + 1;
                                    end if;
                                    
                                    if rxData = ESCAPE_BYTE then
                                        -- next byte is escaped
                                        escapeFlag   := '1';
                                        receiveState <= receiveSenderId;
                                        
                                    else
                                        -- put sender id in output to update
                                        -- the routing table
                                        if escapeFlag='1' then
                                            sender_id <= rxData xor x"20";
                                        else
                                            sender_id <= rxData;
                                        end if;
                                        new_sender_id <= '1';
                                        escapeFlag    := '0';
                                        receiveState  <= receiveData;
                                    end if;
                                end if;
                            else
                                receiveState <= receiveSenderId;
                            end if;

                        when receiveData =>
                            -- receive the rest of the message
                            if newData='1' then
                                dataAck <= '1';

                                if receiveFlag='1' then
                                    receive_buffer_data(receive_buffer_counter) := rxData;
                                    receive_buffer_counter := receive_buffer_counter + 1;
                                end if;
                                
                                if forwardFlag='1' then
                                    forward_buffer_data(forward_buffer_counter) := rxData;
                                    forward_buffer_counter := forward_buffer_counter + 1;
                                end if;

                                if rxData = FLAG_BYTE then
                                    -- this should be the end of the message
                                    forward_msg_available <= '1';
                                    receiveState <= receiveReceiverId;
                                else
                                    receiveState <= receiveData;
                                end if;
                            else
                                receiveState <= receiveData;
                            end if;
                            
                    end case;

                    -- check, if data is available and if a buffer is
                    -- valid write it into the corresponding fifo
                    if receive_buffer_counter>0 then
                        if receive_fifo_full='1' then
                            error_bufferFull_int <= '1';
                        else
                            receive_fifo_din <= receive_buffer_data(0);
                            receive_fifo_wr  <= '1';
                            -- shift for next data
                            receive_buffer_data    := receive_buffer_data(1 to 2) & x"00";
                            receive_buffer_counter := receive_buffer_counter-1;
                        end if;
                    end if;
                    if forward_buffer_counter>0 then
                        if forward_fifo_full='1' then
                            error_bufferFull_int <= '1';
                        else
                            forward_fifo_din <= forward_buffer_data(0);
                            forward_fifo_wr  <= '1';
                            -- shift for next data
                            forward_buffer_data    := forward_buffer_data(1 to 2) & x"00";
                            forward_buffer_counter := forward_buffer_counter-1;
                        end if;
                    end if;

                end if;
            end if;
        end if;
    end process;

end Behavioral;
