----------------------------------------------------------------------------------
--! @file    UART_mod.vhd
--!
--! @brief   UART module to send and receive data
--! @details UART module to send and receive data over a serial
--!          communication line (TX,RX).\n
--!          This UART module supports different baudrates and parities
--!          (EVEN and ODD) which can be set via .\n
--!          The receive process tries to synchronize the incoming
--!          data stream with the start bit edge.\n\n
--!          German Research Center for Artificial Intelligence\n
--!          Project: iStruct
--!
--! @date   02.09.2010
--! @author Tobias Stark (tobias.stark@dfki.de)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UART_mod is
    Generic ( SYSTEM_speed : integer := 16000000;       --! the system clock (in Hz)
              BAUD_rate    : integer := 115200;         --! the baud rate of this uart
              EVEN_parity  : integer := 0;              --! only one parity flag !
              ODD_parity   : integer := 0);             --! otherwise modul will fail
    Port ( CLK     : in  std_logic;                     --! system clock
           RST     : in  std_logic;                     --! system reset
           TX      : out std_logic;                     --! transmit data line
           RX      : in  std_logic;                     --! receive data line
           txData  : in  std_logic_vector(7 downto 0);  --! data to transmit
           txReady : out std_logic;                     --! transmit ready flag
           startTx : in  std_logic;                     --! start transmission signal
           rxData  : out std_logic_vector(7 downto 0);  --! received data
           newData : out std_logic;                     --! new data received flag
           dataAck : in  std_logic;                     --! acknowledge of received data signal
           rxErr   : out std_logic );                   --! receive error
end UART_mod;

architecture Behavioral of UART_mod is

    constant MAX_BIT_COUNT         : integer := (SYSTEM_speed + BAUD_rate/2)/BAUD_rate;
    constant MAX_HALF_BIT_COUNT    : integer := MAX_BIT_COUNT/2;
    constant MAX_QUARTER_BIT_COUNT : integer := MAX_BIT_COUNT/4;
    constant HALF_BIT_ADD_CYCLE    : integer := conv_integer(conv_std_logic_vector(MAX_BIT_COUNT,8)(0));

    constant MAX_BIT_ERROR      : integer := MAX_HALF_BIT_COUNT/10 +1; -- max number of errors that are allowed per bit (4)
    constant MAX_EDGE_COUNT     : integer := MAX_HALF_BIT_COUNT/20 +1; -- number of clock cycles to detect edges (5)
   
    constant MAX_DATA_COUNT     : integer := 8 + EVEN_parity+ODD_parity;

    type   txStates is (idle, startBit, dataBit, parityBit, stopBit);
    signal txState : txStates;

    type   rxStates is (idleState, startEdgeState, startCountState,
                        waitDataState, dataCountState, checkDataState,
                        stopCountState);
    signal rxState : rxStates;

    type   rxHandShakeStates is (idle, waitAck, waitTrigger);
    signal rxHandShakeState : rxHandShakeStates;
    
    signal triggerData : std_logic;
    signal rxData_int  : std_logic_vector(MAX_DATA_COUNT-1 downto 0);
    signal txData_int  : std_logic_vector(MAX_DATA_COUNT-1 downto 0);
    
    signal tmpRX1 : std_logic; -- 1. buffer for RX
    signal tmpRX2 : std_logic; -- 2. buffer for RX
    signal actRX  : std_logic;
    signal lastRX : std_logic;

    signal txReady_int : std_logic;
    signal newData_int : std_logic;
    
