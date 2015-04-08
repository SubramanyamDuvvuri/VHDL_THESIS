---------------------------------------------------------------------------------
--! @file    NDLCom_wrapper.vhd
--! @class   NDLCom_wrapper
--!
--! @brief   NDLCom wrapper
--! @details NDLCom wrapper which handles the communication via NDLCom.\n\n
--!          German Research Center for Artificial Intelligence\n
--!
--! @date   29.01.2011
--! @author Tobias Stark (tobias.stark@dfki.de)
--!
--! @addtogroup VHDL
--! @{
--! @defgroup VHDL_NDLCom_wrapper NDLCom_wrapper
--! @{
---------------------------------------------------------------------------------
-- Last Commit: 
-- $LastChangedRevision: 3673 $
-- $LastChangedBy: tstark $
-- $LastChangedDate: 2014-11-28 14:25:04 +0100 (Fri, 28 Nov 2014) $
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.config.all;
use work.NDLCom_config.all;
use work.dfki_pack.all;
use work.representations.all;
use work.devices.all;
use work.register_types.all;
use work.register_pack.all;

entity NDLCom_wrapper is
    generic ( CLK_FREQ      : integer := 16000000; --! the system clock (in Hz)
              BAUD_RATE     : integer := 115200;   --! the baud rate of this uart (IF BAUD_RATE=0, THE HIGHSPEED COMMUNICATION INTERFACE IS USED)
              USE_TELEMETRY : boolean := true );   --! flag if telemetry should be used or not
    port ( CLK              : in  std_logic; --! system clock
           RST              : in  std_logic; --! system reset
           NODE_ID          : in  std_logic_vector(7 downto 0);  --! node id
           
           -- Communication pins for normal communication (only used if BAUD_RATE != 0)
			  RX1 : in  std_logic := '0'; --! port 1 RX input for normal communication
           TX1 : out std_logic;        --! port 1 TX output for normal communication
           RX2 : in  std_logic := '0'; --! port 2 RX input for normal communication
           TX2 : out std_logic;        --! port 2 TX output for normal communication

           rtc_actual_time  : in std_logic_vector(63 downto 0);
           
           telemetry_values : in  TelemetryValues;               --! telemetry values which are send periodically

           resetDevice      : out std_logic; --! signal for resetting the device (only active for only cycle)

           reg_read_id      : out std_logic_vector(15 downto 0); --! address of the registers to be send
           reg_read_type    : in  registertype_t;                --! length of the register to be send --! type registertype_t is (UINT8, INT8, UINT16, INT16, SINGLEFLOAT, UINT32, INT32, DOUBLEFLOAT, UINT64, INT64, ERROR);
           reg_read_data    : in  std_logic_vector(63 downto 0); --! data of the register to be send
           reg_read         : out std_logic;                     --! read register enable signal
           reg_read_ack     : in  std_logic;                     --! read register acknowledge signal
           reg_write_id     : out std_logic_vector(15 downto 0); --! address of the register to be written to
           reg_write_type   : out registertype_t;                --! length of the register to be written to --!  type registertype_t is (UINT8, INT8, UINT16, INT16, SINGLEFLOAT, UINT32, INT32, DOUBLEFLOAT, UINT64, INT64, ERROR);
           reg_write_data   : out std_logic_vector(63 downto 0); --! data of the register to be written to
           reg_write        : out std_logic;                     --! write register enable signal
           
           isp_cmd_upload   : out std_logic;  --! ISP command trigger (high for one clock cycle)
           isp_cmd_data     : out std_logic;  --! ISP data trigger (high for one clock cycle)
           isp_cmd_download : out std_logic;  --! ISP download trigger (high for one clock cycle)
           isp_cmd_ack      : in  std_logic;  --! ISP ack signal to acknowledge one of the above trigger
           isp_din_addr     : out std_logic_vector(31 downto 0);
           isp_din_len      : out std_logic_vector(31 downto 0);
           isp_din          : out std_logic_vector(7 downto 0);
           isp_din_valid    : out std_logic;
           isp_din_ack      : in  std_logic;
           isp_dout_addr    : in  std_logic_vector(31 downto 0);
           isp_dout         : in  std_logic_vector(7 downto 0);
           isp_dout_valid   : in  std_logic;
           isp_dout_ack     : out std_logic;

           commErr          : out std_logic );                    --! communication error flag
end NDLCom_wrapper;

  architecture Behavioral of NDLCom_wrapper is

    constant TELEMETRY_IDLE_COUNTER_MAX : integer := CLK_FREQ/100;

    
------------------node1 signals--------------------------	 
	 signal nc1_readyToSend      : std_logic;
    signal nc1_startSending     : std_logic;
    signal nc1_newData          : std_logic;
    signal nc1_dataAck          : std_logic;
    signal nc1_recvSender       : std_logic_vector(7 downto 0);
    signal nc1_recvFrameCounter : std_logic_vector(7 downto 0);
    signal nc1_recvLength       : std_logic_vector(7 downto 0);
    signal nc1_recv_addr        : std_logic_vector(7 downto 0);
    signal nc1_recv_data        : std_logic_vector(7 downto 0);
    signal nc1_recv_error       : std_logic;
 ---------------------------------------------------------   
 -----------Node2 signals---------------------------------
 ---------------------------------------------------------
 
    signal nc2_readyToSend      : std_logic;
    signal nc2_startSending     : std_logic;
    signal nc2_newData          : std_logic;
    signal nc2_dataAck          : std_logic;
    signal nc2_recvSender       : std_logic_vector(7 downto 0);
    signal nc2_recvFrameCounter : std_logic_vector(7 downto 0);
    signal nc2_recvLength       : std_logic_vector(7 downto 0);
    signal nc2_recv_addr        : std_logic_vector(7 downto 0);
    signal nc2_recv_data        : std_logic_vector(7 downto 0);
    signal nc2_recv_error       : std_logic;
---------------------------------------------------------------------------
    signal nc_sendReceiver     : std_logic_vector(7 downto 0);
    signal nc_sendFrameCounter : std_logic_vector(7 downto 0);
    signal nc_sendLength       : std_logic_vector(7 downto 0);
    signal nc_send_wea         : std_logic_vector(0 downto 0);
    signal nc_send_addr        : std_logic_vector(7 downto 0);
    signal nc_send_data        : std_logic_vector(7 downto 0);
    signal nc_recvSender       : std_logic_vector(7 downto 0);
    signal nc_recvFrameCounter : std_logic_vector(7 downto 0);
    signal nc_recvLength       : std_logic_vector(7 downto 0);
    signal nc_recv_addr        : std_logic_vector(7 downto 0);
    signal nc_recv_data        : std_logic_vector(7 downto 0);

    -- frame counter buffer --
    component dualportram_256_8 is
        port ( clka : in  std_logic;
               wea  : in  std_logic_vector(0 downto 0);
               addra: in  std_logic_vector(7 downto 0);
               dina : in  std_logic_vector(7 downto 0);
               clkb : in  std_logic;
               addrb: in  std_logic_vector(7 downto 0);
               doutb: out std_logic_vector(7 downto 0));
    end component dualportram_256_8;
    attribute box_type : string;
    attribute box_type of dualportram_256_8 : component is "black_box";
------------------------------------------------------------------------
-------------Frame counter signals--------------------------------------
------------------------------------------------------------------------
    signal frameCounter_addr_in  : std_logic_vector(7 downto 0);
    signal frameCounter_data_in  : std_logic_vector(7 downto 0);
    signal frameCounter_wea      : std_logic_vector(0 downto 0);
    signal frameCounter_addr_out : std_logic_vector(7 downto 0);
    signal frameCounter_data_out : std_logic_vector(7 downto 0);
------------------------------------------------------------------------
    signal receiveDirection : communication_direction;

    type receiveStates is (idle, checkId, waitReceiverProcess);
    signal receiveState : receiveStates;
    signal receiveError : std_logic;

    type sendStates is (idle, writeTimeStamp, waitSenderProcess);
    signal sendState : sendStates;

    type commTypes is (common, registerValue, telemetry, isp);
    signal sendType : commTypes;
    signal recvType : commTypes;

    signal common_recv_addr : std_logic_vector(7 downto 0);
    signal common_recvError : std_logic;
    signal common_send_addr : std_logic_vector(7 downto 0);
    signal common_send_data : std_logic_vector(7 downto 0);
    signal common_send_wea  : std_logic_vector(0 downto 0);

    -- TELEMETRY
    
    type telemetrySendStates is (idle, waitAck, writeDataLow,
                                 writeDataHigh);
    signal telemetrySendState : telemetrySendStates;

    signal telemetry_sendRequest  : std_logic;
    signal telemetry_sendAck      : std_logic;
    signal telemetry_startSending : std_logic;
    signal telemetry_send_addr : std_logic_vector(7 downto 0);
    signal telemetry_send_data : std_logic_vector(7 downto 0);
    signal telemetry_send_wea  : std_logic_vector(0 downto 0);

    -- REGISTER

    type registerRecvStates is (idle, read_checkLength, read_copyAddr,
                                write_checkLength, write_copyAddr,
                                write_copyType, write_copyValue);
    signal registerRecvState : registerRecvStates;

    signal register_recvReadRequest  : std_logic;
    signal register_recvWriteRequest : std_logic;
    signal register_recvAck   : std_logic;
    signal register_recvError : std_logic;
    signal register_recvId    : std_logic_vector(7 downto 0);
    signal register_recv_addr : std_logic_vector(7 downto 0);
    
    type registerSendStates is (idle, waitAck, writeAddr,
                                writeType, writeData);
    signal registerSendState : registerSendStates;

    signal register_sendDirection : communication_direction;
    signal register_sendRequest   : std_logic;
    signal register_sendAck       : std_logic;
    signal register_startSending  : std_logic;
    signal register_send_addr     : std_logic_vector(7 downto 0);
    signal register_send_data     : std_logic_vector(7 downto 0);
    signal register_send_wea      : std_logic_vector(0 downto 0);

    signal reg_read_id_int    : std_logic_vector(15 downto 0);
    signal reg_write_type_int : registertype_t;
    
    -- ISP

    type ispRecvStates is (idle,
                           cmd_checkLength, cmd_readCmd, cmd_readAddr,
                           cmd_readLength, cmd_waitAck,
                           data_checkLength, data_readAddr, data_readData,
                           data_waitDataAck, data_waitAck);
    signal ispRecvState : ispRecvStates;

    signal isp_recvCmdRequest  : std_logic;
    signal isp_recvDataRequest : std_logic;
    signal isp_recvAck   : std_logic;
    signal isp_recvError : std_logic;
    signal isp_recvId    : std_logic_vector(7 downto 0);
    signal isp_recv_addr : std_logic_vector(7 downto 0);

    type ispSendStates is (idle, cmd_waitAck, cmd_writeAck, cmd_writeAddr,
                           data_waitAck, data_writeLength, data_writeData);
    signal ispSendState : ispSendStates;

    signal isp_sendDirection   : communication_direction;
    signal isp_sendCmdRequest  : std_logic;
    signal isp_sendDataRequest : std_logic;
    signal isp_sendAck      : std_logic;
    signal isp_startSending : std_logic;
    signal isp_send_addr    : std_logic_vector(7 downto 0);
    signal isp_send_data    : std_logic_vector(7 downto 0);
    signal isp_send_wea     : std_logic_vector(0 downto 0);

    signal isp_din_valid_int  : std_logic;
    signal sendIspAckRequest  : std_logic;
    signal sendIspDataRequest : std_logic;

begin

    commErr <= nc1_recv_error or nc2_recv_error or receiveError;
    
    reg_read_id    <= reg_read_id_int;
    reg_write_type <= reg_write_type_int;

    isp_din_valid <= isp_din_valid_int and not isp_din_ack;

    -- NodeCommunication module 1
    NDLCom1 : entity work.NDLCom(Behavioral)
        generic map ( CLK_FREQ  => CLK_FREQ,
                      BAUD_rate => BAUD_RATE)
        port map ( CLK => CLK,
                   RST => RST,
                   NODE_ID => NODE_ID,
                   RX  => RX1,
                   TX  => TX2,
                   
                   readyToSend      => nc1_readyToSend,
                   startSending     => nc1_startSending,
                   sendReceiver     => nc_sendReceiver,
                   sendFrameCounter => nc_sendFrameCounter,
                   sendLength       => nc_sendLength,
                   send_wea         => nc_send_wea,
                   send_addr        => nc_send_addr,
                   send_data        => nc_send_data,

                   newData          => nc1_newData,
                   dataAck          => nc1_dataAck,
                   recvSender       => nc1_recvSender,
                   recvFrameCounter => nc1_recvFrameCounter,
                   recvLength       => nc1_recvLength,
                   recv_addr        => nc1_recv_addr,
                   recv_data        => nc1_recv_data,
                   recv_error       => nc1_recv_error );

    -- NodeCommunication module 2
    NDLCom2 : entity work.NDLCom(Behavioral)
        generic map ( CLK_FREQ  => CLK_FREQ,
                      BAUD_rate => BAUD_RATE)
        port map ( CLK => CLK,
                   RST => RST,
                   NODE_ID => NODE_ID,
                   RX  => RX2,
                   TX  => TX1,
                   
                   readyToSend      => nc2_readyToSend,
                   startSending     => nc2_startSending,
                   sendReceiver     => nc_sendReceiver,
                   sendFrameCounter => nc_sendFrameCounter,
                   sendLength       => nc_sendLength,
                   send_wea         => nc_send_wea,
                   send_addr        => nc_send_addr,
                   send_data        => nc_send_data,

                   newData          => nc2_newData,
                   dataAck          => nc2_dataAck,
                   recvSender       => nc2_recvSender,
                   recvFrameCounter => nc2_recvFrameCounter,
                   recvLength       => nc2_recvLength,
                   recv_addr        => nc2_recv_addr,
                   recv_data        => nc2_recv_data,
                   recv_error       => nc2_recv_error );

    -- input buffer (simple dual-port ram 256x8) --
    frameCounter_buffer : entity work.bram_dp_simple
        generic map ( ADDRWIDTH => 8,
                      DATAWIDTH => 8 )
        port map ( clk   => CLK,
                   we    => frameCounter_wea(0),
                   waddr => frameCounter_addr_in,
                   wdata => frameCounter_data_in,
                   raddr => frameCounter_addr_out,
                   rdata => frameCounter_data_out);

    
    -- ----------------------------------------------------------------------------------------------
    --                                        RECEIVING
    -- ----------------------------------------------------------------------------------------------
    
    nc_recvSender       <= nc1_recvSender       when receiveDirection=top else nc2_recvSender;
    nc_recvFrameCounter <= nc1_recvFrameCounter when receiveDirection=top else nc2_recvFrameCounter;
    nc_recvLength       <= nc1_recvLength       when receiveDirection=top else nc2_recvLength;
    nc_recv_data        <= nc1_recv_data        when receiveDirection=top else nc2_recv_data;
    nc1_recv_addr       <= isp_recv_addr      when recvType=isp else
                           register_recv_addr when recvType=registerValue else
                           common_recv_addr;
    nc2_recv_addr       <= isp_recv_addr      when recvType=isp else
                           register_recv_addr when recvType=registerValue else
                           common_recv_addr;

    receiveError <= common_recvError or register_recvError or isp_recvError;
    
    receiver : process (CLK)
        variable idleFlag  : std_logic;
    begin
        if CLK='1' and CLK'event then
            if RST='1' then
                idleFlag := '0';

                resetDevice      <= '0';

                nc1_dataAck      <= '0';
                nc2_dataAck      <= '0';
                common_recv_addr <= (others => '0');
                receiveDirection <= top;
                
                recvType         <= common;

                register_sendDirection    <= top;
                register_recvReadRequest  <= '0';
                register_recvWriteRequest <= '0';
                isp_recvCmdRequest        <= '0';
                isp_recvDataRequest       <= '0';
                
                common_recvError <= '0';
                receiveState     <= idle;

            else
                -- defaults
                nc1_dataAck      <= '0';
                nc2_dataAck      <= '0';
                common_recvError <= '0';

                if idleFlag='1' then
                    idleFlag := '0';
                else

                    case receiveState is
                        
                        when idle =>
                            -- wait for new data
                            if nc1_newData='1' then
                                idleFlag         := '1';
                                common_recv_addr <= (others => '0');
                                receiveDirection <= top;
                                receiveState     <= checkId;
                            elsif nc2_newData='1' then
                                idleFlag         := '1';
                                common_recv_addr <= (others => '0');
                                receiveDirection <= bottom;
                                receiveState     <= checkId;
                            else
                                receiveState     <= idle;
                            end if;

                        when checkId =>

                            -- check message Id
                            case nc_recv_data is
                                
                                when Representation_Id_RESET =>
                                    resetDevice     <= '1';
                                    if receiveDirection=top then
                                        nc1_dataAck <= '1';
                                    else
                                        nc2_dataAck <= '1';
                                    end if;
                                    receiveState    <= idle;

                                when Representation_Id_IspCommand =>
                                    isp_sendDirection <= receiveDirection;
                                    recvType <= isp;
                                    isp_recvCmdRequest <= '1';
                                    receiveState <= waitReceiverProcess;

                                when Representation_Id_IspData =>
                                    isp_sendDirection <= receiveDirection;
                                    recvType <= isp;
                                    isp_recvDataRequest <= '1';
                                    receiveState <= waitReceiverProcess;

                                when Representation_Id_RegisterValueQuery =>
                                    register_sendDirection   <= receiveDirection;
                                    recvType <= registerValue;
                                    register_recvReadRequest <= '1';
                                    receiveState <= waitReceiverProcess;

                                when Representation_Id_RegisterValueWrite =>
                                    recvType <= registerValue;
                                    register_recvWriteRequest <= '1';
                                    receiveState <= waitReceiverProcess;
                                    
                                when others =>
                                    if receiveDirection=top then
                                        nc1_dataAck <= '1';
                                    else
                                        nc2_dataAck <= '1';
                                    end if;
                                    common_recvError <= '1';
                                    receiveState <= idle;
                                    
                            end case;

                        when waitReceiverProcess =>
                            if (recvType=registerValue and register_recvAck='1') or
                                (recvType=isp and isp_recvAck='1') then
                                recvType <= common;
                                register_recvReadRequest  <= '0';
                                register_recvWriteRequest <= '0';
                                isp_recvCmdRequest        <= '0';
                                isp_recvDataRequest       <= '0';
                                if receiveDirection=top then
                                    nc1_dataAck <= '1';
                                else
                                    nc2_dataAck <= '1';
                                end if;
                                receiveState <= idle;
                            end if;
                            
                    end case;
                end if;
            end if;
        end if;
    end process receiver;

    -- ----------------------------------------------------------------------------------------------
    --                                       SENDING
    -- ----------------------------------------------------------------------------------------------

    nc_sendFrameCounter <= frameCounter_data_out;
    nc_send_addr <= isp_send_addr       when sendType=isp else
                    register_send_addr  when sendType=registerValue else
                    telemetry_send_addr when sendType=telemetry else
                    common_send_addr;
    nc_send_data <= isp_send_data       when sendType=isp else
                    register_send_data  when sendType=registerValue else
                    telemetry_send_data when sendType=telemetry else
                    common_send_data;
    nc_send_wea <= isp_send_wea       when sendType=isp else
                   register_send_wea  when sendType=registerValue else
                   telemetry_send_wea when sendType=telemetry else
                   common_send_wea;
    
    sender : process (CLK)
        variable counter    : integer range 0 to 7;
        variable sendDirection : communication_direction;
        variable nextSendType  : commTypes;
        variable sendType_1 : commTypes;
        variable sendType_2 : commTypes;
    begin
        if CLK='1' and CLK'event then
            if RST='1' then
                counter    := 0;
                sendDirection := top;
                nextSendType  := common;
                sendType_1 := common;
                sendType_2 := common;
                sendType   <= common;
                
                frameCounter_addr_in  <= (others => '0');
                frameCounter_data_in  <= (others => '0');
                frameCounter_wea      <= "0";
                frameCounter_addr_out <= (others => '0');

                nc_sendReceiver  <= (others => '0');
                nc_sendLength    <= (others => '0');
                nc1_startSending <= '0';
                nc2_startSending <= '0';

                common_send_wea  <= "0";
                common_send_addr <= (others => '0');
                common_send_data <= (others => '0');

                telemetry_sendAck <= '0';
                register_sendAck  <= '0';
                isp_sendAck       <= '0';
                
                sendState <= idle;

            else
                -- defaults
                frameCounter_wea  <= "0";
                nc1_startSending  <= '0';
                nc2_startSending  <= '0';
                common_send_wea   <= "0";
                isp_sendAck       <= '0';
                telemetry_sendAck <= '0';
                register_sendAck  <= '0';

                -- 2 clock cycles delay for sendType
                sendType   <= sendType_2;
                sendType_2 := sendType_1;
                
                case sendState is

                    when idle =>
                        sendType <= common;
                        counter  := 0;
                        if isp_sendCmdRequest='1' and
                            ((isp_sendDirection=top and nc2_readyToSend='1') or
                             (isp_sendDirection=bottom and nc1_readyToSend='1')) then
                            sendDirection := isp_sendDirection;
                            nextSendType  := isp;
                            frameCounter_addr_in  <= isp_recvId;
                            frameCounter_addr_out <= isp_recvId;
                            -- write header
                            nc_sendReceiver     <= isp_recvId;
                            nc_sendLength       <= x"12";
                            -- write message type
                            common_send_addr <= x"00";
                            common_send_data <= Representation_Id_IspCommand;
                            common_send_wea  <= "1";
                            sendState        <= writeTimeStamp;

                        elsif isp_sendDataRequest='1' and
                            ((isp_sendDirection=top and nc2_readyToSend='1') or
                             (isp_sendDirection=bottom and nc1_readyToSend='1')) then
                            sendDirection := isp_sendDirection;
                            nextSendType  := isp;
                            frameCounter_addr_in  <= isp_recvId;
                            frameCounter_addr_out <= isp_recvId;
                            -- write header
                            nc_sendReceiver     <= isp_recvId;
                            nc_sendLength       <= x"8d";  -- 128+4+1+8
                            -- write message type
                            common_send_addr <= x"00";
                            common_send_data <= Representation_Id_IspData;
                            common_send_wea  <= "1";
                            sendState        <= writeTimeStamp;

                        elsif register_sendRequest='1' and
                            ((register_sendDirection=top and nc2_readyToSend='1') or
                             (register_sendDirection=bottom and nc1_readyToSend='1')) then
                            sendDirection := register_sendDirection;
                            nextSendType  := registerValue;
                            frameCounter_addr_in  <= register_recvId;
                            frameCounter_addr_out <= register_recvId;
                            -- write header
                            nc_sendReceiver     <= register_recvId;
                            nc_sendLength       <= x"14";
                            -- write message type
                            common_send_addr <= x"00";
                            common_send_data <= Representation_Id_RegisterValueResponse;
                            common_send_wea  <= "1";
                            sendState        <= writeTimeStamp;

                        elsif telemetry_sendRequest='1' and nc2_readyToSend='1' then
                            sendDirection := top;
                            nextSendType  := telemetry;
                            frameCounter_addr_in  <= TELEMETRY_RECEIVER;
                            frameCounter_addr_out <= TELEMETRY_RECEIVER;
                            -- write header
                            nc_sendReceiver     <= TELEMETRY_RECEIVER;
                            nc_sendLength       <= std_logic_vector(to_unsigned(2*TELEMETRY_LENGTH+9,8));
                            -- write message type
                            common_send_addr <= x"00";
                            common_send_data <= TELEMETRY_MSG_ID;
                            common_send_wea  <= "1";
                            sendState        <= writeTimeStamp;

                        else
                            sendState <= idle;
                        end if;

                    when writeTimeStamp =>
                        common_send_addr <= incr_f(common_send_addr);
                        common_send_data <= rtc_actual_time(counter*8+7 downto counter*8);
                        common_send_wea  <= "1";
                        if counter=1 then
                            -- increment frame counter
                            frameCounter_data_in <= incr_f(frameCounter_data_out);
                            frameCounter_wea     <= "1";
                        end if;
                        if counter < 7 then
                            counter := counter + 1;
                            sendState <= writeTimeStamp;
                        else
                            sendType_1 := nextSendType;
                            sendState <= waitSenderProcess;
                            case nextSendType is
                                when isp           => isp_sendAck <= '1';
                                when registerValue => register_sendAck <= '1';
                                when telemetry     => telemetry_sendAck <= '1';
                                when others => sendState <= idle;
                            end case;
                        end if;

                    when waitSenderProcess =>
                        if (sendType=isp and isp_startSending='1') or
                            (sendType=registerValue and register_startSending='1') or
                            (sendType=telemetry and telemetry_startSending='1') then
                            if sendDirection=top then
                                nc2_startSending <= '1';
                            else
                                nc1_startSending <= '1';
                            end if;
                            sendType_1 := common;
                            sendType_2 := common;
                            sendType   <= common;
                            sendState  <= idle;
                        end if;

                end case;
            end if;
        end if;
    end process sender;

    -- --------------------------------------------------------------------------
    --                             TELEMETRY
    -- --------------------------------------------------------------------------

    telemetry_sender : process (CLK)
        variable idleCounter : integer range 0 to TELEMETRY_IDLE_COUNTER_MAX-1;
        variable dataCounter : integer range 0 to TELEMETRY_LENGTH-1;
    begin
        if CLK'event and CLK='1' then
            if RST='1' then
                idleCounter := 0;
                dataCounter := 0;

                telemetry_sendRequest  <= '0';
                telemetry_startSending <= '0';

                telemetry_send_addr <= (others => '0');
                telemetry_send_data <= (others => '0');
                telemetry_send_wea  <= "0";

                telemetrySendState <= idle;
            else
                -- defaults
                telemetry_startSending <= '0';
                telemetry_send_wea <= "0";

                case telemetrySendState is

                    when idle =>
                        if idleCounter=TELEMETRY_IDLE_COUNTER_MAX-1 and
                            USE_TELEMETRY=TRUE then
                            idleCounter := 0;
                            telemetry_sendRequest <= '1';
                            telemetrySendState    <= waitAck;
                        else
                            idleCounter := idleCounter + 1;
                            telemetrySendState    <= idle;
                        end if;

                    when waitAck =>
                        if telemetry_sendAck='1' then
                            dataCounter := 0;
                            telemetry_sendRequest <= '0';
                            telemetry_send_addr   <= x"08";
                            telemetrySendState    <= writeDataLow;
                        else
                            telemetrySendState    <= waitAck;
                        end if;
                        
                    when writeDataLow =>
                        telemetry_send_addr <= incr_f(telemetry_send_addr);
                        telemetry_send_data <= telemetry_values(dataCounter)(7 downto 0);
                        telemetry_send_wea  <= "1";
                        telemetrySendState  <= writeDataHigh;

                    when writeDataHigh =>
                        telemetry_send_addr <= incr_f(telemetry_send_addr);
                        telemetry_send_data <= telemetry_values(dataCounter)(15 downto 8);
                        telemetry_send_wea  <= "1";
                        if dataCounter < TELEMETRY_LENGTH-1 then
                            dataCounter        := dataCounter + 1;
                            telemetrySendState <= writeDataLow;
                        else
                            telemetry_startSending <= '1';
                            telemetrySendState <= idle;
                        end if;
                end case;
            end if;
        end if;
    end process;
    
    -- --------------------------------------------------------------------------
    --                             REGISTER
    -- --------------------------------------------------------------------------

    register_receiver : process (CLK)
        variable idleFlag    : std_logic;
        variable byteCounter : integer range 0 to 7;
    begin
        if CLK'event and CLK='1' then
            if RST='1' then
                idleFlag    := '0';
                byteCounter := 0;

                register_recv_addr <= (others => '0');
                register_recvAck   <= '0';
                register_recvError <= '0';
                register_recvId    <= (others => '0');

                reg_read           <= '0';
                reg_read_id_int    <= (others => '0');
                reg_write          <= '0';
                reg_write_id       <= (others => '0');
                reg_write_type_int <= ERROR;
                reg_write_data     <= (others => '0');
                
                registerRecvState <= idle;
            else
                -- defaults
                register_recvAck   <= '0';
                register_recvError <= '0';
                reg_read  <= '0';
                reg_write <= '0';

                if idleFlag='1' then
                    idleFlag := '0';
                else
                    
                    case registerRecvState is

                        when idle =>
                            if register_recvReadRequest='1' then
                                registerRecvState <= read_checkLength;
                            elsif register_recvWriteRequest='1' then
                                registerRecvState <= write_checkLength;
                            end if;
                            
                            -- register read
                            -- -------------
                        when read_checkLength =>
                            idleFlag := '1';
                            -- check if data length is 11 bytes
                            -- (id(1) + timestamp(8) + reg_addr(2))
                            if nc_recvLength=x"0b" then
                                byteCounter := 0;
                                register_recvId    <= nc_recvSender;
                                register_recv_addr <= x"09";
                                registerRecvState  <= read_copyAddr;
                            else
                                register_recvAck   <= '1';
                                register_recvError <= '1';
                                registerRecvState  <= idle;
                            end if;
                            
                        when read_copyAddr =>
                            idleFlag := '1';
                            if byteCounter=0 then
                                byteCounter := 1;
                                reg_read_id_int(7 downto 0) <= nc_recv_data;
                                register_recv_addr <= x"0a";
                                registerRecvState  <= read_copyAddr;
                            else
                                reg_read_id_int(15 downto 8) <= nc_recv_data;
                                reg_read          <= '1';
                                register_recvAck  <= '1';
                                registerRecvState <= idle;
                            end if;

                            -- register write
                            -- --------------
                        when write_checkLength =>
                            idleFlag := '1';
                            -- check if data length is 20 bytes
                            -- (id(1) + timestamp(8) + reg_addr(2) + type(1) + value(8))
                            if nc_recvLength=x"14" then
                                byteCounter := 0;
                                register_recvId    <= nc_recvSender;
                                register_recv_addr <= x"09";
                                registerRecvState  <= write_copyAddr;
                            else
                                register_recvAck   <= '1';
                                register_recvError <= '1';
                                registerRecvState  <= idle;
                            end if;

                        when write_copyAddr =>
                            idleFlag := '1';
                            if byteCounter=0 then
                                byteCounter := 1;
                                reg_write_id(7 downto 0) <= nc_recv_data;
                                register_recv_addr <= x"0a";
                                registerRecvState  <= write_copyAddr;
                            else
                                reg_write_id(15 downto 8) <= nc_recv_data;
                                register_recv_addr <= x"0b";
                                registerRecvState  <= write_copyType;
                            end if;

                        when write_copyType =>
                            idleFlag    := '1';
                            byteCounter := 0;
                            reg_write_type_int <= enum2registertype(nc_recv_data);
                            register_recv_addr <= x"0c";
                            registerRecvState  <= write_copyValue;

                        when write_copyValue =>
                            idleFlag    := '1';
                            reg_write_data(byteCounter*8+7 downto byteCounter*8) <= nc_recv_data;
                            if byteCounter < registertype2len(reg_write_type_int)-1 then
                                byteCounter := byteCounter + 1;
                                register_recv_addr <= incr_f(register_recv_addr);
                                registerRecvState  <= write_copyValue;
                            else
                                reg_write <= '1';
                                register_recvAck  <= '1';
                                registerRecvState <= idle;
                            end if;

                    end case;
                end if;
            end if;
        end if;
    end process;
    
    register_sender : process (CLK)
        variable byteCounter : integer range 0 to 8;
    begin
        if CLK'event and CLK='1' then
            if RST='1' then
                byteCounter := 0;
                
                register_sendRequest  <= '0';
                register_startSending <= '0';
                
                register_send_addr <= (others => '0');
                register_send_data <= (others => '0');
                register_send_wea  <= "0";

                registerSendState <= idle;
            else
                -- defaults
                register_startSending <= '0';
                register_send_wea <= "0";

                case registerSendState is

                    when idle =>
                        if reg_read_ack='1' then
                            register_sendRequest <= '1';
                            registerSendState    <= waitAck;
                        end if;

                    when waitAck =>
                        if register_sendAck='1' then
                            byteCounter := 0;
                            register_sendRequest <= '0';
                            registerSendState    <= writeAddr;
                        else
                            registerSendState    <= waitAck;
                        end if;
                        
                    when writeAddr =>
                        if byteCounter=0 then
                            byteCounter := 1;
                            register_send_addr <= x"09";
                            register_send_data <= reg_read_id_int(7 downto 0);
                            register_send_wea  <= "1";
                            registerSendState  <= writeAddr;
                        else
                            register_send_addr <= x"0a";
                            register_send_data <= reg_read_id_int(15 downto 8);
                            register_send_wea  <= "1";
                            registerSendState  <= writeType;
                        end if;

                    when writeType =>
                        byteCounter := 0;
                        register_send_addr <= x"0b";
                        register_send_data <= registertype2enum(reg_read_type);
                        register_send_wea  <= "1";
                        registerSendState  <= writeData;

                    when writeData =>
                        if byteCounter < registertype2len(reg_read_type) then
                            register_send_addr <= std_logic_vector(x"0c" + to_unsigned(byteCounter,8));
                            register_send_data <= reg_read_data(byteCounter*8+7 downto byteCounter*8);
                            register_send_wea  <= "1";
                            byteCounter := byteCounter + 1;
                            registerSendState  <= writeData;
                        else
                            register_startSending <= '1';
                            registerSendState  <= idle;
                        end if;

                end case;
            end if;
        end if;
    end process;

    -- --------------------------------------------------------------------------
    --                                ISP
    -- --------------------------------------------------------------------------

    isp_receiver : process (CLK)
        variable idleFlag    : std_logic;
        variable byteCounter : integer range 0 to 127;
        variable isp_cmd_int : std_logic_vector(2 downto 0);
    begin
        if CLK'event and CLK='1' then
            if RST='1' then
                idleFlag    := '0';
                byteCounter := 0;
                isp_cmd_int := (others => '0');

                isp_recv_addr <= (others => '0');
                isp_recvAck   <= '0';
                isp_recvError <= '0';
                isp_recvId    <= (others => '0');

                isp_cmd_upload   <= '0';
                isp_cmd_download <= '0';
                isp_cmd_data <= '0';
                isp_din_addr <= (others => '0');
                isp_din_len  <= (others => '0');
                isp_din      <= (others => '0');
                isp_din_valid_int <= '0';

                sendIspAckRequest  <= '0';
                sendIspDataRequest <= '0';

                ispRecvState <= idle;
            else
                -- defaults
                isp_recvAck       <= '0';
                isp_recvError     <= '0';
                isp_cmd_upload    <= '0';
                isp_cmd_data      <= '0';
                isp_cmd_download  <= '0';
                isp_din_valid_int <= '0';
                sendIspAckRequest  <= '0';
                sendIspDataRequest <= '0';

                if idleFlag='1' then
                    idleFlag := '0';
                else

                    case ispRecvState is

                        when idle =>
                            if isp_recvCmdRequest='1' then
                                ispRecvState <= cmd_checkLength;
                            elsif isp_recvDataRequest='1' then
                                ispRecvState  <= data_checkLength;
                            end if;
                            
                        when cmd_checkLength =>
                            -- check if data length is 18 bytes (id + timestamp + cmd + addr + len)
                            if nc_recvLength=x"12" then
                                idleFlag := '1';
                                isp_recvId    <= nc_recvSender;
                                isp_recv_addr <= x"09";
                                ispRecvState  <= cmd_readCmd;
                            else
                                idleFlag := '1';
                                isp_recvAck   <= '1';
                                isp_recvError <= '1';
                                ispRecvState  <= idle;
                            end if;

                        when cmd_readCmd =>
                            idleFlag := '1';
                            byteCounter   := 0;
                            isp_cmd_int   := nc_recv_data(2 downto 0);
                            isp_recv_addr <= incr_f(isp_recv_addr);
                            ispRecvState  <= cmd_readAddr;

                        when cmd_readAddr =>
                            idleFlag := '1';
                            isp_din_addr(byteCounter*8+7 downto byteCounter*8) <= nc_recv_data;
                            isp_recv_addr <= incr_f(isp_recv_addr);
                            if byteCounter < 3 then
                                byteCounter  := byteCounter + 1;
                                ispRecvState <= cmd_readAddr;
                            else
                                byteCounter  := 0;
                                ispRecvState <= cmd_readLength;
                            end if;

                        when cmd_readLength =>
                            idleFlag := '1';
                            isp_din_len(byteCounter*8+7 downto byteCounter*8) <= nc_recv_data;
                            isp_recv_addr <= incr_f(isp_recv_addr);
                            if byteCounter < 3 then
                                byteCounter  := byteCounter + 1;
                                ispRecvState <= cmd_readLength;
                            else
                                idleFlag := '1';
                                byteCounter  := 0;
                                isp_recvAck  <= '1';
                                ispRecvState <= idle;
                                if isp_cmd_int="000" then  -- upload
                                    isp_cmd_upload <= '1';
                                    ispRecvState   <= cmd_waitAck;
                                elsif isp_cmd_int="001" then  -- download
                                    isp_cmd_download   <= '1';
                                    sendIspDataRequest <= '1';
                                end if;
                            end if;

                        when cmd_waitAck =>
                            if isp_cmd_ack='1' then
                                if isp_cmd_int="000" then  -- upload
                                    sendIspAckRequest <= '1';
                                end if;
                                ispRecvState <= idle;
                            else
                                ispRecvState <= cmd_waitAck;
                            end if;

                        when data_checkLength =>
                            -- check if data length is 133 bytes (id + telemetry + addr + 128bytes)
                            if nc_recvLength=x"8d" then
                                idleFlag := '1';
                                isp_recvId    <= nc_recvSender;
                                isp_recv_addr <= x"09";
                                ispRecvState  <= data_readAddr;
                            else
                                idleFlag := '1';
                                isp_recvAck   <= '1';
                                isp_recvError <= '1';
                                ispRecvState  <= idle;
                            end if;

                        when data_readAddr =>
                            idleFlag := '1';
                            isp_cmd_data <= '1';
                            isp_din_addr(byteCounter*8+7 downto byteCounter*8) <= nc_recv_data;
                            isp_recv_addr <= incr_f(isp_recv_addr);
                            if byteCounter < 3 then
                                byteCounter  := byteCounter + 1;
                                ispRecvState <= data_readAddr;
                            else
                                byteCounter  := 0;
                                ispRecvState <= data_readData;
                            end if;

                        when data_readData =>
                            isp_din <= nc_recv_data;
                            isp_din_valid_int <= '1';
                            if byteCounter < 127 then
                                byteCounter   := byteCounter + 1;
                                isp_recv_addr <= incr_f(isp_recv_addr);
                                ispRecvState  <= data_waitDataAck;
                            else
                                idleFlag := '1';
                                byteCounter  := 0;
                                isp_recvAck  <= '1';
                                ispRecvState <= data_waitAck;
                            end if;

                        when data_waitDataAck =>
                            if isp_din_ack='1' then
                                ispRecvState <= data_readData;
                            else
                                isp_din_valid_int <= '1';
                                ispRecvState <= data_waitDataAck;
                            end if;

                        when data_waitAck =>
                            if isp_cmd_ack='1' then
                                sendIspAckRequest <= '1';
                                ispRecvState <= idle;
                            else
                                ispRecvState <= data_waitAck;
                            end if;
                    end case;
                end if;
            end if;
        end if;
    end process;
    
    isp_sender : process (CLK)
        variable byteCounter : integer range 0 to 127;
    begin
        if CLK'event and CLK='1' then
            if RST='1' then
                byteCounter := 0;
                
                isp_sendCmdRequest  <= '0';
                isp_sendDataRequest <= '0';
                isp_startSending    <= '0';

                isp_send_addr <= (others => '0');
                isp_send_data <= (others => '0');
                isp_send_wea  <= "0";
                isp_dout_ack  <= '0';
                
                ispSendState <= idle;
            else
                -- defaults
                isp_startSending <= '0';
                isp_send_wea <= "0";
                isp_dout_ack <= '0';

                case ispSendState is

                    when idle =>
                        if sendIspAckRequest='1' then
                            isp_sendCmdRequest <= '1';
                            isp_send_addr <= x"08";
                            ispSendState  <= cmd_waitAck;
                        elsif sendIspDataRequest='1' then
                            isp_sendDataRequest <= '1';
                            isp_send_addr <= x"08";
                            ispSendState  <= data_waitAck;
                        end if;

                    when cmd_waitAck =>
                        if isp_sendAck='1' then
                            isp_sendCmdRequest <= '0';
                            ispSendState <= cmd_writeAck;
                        else
                            ispSendState <= cmd_waitAck;
                        end if;

                    when cmd_writeAck =>
                        isp_send_addr <= incr_f(isp_send_addr);
                        isp_send_data <= x"03";
                        isp_send_wea  <= "1";
                        ispSendState  <= cmd_writeAddr;

                    when cmd_writeAddr =>
                        isp_send_addr <= incr_f(isp_send_addr);
                        isp_send_data <= isp_dout_addr(byteCounter*8+7 downto byteCounter*8);
                        isp_send_wea  <= "1";
                        if byteCounter < 3 then
                            byteCounter  := byteCounter + 1;
                            ispSendState <= cmd_writeAddr;
                        else
                            byteCounter  := 0;
                            isp_startSending <= '1';
                            ispSendState <= idle;
                        end if;

                    when data_waitAck =>
                        if isp_sendAck='1' then
                            isp_sendDataRequest <= '0';
                            ispSendState <= data_writeLength;
                        else
                            ispSendState <= data_waitAck;
                        end if;
                        
                    when data_writeLength =>
                        isp_send_addr <= incr_f(isp_send_addr);
                        isp_send_data <= isp_dout_addr(byteCounter*8+7 downto byteCounter*8);
                        isp_send_wea  <= "1";
                        if byteCounter < 3 then
                            byteCounter  := byteCounter + 1;
                            ispSendState <= data_writeLength;
                        else
                            byteCounter  := 0;
                            ispSendState <= data_writeData;
                        end if;

                    when data_writeData =>
                        if isp_dout_valid='1' then
                            isp_send_addr <= incr_f(isp_send_addr);
                            isp_send_data <= isp_dout;
                            isp_send_wea  <= "1";
                            isp_dout_ack  <= '1';
                            if byteCounter < 127 then
                                byteCounter  := byteCounter + 1;
                                ispSendState <= data_writeData;
                            else
                                byteCounter  := 0;
                                isp_startSending <= '1';
                                ispSendState <= idle;
                            end if;
                        end if;

                end case;
            end if;
        end if;
    end process;

end Behavioral;

--! @}
--! @}
