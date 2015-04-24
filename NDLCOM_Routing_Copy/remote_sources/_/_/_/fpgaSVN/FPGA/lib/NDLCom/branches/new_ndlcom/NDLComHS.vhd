---------------------------------------------------------------------------------
--! @file   NDLComHS.vhd
--! @author Tobias Stark (tobias.stark@dfki.de)
--! @date   22.01.2015
--!
--! @brief  Module for NDLCom with HSCom.
--!
--! Module for NDLCom with HSCom.\n\n
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

library Spartan6;
use Spartan6.asynch_sercomm_config_pack.all;

entity NDLComHS is
    generic ( CLK_FREQ  : integer := 16000000 );    --! the system clock (in Hz)
    port (
        CLK     : in std_logic;                     --! system clock (aka clkCommInterface)
        RST     : in std_logic;                     --! system reset
        clkHalfDR        : in  std_logic;           --! Datarate/2, gclk network
        clkDoubleDR_ioce : in  std_logic;           --! Datarate/2, special ioce synchronisation network
        clkDoubleDR_io   : in  std_logic;           --! Datarate*2, BUFIO2 or BUFPLL Clock Region network
        NODE_ID : in std_logic_vector(7 downto 0);  --! the id of this node

        TX_P : out std_logic;                       --! LVDS positive TX output for highspeed communication
        TX_N : out std_logic;                       --! LVDS negative RX output for highspeed communication
        RX_P : in  std_logic;                       --! LVDS positive RX input for highspeed communication
        RX_N : in  std_logic;                       --! LVDS negative RX input for highspeed communication

        -- ----------------- --
        --       DEBUG       --
        -- ----------------- --
        txData_sim         : out std_logic_vector(7 downto 0);
        txData_Kflag_sim   : out std_logic;
        txData_trigger_sim : in  std_logic;
        rxData_sim         : in  std_logic_vector(7 downto 0);
        rxData_Kflag_sim   : in  std_logic;
        rxData_CodeErr_sim : in  std_logic;
        rxData_DispErr_sim : in  std_logic;
        rxData_trigger_sim : in  std_logic;

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
        error_sendTimeout : out std_logic;      -- todo: check if this is needed/usefull
        error_decoderCode : out std_logic;
        error_decoderDisp : out std_logic;
        error_bufferFull  : out std_logic;
        error_brokenMsg   : out std_logic );
end NDLComHS;

architecture Behavioral of NDLComHS is

    constant NEW_SEND : boolean := true;

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

    signal sendingActive  : std_logic;
    signal sendSOF        : std_logic;
    signal fifo_rd        : std_logic;
    signal fifo_empty     : std_logic;
    
    signal txData         : std_logic_vector(7 downto 0);
    signal txData_Kflag   : std_logic;
    signal txData_trigger : std_logic;

    signal rxData         : std_logic_vector(7 downto 0);
    signal rxData_Kflag   : std_logic;
    signal rxData_trigger : std_logic;
    signal rxData_CodeErr : std_logic;
    signal rxData_DispErr : std_logic;

    type sendStates is (idle, sending, send_SOF);
    signal sendState : sendStates;

    type receiveStates is (receiveStartFlag, receiveReceiverId,
                           receiveSenderId, receiveData);
    signal receiveState : receiveStates;

    type forwardStates is (readReceiverId, waitAck, readData);
    signal forwardState : forwardStates;

    -- timeout signals
    constant TIMEOUT_COUNTER_MAX : integer := CLK_FREQ * TIMEOUT_MS/1000;
    signal startSendTimer        : std_logic;
    signal send_timeout          : std_logic;

    signal error_bufferFull_int  : std_logic;
    signal readyToReceive : std_logic;

    signal txData_int : std_logic_vector(7 downto 0);
    signal forwardBuffer_data_debug : Array3x8;
    signal forwardBuffer_counter_debug : integer range 0 to 3;

    signal startFlag_debug : std_logic;

