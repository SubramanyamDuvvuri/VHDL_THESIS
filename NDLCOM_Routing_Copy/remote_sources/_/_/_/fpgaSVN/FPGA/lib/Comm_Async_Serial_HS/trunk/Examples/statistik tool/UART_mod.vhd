-------------------------------------------------------------------------------
-- Title      : Uart interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : uart_mod.vhd
-- Author     : Jan Hahlbeck (jan.hahlbeck@dfki.de)
-- Company    : DFKI Bremen
-- Created    : 2010-12-12
-- Last update: 2011-01-16
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------
-- Copyright (c) 2010 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author           Description
-- 2010-12-12  1.0      jhahlbeck        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
-- Entity
-------------------------------------------------------------------------------
entity uart_mod is
  generic (CLK_FREQ : integer := 18500000;
           BAUDRATE : integer := 115200);  
  port (
    -- general ports
    clk_i       : in  std_logic;
    rst_i       : in  std_logic;
    -- tx ports
    tx_o        : out std_logic;        -- transmit data line        
    txData_i    : in  std_logic_vector(7 downto 0);  -- data to transmit
    txReady_o   : out std_logic;        -- transmit ready flag
    txStart_i   : in  std_logic;        -- start transmission signal
    -- rx ports
    rx_i        : in  std_logic;        -- receive data line
    rxData_o    : out std_logic_vector(7 downto 0);  -- received data
    rxNewData_o : out std_logic;        -- new data received flag
    rxDataAck_i : in  std_logic;        -- acknowledge of received data signal
    rxErr_o     : out std_logic);       -- receive error
end uart_mod;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture Behavioral of uart_mod is

  -----------------------------------------------------------------------------
  -- Constants
  -----------------------------------------------------------------------------

  -- sample values
  constant BIT_COUNT_DIV1 : integer := CLK_FREQ/BAUDRATE - 1;
  constant BIT_COUNT_DIV2 : integer := CLK_FREQ/BAUDRATE/2 - 1;
  constant BIT_COUNT_DIV4 : integer := CLK_FREQ/BAUDRATE/4 - 1;
  constant MAX_BIT_ERROR  : integer := BIT_COUNT_DIV2/3;  -- 33% errors allowed

  -----------------------------------------------------------------------------
  -- Signals
  -----------------------------------------------------------------------------

  -- tx signals
  signal txWaitCnt : integer range 0 to BIT_COUNT_DIV1;
  signal txBitCnt  : integer range 0 to 7;

  type txStates is (idle, startBit, dataBit, stopBit);
  signal txState : txStates;

  -- rx signals 
  signal rxInput   : std_logic_vector(7 downto 0);
  signal rxTrigger : std_logic;
  signal rxSync    : std_logic;
  signal rxWeight  : integer range 0 to 5;
  signal sampleCnt : integer range 0 to BIT_COUNT_DIV2 + BIT_COUNT_DIV4;
  signal dataCnt   : integer range 0 to 8;
  signal highCnt   : integer range 0 to BIT_COUNT_DIV2;

  type rxStates is (idle, startBit, waitState, dataBit, stopBit, resetCycle);
  signal rxState    : rxStates;
  type rxAckStates is (idle, waitAck);
  signal rxAckState : rxAckStates;

  -- debug signals
  signal txState_as_vector    : std_logic_vector(3 downto 0);
  signal rxState_as_vector    : std_logic_vector(3 downto 0);
  signal rxAckState_as_vector : std_logic_vector(1 downto 0);

begin

  txReady_o <= '1' when (txState=idle and txStart_i='0') else '0';
  -----------------------------------------------------------------------------
  -- Transmit FSM
  -----------------------------------------------------------------------------
  txMonitor : process (clk_i)
  begin
    if rising_edge(clk_i) then
      -- sync reset
      if rst_i = '1' then
        txState   <= idle;
        tx_o      <= '1';
