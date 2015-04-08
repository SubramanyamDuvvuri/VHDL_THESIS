---------------------------------------------------------------------------------
--! @file UART_HS_mod.vhd
--! @date 2011

--! @addtogroup group_NDLCom
--! @{

--! @addtogroup group_NDLCom_UART_HS_MOD
--! @{

--! @class   NDLCom_EndNode
--! @brief   A VHDL module that controls the highspeed UART.
--!
--! A VHDL module that controls the highspeed UART.\n\n
--!
--! German Research Center for Artificial Intelligence\n
--! Project: LIMES
--!
--! @date   11.03.2014
--! @author Hendrik Hanff (hendrik.hanff@dfki.de)
---------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use ieee.std_logic_textio.all;

library work;
use work.NDLCom_config.all;
use work.crc_pack.all;
use work.dfki_pack.all;

library std;
use std.textio.all;                     --include package textio.vhd

library decode_8b10b;

library zynq;
library spartan6;

entity uart_hs_mod is

  generic (
    DEVICE_ZYNQ : boolean := true;  --! If true, the device used will be a ZYNQ
    BAUD_rate   : integer := 115200;    --! the baud rate of this uart
    CLK_FREQ    : natural := 20_000_000);
  port (
    txPPin  : out std_logic;
    txNPin  : out std_logic;
    rxPPin  : in  std_logic;
    rxNPin  : in  std_logic;
    txData  : in  std_logic_vector(7 downto 0);  --! data to transmit
    txReady : out std_logic;            --! transmit ready flag
    startTx : in  std_logic;            --! start transmission signal
    rxData  : out std_logic_vector(7 downto 0);  --! received data
    newData : out std_logic;            --! new data received flag
    dataAck : in  std_logic;            --! acknowledge of received data signal
    rxErr   : out std_logic;
--    clkRx   : out std_logic;
--    rstRx   : out std_logic;
    clk     : in  std_logic;
    rst     : in  std_logic);

end entity uart_hs_mod;

architecture behaviour of uart_hs_mod is
  constant ASYNCH_DATA_WORD      : std_logic := '0';
  constant ASYNCH_K_WORD         : std_logic := not ASYNCH_DATA_WORD;
  constant SLOW_GEN_DELAY_CYCLES : natural   := 1;

  -- Spartan 6 clk signals
  signal clkDoubleDR_ioce : std_logic;
  signal clkDoubleDR_io   : std_logic;

  -- Zynq and Spartan 6 signals
  signal clk20MHz_in      : std_logic;
  signal clkFullDR        : std_logic;
  signal clkHalfDR        : std_logic;
  signal clkCommInterface : std_logic;
  signal clk20MHz         : std_logic;
  signal reset            : std_logic;
  signal nreset_in        : std_logic;

  -- Zynq signals
  signal clk200MHz : std_logic;

  signal decoderWordOut       : std_logic_vector(7 downto 0);
  signal decoderKOut          : std_logic;
  signal decoderCodeErr       : std_logic;
  signal decoderDispErr       : std_logic;
  signal decoderNewDataStrobe : std_logic;
  signal linkIndicator        : std_logic;
  signal linkIndicatorErrorSR : std_logic_vector(9 downto 0);

  signal encoderData          : std_logic_vector(7 downto 0);
  signal encoderKIn           : std_logic;
  signal encoderNewDataStrobe : std_logic;

  signal rxData_s : std_logic_vector(7 downto 0);

  signal txData_cnt_s : integer range 0 to 256 := 0;
  signal startTx_s                  : std_logic_vector(1 downto 0) := "00";  -- For edge detection
  signal startTx_flag               : std_logic                    := '0';
  signal txReady_slow, txReady_fast : std_logic;  --! transmit ready flag

  signal newData_s : std_logic;

  type decoderKOut_t is record
    decoderKOut          : std_logic_vector(1 downto 0);
    decoderWordOut       : std_logic_vector(15 downto 0);
    decoderNewDataStrobe : std_logic_vector(1 downto 0);
  end record decoderKOut_t;

  signal decoderKOut_s : decoderKOut_t;

  signal rx_din   : std_logic_vector(8 downto 0);
  signal rx_wren  : std_logic;
  signal rx_rden  : std_logic;
  signal rx_dout  : std_logic_vector(8 downto 0);
  signal rx_full  : std_logic;
  signal rx_empty : std_logic;

  signal newData_int      : std_logic;
  type rxHandShakeStates is (idle, waitAck, waitTrigger);
  signal rxHandShakeState : rxHandShakeStates;

begin  -- architecture behaviour

  device_zynq_gen : if DEVICE_ZYNQ = true generate
    basic_clk_reset_mod : entity zynq.basic_clk_reset_mod
      port map (
        clk_in           => clk20mhz_in,
        nreset_in        => nreset_in,
        clkFullDR        => clkFullDR,
        clkHalfDR        => clkHalfDR,
        clkCommInterface => clkCommInterface,
        clk20MHz         => clk20MHz,
        clk200MHz        => clk200MHz,
        reset            => reset);
    asynch_sercomm_tx_top_1 : entity zynq.asynch_sercomm_tx_top
      generic map (
        -- Wie viele Takte brauche ich um auf encoderNewDataStrobe zu reagieren?
        SLOW_GEN_DELAY_CYCLES => SLOW_GEN_DELAY_CYCLES)
      port map (
        clkfulldr            => clkFulldr,
        clkHalfDR            => clkHalfDR,
        clkCommInterface     => clkCommInterface,
        reset                => reset,
        txPPin               => txPPin,
        txNPin               => txNPin,
        encoderWordIn        => encoderData,
        encoderKIn           => encoderKIn,
        encoderNewDataStrobe => encoderNewDataStrobe);

    asynch_sercomm_rx_top_1 : entity zynq.asynch_sercomm_rx_top
      generic map (
        INSTANTIATE_IDELAYCTRL => true  -- Instantiate IDELAYCTRL
        )
      port map (
        clkfulldr            => clkfulldr,
        clkHalfDR            => clkHalfDR,
        clkCommInterface     => clkCommInterface,
        clk200MHz            => clk200MHz,
        reset                => reset,
        rxPPin               => rxPPin,
        rxNPin               => rxNPin,
        decoderWordOut       => decoderWordOut,
        decoderKOut          => decoderKOut,
        decoderCodeErr       => decoderCodeErr,
        decoderDispErr       => decoderDispErr,
        decoderNewDataStrobe => decoderNewDataStrobe);
  end generate device_zynq_gen;

  device_spartan6_gen : if DEVICE_ZYNQ = false generate
    basic_clk_reset_mod_1 : entity spartan6.basic_clk_reset_mod
      port map (
        clk20MHz_in      => clk20MHz_in,
        nreset_in        => nreset_in,
        clkDoubleDR_io   => clkDoubleDR_io,
        clkDoubleDR_ioce => clkDoubleDR_ioce,
        clkHalfDR        => clkHalfDR,
        clkCommInterface => clkCommInterface,
        clk20MHz         => open,
        reset            => reset);

    asynch_sercomm_rx_top_spartan6 : entity spartan6.asynch_sercomm_rx_top
      port map (
        clkHalfDR            => clkHalfDR,
        clkDoubleDR_ioce     => clkDoubleDR_ioce,
        clkDoubleDR_io       => clkDoubleDR_io,
        clkCommInterface     => clkCommInterface,
        reset                => reset,
        rxPPin               => rxPPin,
        rxNPin               => rxNPin,
        decoderWordOut       => decoderWordOut,
        decoderKOut          => decoderKOut,
        decoderCodeErr       => decoderCodeErr,
        decoderDispErr       => decoderDispErr,
        decoderNewDataStrobe => decoderNewDataStrobe);
    asynch_sercomm_tx_top_spartan6 : entity spartan6.asynch_sercomm_tx_top
      generic map (
        SLOW_GEN_DELAY_CYCLES => SLOW_GEN_DELAY_CYCLES)
      port map (
        clkHalfDR            => clkHalfDR,
        clkDoubleDR_ioce     => clkDoubleDR_ioce,
        clkDoubleDR_io       => clkDoubleDR_io,
        clkCommInterface     => clkCommInterface,
        reset                => reset,
        txPPin               => txPPin,
        txNPin               => txNPin,
        encoderWordIn        => encoderData,
        encoderKIn           => encoderKIn,
        encoderNewDataStrobe => encoderNewDataStrobe);
  end generate device_spartan6_gen;

  -- Aufgabe
  -- Zwei Statemachines bauen die
  -- (i)  Rx StateMachine
  -- (ii) Tx StateMachine

  -- purpose: Handles the outgoing data stream
  --          - Die Tx StateMachine muss die Signale
  --            - encoderData
  --              - encoderData muss alle 256 Bytes ein IDLE/START_OF_FRAME schicken
  --              - encoderData muss IDLE f??hren wenn keine Daten gesendet werden.
  --              - encoderData f??hrt die zu sendenden Daten in allen ??brigen F??llen.
  --            - encoderKIn
  --              - encoderKIn muss '1' sein, wenn ein Kontrollwort an encoderData anliegt
  --              - encoderKIn muss '0' sein, wenn kein Kontrollwort  an encoderData anliegt
  --            - encoderNewDataStrobe Mit encoderNewDataStrobe gibt der Sender vor wann er bereit ist
  --              ein neues Datenbyte zu verschicken. Also genau andersherum als beim Original
  --              UART Modul.
  --            - startTx wird von extern gesetzt. Es zeigt an, ob es neue zu
  --              versendende Daten gibt.

  -- type   : sequential
  -- inputs : clkCommInterface, reset
  -- outputs:
  fsm_tx_p : process (clkCommInterface) is
    variable txData_cnt_v : integer range 0 to 256 := 0;
  begin  -- process fsm_tx_p
    if rising_edge(clkCommInterface) then  -- rising clock edge
      if reset = '1' then                  -- synchronous reset (active high)
        if DEVICE_ZYNQ = true then
          encoderData  <= zynq.asynch_sercomm_config_pack.ASYNCH_SERCOMM_K_IDLE;
        else
          encoderData  <= spartan6.asynch_sercomm_config_pack.ASYNCH_SERCOMM_K_IDLE;
        end if;
        encoderKIn   <= ASYNCH_K_WORD;
        txReady_fast <= '1';
      else
        txData_cnt_s <= txData_cnt_v;
        txReady_fast <= encoderNewDataStrobe;

        -- Edge detection for clock domain crossing
        startTx_s <= startTx_s(0) & startTx;

        if encoderNewDataStrobe = '1' then
          -- Every 256th data byte must be an idle worde. Also send idle worde
          -- when no data is present for being sent via comm I/f
          if txData_cnt_v = 256 or (detect_pos_edge_func(startTx_s) = '0' and startTx_flag = '0') then
            txData_cnt_v := 0;
            encoderKin   <= '1';

            if DEVICE_ZYNQ = true then
              encoderData  <= zynq.asynch_sercomm_config_pack
                              .ASYNCH_SERCOMM_K_IDLE;
            else
              encoderData  <= spartan6.asynch_sercomm_config_pack.ASYNCH_SERCOMM_K_IDLE;
            end if;
            -- If txData_cnt_v = 255 and startTx_s = '1', one tx byte will be
            -- lost. The startTx_flag is set to prevent this
            if detect_pos_edge_func(startTx_s) = '1' or startTx_flag = '1' then
              startTx_flag <= '1';
            else
              startTx_flag <= '0';
            end if;
          else
            startTx_flag <= '0';
            txData_cnt_v := txData_cnt_v+1;
            encoderKin   <= '0';
            encoderData  <= txData;
          end if;
        else
          -- Preserve startTx_flag when the transceiver is not ready to send
          if detect_pos_edge_func(startTx_s) = '1' or startTx_flag = '1' then
            startTx_flag <= '1';
          else
            startTx_flag <= '0';
          end if;
        end if;
      end if;
    end if;
  end process fsm_tx_p;

  -- purpose: Synchronizes (stretches) the signals which go to the instantiating entity
  -- type   : sequential
  -- inputs : clk20MHz, reset
  -- outputs:
  sync_to_slow_clk_p : process (clkCommInterface) is
    variable txReady_v : std_logic_vector(zynq.asynch_sercomm_config_pack.CLK_PLLFREQ/zynq.asynch_sercomm_config_pack.CLK_LO_FREQ_HZ downto 0) := (others => '0');
  begin  -- process sync_to_sys_clk_p
    if rising_edge(clkCommInterface) then  -- rising clock edge
      if reset = '1' then                  -- synchronous reset (active high)
        txReady_slow <= '1';
        txReady_v    := (others => '0');
      else

        txReady_v := txReady_v(txReady_v'left-1 downto 0) & txReady_fast;
        if to_uint(txReady_v) /= 0 then
          txReady_slow <= '1';
        else
          txReady_slow <= '0';
        end if;
      end if;
    end if;
  end process sync_to_slow_clk_p;
  txReady <= txReady_slow;

  rx_valid_link_indicator_proc : process(clkCommInterface, reset)
  begin
    if(reset = '1') then
      linkIndicatorErrorSR <= (others => '0');
      linkIndicator        <= '0';
    elsif(clkCommInterface'event and clkCommInterface = '1') then
      if(decoderNewDataStrobe = '1') then
        if(decoderCodeErr = '1' or decoderDispErr = '1') then
          linkIndicatorErrorSR <= (others => '0');
        else
          linkIndicatorErrorSR <= linkIndicatorErrorSR(linkIndicatorErrorSR'left-1 downto 0) & '1';
        end if;
      end if;

      linkIndicator <= linkIndicatorErrorSR(linkIndicatorErrorSR'left-1);
    end if;
  end process;

  -- Stores data which was received via UART
  -- The instantiating module reads from here
  hs_rx_buf : entity work.fifo
    port map (
      clk   => clkCommInterface,
      srst  => reset,
      wr_en => rx_wren,
      din   => rx_din,

      rd_en => rx_rden,
      dout  => rx_dout,
      full  => open,  --ethTxBufError, --? Was machen wenn voll?
      empty => rx_empty
      );

  -- purpose: Detect new data
  -- type   : sequential
  -- inputs : clk, rst
  -- outputs:
  newData_p : process (clkCommInterface) is
  begin  -- process newData_p
    if rising_edge(clkCommInterface) then  -- rising clock edge
      if reset = '1' then                  -- synchronous reset (active high)
        decoderKOut_s.decoderKOut    <= (others => '0');
        decoderKOut_s.decoderWordOut <= (others => '0');
        rx_wren                      <= '0';
      else
        rx_wren <= '0';

        if(decoderNewDataStrobe = '1' and linkIndicator = '1') then
          if(decoderCodeErr = '0' and decoderDispErr = '0') then  -- Nur empfangen solange kein Fehler auftritt
            if(decoderKOut = '1' and decoderWordOut = zynq.asynch_sercomm_config_pack.ASYNCH_SERCOMM_K_IDLE) then
              rx_wren            <= '0';
            -- Idle Frame. Nicht speichern
            else
              -- Kein Idle Frame. Byte im FiFo speichern.
              rx_wren            <= '1';
              rx_din(7 downto 0) <= decoderWordOut(7 downto 0);
              rx_din(8)          <= decoderKOut;

            end if;
          end if;
        end if;
      end if;
    end if;
  end process newData_p;

  -- ------------------------ --
  -- process that handles the --
  -- rx hand shake            --
  -- ------------------------ --
  rxHandShakeHandler : process (clkCommInterface)
  begin
    if clkCommInterface = '1' and clkCommInterface'event then
      if reset = '1' then
        newData_int      <= '0';
        rxData_s         <= (others => '0');
        rxHandShakeState <= idle;

      else
        rx_rden <= '0';

        case rxHandShakeState is
          when idle =>
            -- Read data from FIFO and trigger instantiating module when FIFO is not empty
            if rx_empty = '0' then
              newData_int      <= '1';
              rx_rden          <= '1';
              rxData_s         <= rx_dout(7 downto 0);
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
            --if dataAck='0' and triggerData='0' then
            --? Hab nich verstanden was triggerData macht.
            if dataAck = '0' then
              rxHandShakeState <= idle;
            else
              rxHandShakeState <= waitTrigger;
            end if;

        end case;

      end if;
    end if;
  end process rxHandShakeHandler;
  --? Hier noch weitere Synchronisierung notwendig.
  newData <= newData_int and not dataAck;
  rxData <= rxData_s;

  -- Errors are handled internally. rxErr is only maintained for compatibility reasons
  rxErr <= '0';

  --clkRx       <= clkCommInterface;
  --rstRx       <= reset;
  clk20MHz_in <= clk;
  nreset_in   <= not rst;
end architecture behaviour;