begin

    txData <= txData_int;

    -- check if a new message could be send by
    -- checking the remaining size of the send fifo
    send_fifo_ready <= '0' when unsigned(send_fifo_remaining) < MAX_PACKET_SIZE else '1';

    error_bufferFull <= error_bufferFull_int;

    readyToReceive <= '0' when unsigned(receive_fifo_remaining) < MAX_PACKET_SIZE or
                      unsigned(forward_fifo_remaining) < MAX_PACKET_SIZE
                      else '1';
    
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
                   empty => forward_fifo_empty,
                   full  => forward_fifo_full,
                   remaining => forward_fifo_remaining );

    sim : if SIMULATION=true generate
        txData_sim <= txData;
        txData_Kflag_sim <= txData_Kflag;
        txData_trigger <= txData_trigger_sim;
        rxData <= rxData_sim;
        rxData_Kflag <= rxData_Kflag_sim;
        rxData_trigger <= rxData_trigger_sim;
        rxData_CodeErr <= rxData_CodeErr_sim;
        rxData_DispErr <= rxData_DispErr_sim;
    end generate;
    
    re : if SIMULATION=false generate
        -- sender for high speed LVDS communication
        HSCom_Sender : entity Spartan6.asynch_sercomm_tx_top
            port map (
                clkHalfDR        => clkHalfDR,
                clkDoubleDR_ioce => clkDoubleDR_ioce,
                clkDoubleDR_io   => clkDoubleDR_io,
                clkCommInterface => clk,
                reset            => rst,
                txPPin           => tx_p,
                txNPin           => tx_n,
                
                encoderWordIn    => txData,
                encoderKIn       => txData_Kflag,
                encoderNewDataStrobe => txData_trigger );
        
        -- receiver for high speed LVDS communication
        HSCom_receiver : entity Spartan6.asynch_sercomm_rx_top
            port map (
                clkHalfDR        => clkHalfDR,
                clkDoubleDR_ioce => clkDoubleDR_ioce,
                clkDoubleDR_io   => clkDoubleDR_io,
                clkCommInterface => clk,
                reset            => rst,
                rxPPin           => rx_p,
                rxNPin           => rx_n,
                decoderWordOut   => rxData,
                decoderKOut      => rxData_KFlag,
                decoderCodeErr   => rxData_CodeErr,
                decoderDispErr   => rxData_DispErr,
                decoderNewDataStrobe => rxData_trigger );
    end generate;

    error_decoderCode <= rxData_CodeErr;
    error_decoderDisp <= rxData_DispErr;


    neu : if NEW_SEND=true generate
        -- concurrent assignments for sending
        send_fifo_rd    <= fifo_rd when send_fifo_empty='0' and sendSOF='0' else '0';
        txData_int      <= send_fifo_dout       when send_fifo_rd='1'    else
                           ASYNCH_SERCOMM_K_SOF when sendSOF='1'         else
                           ASYNCH_SERCOMM_K_IDLE;
        txData_Kflag    <= '0' when send_fifo_rd='1' else '1';

        -- -------------------------- --
        -- process that handles the   --
        -- outgoing data stream which --
        -- switches between the fifos --
        -- -------------------------- --
        sendMonitor : process (clk)
            variable startFlag : std_logic;
        begin
            if clk'event and clk='1' then
                if rst='1' then
                    startFlag         := '1';
                    sendSOF           <= '0';
                    fifo_rd           <= '0';
                else
                    -- defaults
                    --if txData_trigger='1' then
                    if fifo_rd='1' then
                        sendSOF <= '0';
                    end if;

                    -- fifo_rd must be one cycle after
                    -- txData_trigger - so delay it here
                    fifo_rd <= txData_trigger;
                    
                    --if txData_trigger='1' and send_fifo_empty='0' then
                    if send_fifo_rd='1' then
                        if txData_int=FLAG_BYTE then
                            if startFlag='0' then
                                sendSOF   <= '1';
                            end if;
                            startFlag := '1';
                        else
                            startFlag := '0';
                        end if;
                    end if;

                    startFlag_debug <= startFlag;
                    
                end if;
            end if;
        end process;
    end generate;

    alt : if NEW_SEND=false generate
        -- concurrent assignments for sending
        send_fifo_rd    <= fifo_rd when sendingActive='1' and send_fifo_empty='0' else '0';
        txData_int      <= send_fifo_dout       when send_fifo_rd='1'    else
                           ASYNCH_SERCOMM_K_SOF when sendSOF='1'         else
                           ASYNCH_SERCOMM_K_IDLE;
        txData_Kflag    <= '0' when send_fifo_rd='1' else '1';

        -- -------------------------- --
        -- process that handles the   --
        -- outgoing data stream which --
        -- switches between the fifos --
        -- -------------------------- --
        sendMonitor : process (clk)
            variable startFlag : std_logic;
        begin
            if clk'event and clk='1' then
                if rst='1' then
                    startFlag         := '0';
                    error_sendTimeout <= '0';
                    startSendTimer    <= '0';
                    sendSOF           <= '0';
                    fifo_rd           <= '0';
                    sendingActive     <= '0';
                    sendState         <= idle;
                else
                    -- defaults
                    error_sendTimeout <= '0';
                    startSendTimer    <= '0';
                    sendSOF           <= '0';
                    
                    -- fifo_rd must be one cycle after
                    -- txData_trigger - so delay it here
                    fifo_rd <= txData_trigger;

                    case sendState is
                        
                        when idle =>
                            -- check fifo buffer
                            if send_fifo_empty='0' then
                                startFlag      := '1';
                                startSendTimer <= '1';
                                sendingActive  <= '1';
                                sendState      <= sending;
                            end if;
                            
                        when sending =>
                            if send_timeout='1' then
                                -- if a timeout occurs reset everything
                                -- and go into idle-state
                                startFlag         := '0';
                                error_sendTimeout <= '1';
                                sendingActive     <= '0';
                                sendState         <= idle;
                                --elsif txData_int=FLAG_BYTE and fifo_rd='1' and fifo_empty='0' then
                            elsif txData_int=FLAG_BYTE then
                                -- if a flag byte is send check if
                                -- this was the end of a package
                                if startFlag='1' then
                                    startFlag := '0';
                                else
                                    -- end of a package
                                    sendingActive <= '0';
                                    sendState     <= send_SOF;
                                end if;
                            end if;

                        when send_SOF =>
                            -- send a SOF (start of frame) at the end
                            -- of a package to trigger sending in the
                            -- LVDS_Ethernet converter (crazy eh?)
                            if txData_trigger='1' then
                                sendSOF   <= '1';
                                sendState <= idle;
                            end if;
                            
                    end case;
                end if;
            end if;
        end process;
        
        -- timeout process which cancels sending a message after
        -- a certain amount of time (-> TIMEOUT_COUNTER_MAX)
        send_timeoutProcess : process (CLK)
            variable timeoutCounter : integer range 0 to TIMEOUT_COUNTER_MAX;
        begin
            if CLK = '1' and CLK'event then
                if RST = '1' then
                    timeoutCounter := 0;
                    send_timeout   <= '0';
                else
                    -- default
                    send_timeout <= '0';

                    if startSendTimer = '1' then
                        timeoutCounter := 0;
                    else
                        if timeoutCounter < TIMEOUT_COUNTER_MAX then
                            timeoutCounter := timeoutCounter + 1;
                        else
                            send_timeout   <= '1';
                            timeoutCounter := 0;
                        end if;
                    end if;
                end if;
            end if;
        end process;
    end generate;

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

                sender_id     <= (others => '0');
                new_sender_id <= '0';

                error_bufferFull_int <= '0';
                error_brokenMsg <= '0';
                
                receiveState <= receiveStartFlag;
            else
                -- defaults
                receive_fifo_wr <= '0';
                forward_fifo_wr <= '0';
                new_sender_id   <= '0';
                error_brokenMsg <= '0';

                -- first check for rxErr or buffer full!!
                if rxData_CodeErr='1' or rxData_DispErr='1' or error_bufferFull_int='1' then
                    escapeFlag   := '0';
                    receiveFlag  := '0';
                    forwardFlag  := '0';
                    error_bufferFull_int <= '0';
                    receiveState <= receiveStartFlag;
                else

                    case receiveState is

                        when receiveStartFlag =>
                            if readyToReceive='0' then
                                -- skip the next message because
                                -- we are not ready to receive it
                                error_bufferFull_int <= '1';
                                escapeFlag   := '0';
                                receiveFlag  := '0';
                                forwardFlag  := '0';
                                receiveState <= receiveStartFlag;
                                
                            elsif rxData_trigger='1' and rxData_Kflag='0' then
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
                                error_bufferFull_int <= '1';
                                escapeFlag   := '0';
                                receiveFlag  := '0';
                                forwardFlag  := '0';
                                receiveState <= receiveStartFlag;
                                
                            elsif rxData_trigger='1' and rxData_Kflag='0' then

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
                            if rxData_trigger='1' and rxData_Kflag='0' then

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
                            if rxData_trigger='1' and rxData_Kflag='0' then

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
                                    receiveState <= receiveStartFlag; --receiveReceiverId;
                                else
                                    receiveState <= receiveData;
                                end if;
                            else
                                receiveState <= receiveData;
                            end if;
                            
                    end case;

                    forwardBuffer_data_debug <= forward_buffer_data;
                    forwardBuffer_counter_debug <= forward_buffer_counter;

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