begin

    -- Einsynchronisieren des asynchronen RX signals!!
    -- (siehe http://www.lothar-miller.de/s9y/categories/35-Einsynchronisieren)
    syncProc : process (CLK)
    begin
        if CLK='1' and CLK'event then
            if RST='1' then
                tmpRX1 <= '0';           -- next rx
                tmpRX2 <= '0';           -- act rx
            else
                tmpRX1 <= RX;            -- next rx
                tmpRX2 <= tmpRX1;        -- act rx
            end if;
        end if;
    end process syncProc;

    -- 3 aus 5 Filter um glitches zu vermeiden
    inputFilter : process (CLK)
        variable counter : integer range 1 to 5;
    begin
        if CLK='1' and CLK'event then
            if RST='1' then
                counter := 3;
                actRX  <= '0';
                lastRX <= '0';
            else
                if tmpRX2='1' and counter<5 then
                    counter := counter + 1;
                elsif tmpRX2='0' and counter>1 then
                    counter := counter - 1;
                end if;
                if counter > 2 then
                    actRX <= '1';
                else
                    actRX <= '0';
                end if;
                lastRX <= actRX;
            end if;
        end if;
    end process inputFilter;

    -- ------------------------ --
    -- process that handles the --
    -- outgoing TX data stream  --
    -- ------------------------ --
    txMonitor : process (CLK, RST)
        variable dataBitCounter : integer range 0 to 7;
        variable waitCounter    : integer range 0 to MAX_BIT_COUNT;
        variable txParity       : std_logic;
    begin
        if RST='1' then
            TX             <= '1';
            txReady_int    <= '1';
            txData_int     <= (others => '0');
            txState        <= idle;
            dataBitCounter := 0;
            waitCounter    := 0;
            txParity       := '0';
            
        elsif CLK='1' and CLK'event then
            
            case txState is
                
                when idle =>
                    TX          <= '1';
                    txReady_int <= '1';
                    if startTx='1' then
                        TX             <= '0';
                        dataBitCounter := 0;
                        waitCounter    := 0;
                        txParity       := '0';
                        txReady_int    <= '0';
                        txData_int     <= txData;
                        txState        <= startBit;
                    else
                        txState        <= idle;
                    end if;
                    
                when startBit =>
                    TX <= '0';
                    if waitCounter < MAX_BIT_COUNT-1 then
                        waitCounter := waitCounter + 1;
                        txState     <= startBit;
                    else
                        waitCounter := 0;
                        txState     <= dataBit;
                    end if;
                    
                when dataBit =>
                    TX <= txData_int(dataBitCounter);
                    if waitCounter < MAX_BIT_COUNT-1 then
                        waitCounter := waitCounter + 1;
                        txState     <= dataBit;
                    else
                        waitCounter := 0;
                        if txData_int(dataBitCounter)='1' then
                            txParity := not txParity;
                        end if;
                        if dataBitCounter < 7 then
                            dataBitCounter := dataBitCounter + 1;
                            txState        <= dataBit;
                        elsif EVEN_parity=1 or ODD_parity=1 then
                            txState <= parityBit;
                        else
                            txState <= stopBit;
                        end if;
                    end if;
                    
                when parityBit =>
                    if EVEN_parity=1 then
                        TX <= txParity;
                    else
                        TX <= not txParity;
                    end if;
                    
                    if waitCounter < MAX_BIT_COUNT-1 then
                        waitCounter := waitCounter + 1;
                        txState     <= parityBit;
                    else
                        waitCounter := 0;
                        txState     <= stopBit;
                    end if;
                    
                when stopBit =>
                    -- set stop bit for only MAX_BIT_COUNT-1
                    -- to be ready to send next byte in time
                    TX <= '1';
                    if waitCounter < MAX_BIT_COUNT-2 then
                        waitCounter := waitCounter + 1;
                        txState     <= stopBit;
                    else
                        txReady_int <= '1';
                        txState     <= idle;
                    end if;
                    
            end case;
            
        end if;
    end process txMonitor;

    txReady <= txReady_int and not startTx;

    -- ------------------------ --
    -- process that handles the --
    -- incoming RX data stream  --
    -- ------------------------ --
    rxMonitor : process (CLK, RST)
        variable dataCounter  : integer range 0 to MAX_DATA_COUNT;
        variable edgeCounter  : integer range 0 to MAX_EDGE_COUNT;
        variable stateCounter : integer range 0 to 2*MAX_HALF_BIT_COUNT;
        variable ones         : integer range 0 to 2*MAX_HALF_BIT_COUNT;
        variable rxParity     : std_logic;
    begin
        if RST='1' then
            dataCounter  := 0;
            edgeCounter  := 0;
            stateCounter := 0;
            ones         := 0;
            rxParity     := '0';
            triggerData  <= '0';
            rxErr        <= '0';
            rxData_int   <= (others => '0');
            rxState      <= idleState;
            
        elsif CLK='1' and CLK'event then
            
            case rxState is
                
                when idleState =>
                    
                    dataCounter  := 0;
                    edgeCounter  := 0;
                    stateCounter := 0;
                    ones         := 0;
                    rxParity     := '0';
                    triggerData  <= '0';

                    if actRX='0' and lastRX='1' then
                        -- could be the beginning of the start bit
                        -- -> startEdgeState
                        rxState <= startEdgeState;
                    else
                        -- not the beginning of the start bit
                        -- -> remain idleState
                        rxState <= idleState;
                    end if;
                    
                when startEdgeState =>
                    
                    stateCounter := stateCounter + 1;
                    if actRX='1' then
                        -- was not the beginning of the transmission
                        -- -> idleState
                        rxState <= idleState;
                    elsif actRX='0' and edgeCounter < MAX_EDGE_COUNT then
                        -- perhaps it's really the start bit
                        -- -> again startEdgeState
                        edgeCounter := edgeCounter + 1;
                        rxState     <= startEdgeState;
                    else
                        -- it's really the start bit
                        -- -> startCountState
                        edgeCounter := 0;
                        ones        := 0;
                        rxErr       <= '0';
                        rxState     <= startCountState;
                    end if;
                    
                when startCountState =>
                    
                    if stateCounter < MAX_HALF_BIT_COUNT+MAX_QUARTER_BIT_COUNT then
                        -- remain in startCountState
                        stateCounter := stateCounter + 1;
                        rxState      <= startCountState;
                        if actRX='1' then
                            ones := ones + 1;
                        end if;
                    else
                        stateCounter := 0;
                        
                        if ones > MAX_BIT_ERROR then
                            -- ERROR -> idleState
                            rxErr   <= '1';
                            rxState <= idleState;
                        else
                            -- no error -> waitDataState;
                            rxState      <= waitDataState;
                        end if;
                    end if;
                    
                    --------------------------------
                    -- receive data 8bit + parity --
                    --------------------------------
                when waitDataState =>
                    
                    if stateCounter >= MAX_HALF_BIT_COUNT + HALF_BIT_ADD_CYCLE -1 then
                        stateCounter := 0;
                        ones := 0;

                        if dataCounter >= MAX_DATA_COUNT then
                            -- ... last bit -> checkDataState
                            rxState <= checkDataState;
                        else
                            -- ... not last bit -> dataCountState
                            rxState <= dataCountState;
                        end if;

                    else
                        stateCounter := stateCounter + 1;
                        rxState      <= waitDataState;
                    end if;
                    
                when dataCountState =>
                    
                    if stateCounter < MAX_HALF_BIT_COUNT-1 then
                        -- not the end of dataCountState
                        stateCounter := stateCounter + 1;
                        rxState      <= dataCountState;
                        if actRX='1' then
                            ones := ones + 1;
                        end if;
                    else
                        -- end of dataCountState ...
                        stateCounter := 0;
                        
                        if MAX_HALF_BIT_COUNT-ones <= MAX_BIT_ERROR then
                            -- ... detected '1' -> set bit and waitEdgeState(receiveDataState)
                            rxData_int(dataCounter) <= '1';
                            rxState      <= waitDataState;
                            if dataCounter < MAX_DATA_COUNT-EVEN_parity-ODD_parity then
                                rxParity := not rxParity;
                            end if;
                        elsif ones <= MAX_BIT_ERROR then
                            -- ... detected '0' -> set bit and waitEdgeState(receiveDataState)
                            rxData_int(dataCounter) <= '0';
                            rxState      <= waitDataState;
                            rxParity     := rxParity;
                        else
                            -- ... ERROR detected -> idleState
                            rxErr <= '1';
                            rxState <= idleState;
                        end if;
                        
                        dataCounter := dataCounter + 1;
                    end if;
                    
                when checkDataState =>
                    if EVEN_parity = 1 then
                        if rxParity = rxData_int(MAX_DATA_COUNT-1) then
                            rxState <= stopCountState;
                        else
                            rxErr   <= '1';
                            rxState <= idleState;
                        end if;
                    elsif ODD_parity = 1 then
                        if rxParity /= rxData_int(MAX_DATA_COUNT-1) then
                            rxState <= stopCountState;
                        else
                            rxErr   <= '1';
                            rxState <= idleState;
                        end if;
                    else
                        rxState <= stopCountState;
                    end if;
                    
                when stopCountState =>

                    if stateCounter < MAX_QUARTER_BIT_COUNT then
                        -- not the end of this state -> stopCountState
                        stateCounter := stateCounter + 1;
                        rxState     <= stopCountState;
                        if actRX='1' then
                            ones := ones + 1;
                        end if;
                    else
                        -- the end of this state ...
                        if MAX_QUARTER_BIT_COUNT - ones > MAX_BIT_ERROR then
                            -- ERROR -> idleState
                            stateCounter := 0;
                            rxState     <= idleState;
                            rxErr       <= '1';
                        else
                            -- no error -> idleState
                            stateCounter := 0;
                            rxState     <= idleState;
                            triggerData <= '1';
                        end if;
                        
                    end if;

            end case;
            
        end if;
    end process rxMonitor;


    -- ------------------------ --
    -- process that handles the --
    -- rx hand shake            --
    -- ------------------------ --
    rxHandShakeHandler : process (CLK, RST)
    begin
        if RST='1' then
            newData_int <= '0';
            rxData  <= (others => '0');
            rxHandShakeState <= idle;
            
        elsif CLK='1' and CLK'event then
            
            case rxHandShakeState is

                when idle =>
                    if triggerData='1' then
                        newData_int <= '1';
                        rxData  <= rxData_int(7 downto 0);
                        rxHandShakeState <= waitAck;
                    else
                        rxHandShakeState <= idle;
                    end if;
                    
                when waitAck =>
                    if dataAck='1' then
                        newData_int <= '0';
                        rxHandShakeState <= waitTrigger;
                    else
                        rxHandShakeState <= waitAck;
                    end if;
                    
                when waitTrigger =>
                    if dataAck='0' and triggerData='0' then
                        rxHandShakeState <= idle;
                    else
                        rxHandShakeState <= waitTrigger;
                    end if;
  
            end case;

        end if;
    end process rxHandShakeHandler;

    newData <= newData_int and not dataAck;

end Behavioral;