--        txReady_o <= '1';
        txBitCnt  <= 0;
        txWaitCnt <= 0;
      else
        -- debug signal
        txState_as_vector <= std_logic_vector(to_unsigned(txStates'pos(txState), 4));

        case txState is
          
          when idle =>
            ---------------------------------------------------------------------
            -- State 0: Idle and wait for tx request
            ---------------------------------------------------------------------

            if txStart_i = '1' then
              tx_o      <= '0';
--              txReady_o <= '0';
              txState   <= startBit;
            end if;
            
          when startBit =>
            -------------------------------------------------------------------
            -- State 1: Send startbit
            -------------------------------------------------------------------

            -- check if max cnt value is reached
            if txWaitCnt < BIT_COUNT_DIV1 then
              txWaitCnt <= txWaitCnt + 1;
            else
              txWaitCnt <= 0;
              txState   <= dataBit;
              tx_o      <= txData_i(txBitCnt);
            end if;
            
          when dataBit =>
            -------------------------------------------------------------------
            -- State 2: Send data bits
            -------------------------------------------------------------------

            -- check if max cnt value is reached
            if txWaitCnt < BIT_COUNT_DIV1 then
              txWaitCnt <= txWaitCnt + 1;
            else
              txWaitCnt <= 0;
              -- check if all bits are transmitted              
              if txBitCnt < 7 then
                txBitCnt <= txBitCnt + 1;
                tx_o     <= txData_i(txBitCnt + 1);
              else
                txBitCnt <= 0;
                txState  <= stopBit;
                tx_o     <= '1';
              end if;
            end if;
            
          when stopBit =>
            -------------------------------------------------------------------
            -- State 3: Send stop bit
            -------------------------------------------------------------------

            -- check if max cnt value is reached
            if txWaitCnt < BIT_COUNT_DIV1 then
              txWaitCnt <= txWaitCnt + 1;
            else
              txWaitCnt <= 0;
--              txReady_o <= '1';
              txState   <= idle;
            end if;
            
        end case;
      end if;
    end if;
  end process txMonitor;

  -----------------------------------------------------------------------------
  -- 3-of-5 rx sample filter with shifter
  -----------------------------------------------------------------------------
  process (clk_i) is
  begin  -- process
    if rising_edge(clk_i) then
      -- sync reset
      if rst_i = '1' then
        rxWeight <= 0;
        rxInput  <= (others => '0');
      else
        -- increase or decrease rxWeight
        if rx_i = '1' and rxWeight < 5 then
          rxWeight <= rxWeight + 1;
        elsif rx_i = '0' and rxWeight > 0 then
          rxWeight <= rxWeight - 1;
        end if;
        -- rx shifter with respect to rxWeight
        if rxWeight > 2 then
          rxInput <= rxInput(6 downto 0) & '1';
        else
          rxInput <= rxInput(6 downto 0) & '0';
        end if;
      end if;
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- Receive FSM
  -----------------------------------------------------------------------------
  rxMonitor : process (clk_i)
  begin
    if rising_edge(clk_i) then
      -- sync reset
      if rst_i = '1' then
        -- initial state
        rxState   <= idle;
        -- reset signals
        rxTrigger <= '0';
        rxSync    <= '0';
        -- reset output ports
        rxErr_o   <= '0';
        rxData_o  <= (others => '0');
        -- reset counter
        sampleCnt <= 0;
        highCnt   <= 0;
        dataCnt   <= 0;
      else
        -- debug signal
        rxState_as_vector <= std_logic_vector(to_unsigned(rxStates'pos(rxState), 4));

        case rxState is
          when idle =>
            -------------------------------------------------------------------
            -- State 0: Idle and wait for a falling edge (start bit)
            -------------------------------------------------------------------

            -- check rx input for a falling edge
            if rxInput(1 downto 0) = "10" then
              rxState <= startBit;
              sampleCnt <= 1;
            end if;
            
          when startBit =>
            -------------------------------------------------------------------
            -- State 1: Check if falling edge results in a start bit
            -------------------------------------------------------------------

            -- sample 3/4 bit
            if sampleCnt < (BIT_COUNT_DIV2 + BIT_COUNT_DIV4) then
              sampleCnt <= sampleCnt + 1;
              -- sum up bit errors
              if rxInput(0) = '1' then
                if highCnt > MAX_BIT_ERROR then
                  rxErr_o <= '1';
                  rxState <= resetCycle;
                else
                  highCnt <= highCnt + 1;
                end if;
              end if;
            else
              -- start bit detected
              rxState   <= waitState;
              sampleCnt <= 0;
              highCnt   <= 0;
            end if;

          when waitState =>
            -------------------------------------------------------------------
            -- State 2: Wait for bit/2 and try to sync if there is a stable edge
            -------------------------------------------------------------------

            if sampleCnt < BIT_COUNT_DIV2 then
              -- increase counter
              sampleCnt <= sampleCnt + 1;
              -- try to sync
              if rxSync = '0' then
                if rxInput = "00001111" or rxInput = "11110000" then
                  sampleCnt <= BIT_COUNT_DIV4 + 4;
                  rxSync    <= '1';
                end if;
              end if;
            else
              -- wait time reached
              sampleCnt <= 0;
              rxSync    <= '0';
              -- check if all data bits are sampled
              if dataCnt < 8 then
                rxState <= dataBit;
              else
                dataCnt <= 0;
                rxState <= stopBit;
              end if;
            end if;
            
          when dataBit =>
            -------------------------------------------------------------------
            -- State 3: Receive a data bit
            -------------------------------------------------------------------

            if sampleCnt < BIT_COUNT_DIV2 then
              sampleCnt <= sampleCnt + 1;
              if rxInput(0) = '1' then
                highCnt <= highCnt + 1;
              end if;
            else
              sampleCnt <= 0;
              highCnt   <= 0;
              rxState   <= waitState;
              dataCnt   <= dataCnt + 1;

              -- sampling complete, check highCnt
              if (BIT_COUNT_DIV2 - highCnt) <= MAX_BIT_ERROR then
                -- '1' was sampled
                rxData_o(dataCnt) <= '1';
              elsif highCnt <= MAX_BIT_ERROR then
                -- '0' was sampled
                rxData_o(dataCnt) <= '0';
              else
                -- sample error
                rxErr_o <= '1';
                rxState <= resetCycle;
              end if;
            end if;

          when stopBit =>
            -------------------------------------------------------------------
            -- State 4: Receive the stop bit
            -------------------------------------------------------------------

            if sampleCnt < BIT_COUNT_DIV2 then
              sampleCnt <= sampleCnt + 1;
              if rxInput(0) = '0' then
                if highCnt > MAX_BIT_ERROR then
                  -- stop bit error
                  rxErr_o <= '1';
                  rxState <= resetCycle;
                else
                  highCnt <= highCnt + 1;
                end if;
              end if;
            else
              -- stop bit detected
              rxState   <= resetCycle;
              rxTrigger <= '1';
            end if;

          when resetCycle =>
            -------------------------------------------------------------------
            -- State 5: cycle to reset flags and counters
            -------------------------------------------------------------------
            highCnt   <= 0;
            rxTrigger <= '0';
            rxErr_o   <= '0';
            rxState   <= idle;

        end case;
      end if;
    end if;
  end process rxMonitor;

  -----------------------------------------------------------------------------
  -- Acknowledge handshake
  -----------------------------------------------------------------------------
  ackProcess : process (clk_i) is
  begin  -- process ackProcess
    if rising_edge(clk_i) then
      -- sync reset
      if rst_i = '1' then
        rxAckState <= idle;
      else
        -- debug signal
        rxAckState_as_vector <= std_logic_vector(to_unsigned(rxAckStates'pos(rxAckState), 2));

        case rxAckState is
          when idle =>
            -------------------------------------------------------------------
            -- State 0: Wait for new received data
            -------------------------------------------------------------------

            -- check if rx data is available
            if rxTrigger = '1' then
              rxAckState <= waitAck;
            end if;
            
          when waitAck =>
            -------------------------------------------------------------------
            -- State 1: Wait for a external ackowlede
            -------------------------------------------------------------------

            if rxDataAck_i = '1' then
              rxAckState <= idle;
            end if;
            
        end case;
      end if;
    end if;
  end process ackProcess;

  rxNewData_o <= '1' when rxAckState = waitAck else '0';

end Behavioral;

