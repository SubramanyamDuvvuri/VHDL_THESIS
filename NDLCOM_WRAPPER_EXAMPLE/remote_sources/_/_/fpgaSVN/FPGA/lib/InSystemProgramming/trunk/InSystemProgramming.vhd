---------------------------------------------------------------------------------
--! @file InSystemProgramming.vhd
--!
--! @brief  InSystemProgramming module
--! @author Tobias Stark (tobias.stark@dfki.de)
--! @date   29.10.2014
--!
--! This module provides the InSystemProgramming functionality that comes
--! with the NDLCom framework (could also be used without).\n\n
--! German Research Center for Artificial Intelligence\n
--!
--! $LastChangedRevision: 3686 $
--! $LastChangedBy: tstark $
--! $LastChangedDate: 2014-12-10 15:20:31 +0100 (Wed, 10 Dec 2014) $
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InSystemProgramming is
    port ( clk : in std_logic;
           rst : in std_logic;

           -- signals to be connected with the communication interface (e.g. NDLCom)
           cmd_upload   : in  std_logic;  --! ISP command trigger (high for one clock cycle)
           cmd_data     : in  std_logic;  --! ISP data trigger (high for one clock cycle)
           cmd_download : in  std_logic;  --! ISP download trigger (high for one clock cycle)
           cmd_ack      : out std_logic;  --! ISP ack signal to acknowledge one of the above trigger
           din_addr     : in  std_logic_vector(31 downto 0);
           din_len      : in  std_logic_vector(31 downto 0);
           din          : in  std_logic_vector(7 downto 0);
           din_valid    : in  std_logic;
           din_ack      : out std_logic;
           dout_addr    : out std_logic_vector(31 downto 0);
           dout         : out std_logic_vector(7 downto 0);
           dout_valid   : out std_logic;
           dout_ack     : in  std_logic;

           -- signals to be connected with the prom (e.g. simple_spiprom_interface)
           prom_request       : out std_logic;
           prom_access        : in  std_logic;
           prom_key_input     : out std_logic_vector(3 downto 0);
           prom_read_trigger  : out std_logic;
           prom_erase_trigger : out std_logic;
           prom_write_trigger : out std_logic;
           prom_busy          : in  std_logic;
           prom_address       : out std_logic_vector(23 downto 0);
           prom_din_offset    : out std_logic_vector(6 downto 0);
           prom_din           : out std_logic_vector(7 downto 0);
           prom_din_we        : out std_logic;
           prom_dout_offset   : out std_logic_vector(6 downto 0);
           prom_dout          : in  std_logic_vector(7 downto 0) );
end InSystemProgramming;

architecture Behavioral of InSystemProgramming is

    type isp_states is (idle, prom_erase, isp_read, wait_prom,
                        prom_read, isp_write, isp_waitAck);
    signal isp_state  : isp_states;
    
    signal dout_valid_int : std_logic;

begin

    dout_valid <= dout_valid_int and not dout_ack;
    
    -- process that handles the isp commands
    -- and the spi prom access
    ispHandler : process (clk)
        variable idleFlag        : std_logic;
        variable waitPromAccess  : std_logic;
        variable counter         : integer range 0 to 127;
    begin
        if clk'event and clk='1' then
            if rst='1' then
                idleFlag        := '0';
                waitPromAccess  := '0';
                counter         := 0;

                prom_request       <= '0';
                prom_key_input     <= (others => '0');
                prom_erase_trigger <= '0';
                prom_write_trigger <= '0';
                prom_read_trigger  <= '0';
                prom_address       <= (others => '0');
                prom_din_offset    <= (others => '0');
                prom_din           <= (others => '0');
                prom_din_we        <= '0';
                prom_dout_offset   <= (others => '0');
                
                cmd_ack    <= '0';
                din_ack    <= '0';
                dout_addr  <= (others => '0');
                dout       <= (others => '0');
                dout_valid_int <= '0';
                isp_state      <= idle;
            else
                -- defaults
                prom_erase_trigger <= '0';
                prom_write_trigger <= '0';
                prom_read_trigger  <= '0';
                prom_din_we        <= '0';
                cmd_ack    <= '0';
                din_ack    <= '0';
                dout_valid_int <= '0';

                if idleFlag='1' then
                    idleFlag:='0';
                elsif waitPromAccess='1' then
                    -- wait till we can access the prom
                    if prom_access='1' and prom_busy='0' then
                        waitPromAccess  := '0';
                    end if;
                else
                    
                    case isp_state is

                        when idle =>
                            prom_key_input <= (others => '0');
                            prom_request   <= '0';
                            
                            -- wait for next isp instruction
                            if cmd_upload='1' then
                                prom_request <= '1';
                                waitPromAccess := '1';
                                counter        := 0;
                                isp_state      <= prom_erase;
                            elsif cmd_data='1' then
                                prom_request <= '1';
                                waitPromAccess := '1';
                                counter        := 0;
                                isp_state      <= isp_read;
                            elsif cmd_download='1' then
                                prom_request <= '1';
                                waitPromAccess := '1';
                                counter        := 0;
                                isp_state      <= prom_read;
                            end if;

                            -- -------------- --
                            --      ERASE     --
                            -- -------------- --
                        when prom_erase =>
                            -- trigger as many sector erase cycles as are
                            -- necessary to erase din_len bytes
                            if prom_busy='0' then
                                prom_address   <= std_logic_vector(unsigned(din_addr(23 downto 0)) +
                                                                       (to_unsigned(counter,8)&x"0000"));
                                prom_key_input     <= "1010";
                                prom_erase_trigger <= '1';
                                idleFlag           := '1';
                                if to_unsigned(counter,8) < unsigned(din_len(23 downto 16)) then
                                    counter   := counter + 1;
                                    isp_state <= prom_erase;
                                else
                                    isp_state <= wait_prom;
                                end if;
                            end if;

                            -- -------------- --
                            --     UPLOAD     --
                            -- -------------- --
                        when isp_read =>
                            -- read data from ISP interface and trigger
                            -- a page write at address isp_din_addr
                            if din_valid='1' then
                                prom_din_offset <= std_logic_vector(to_unsigned(counter,7));
                                prom_din        <= din;
                                prom_din_we     <= '1';
                                din_ack         <= '1';
                                idleFlag            := '1';
                                if counter < 127 then
                                    counter   := counter + 1;
                                    isp_state <= isp_read;
                                else
                                    prom_key_input <= "1010";
                                    prom_address   <= din_addr(23 downto 0);
                                    prom_write_trigger <= '1';
                                    isp_state <= wait_prom;
                                end if;
                            end if;

                        when wait_prom =>
                            -- wait till prom is not busy and
                            -- acknowledge the isp package
                            if prom_busy='0' then
                                dout_addr <= din_addr;
                                cmd_ack <= '1';
                                isp_state   <= idle;
                            else
                                isp_state <= wait_prom;
                            end if;

                            -- -------------- --
                            --    DOWNLOAD    --
                            -- -------------- --
                        when prom_read =>
                            -- trigger a page read at din_addr
                            prom_key_input <= "1010";
                            dout_addr      <= din_addr;
                            prom_address   <= din_addr(23 downto 0);
                            prom_read_trigger <= '1';
                            prom_dout_offset <= (others => '0');
                            idleFlag          := '1';
                            isp_state         <= isp_write;

                        when isp_write =>
                            -- write data from prom buffer to the isp
                            -- buffer and trigger isp sending
                            if prom_busy='0' then
                                dout       <= prom_dout;
                                dout_valid_int <= '1';
                                if counter < 127 then
                                    counter := counter + 1;
                                    prom_dout_offset <= std_logic_vector(to_unsigned(counter,7));
                                    isp_state <= isp_waitAck;
                                else
                                    cmd_ack <= '1';
                                    isp_state   <= idle;
                                end if;
                            end if;

                        when isp_waitAck =>
                            if dout_ack='1' then
                                isp_state <= isp_write;
                            else
                                dout_valid_int <= '1';
                                isp_state <= isp_waitAck;
                            end if;

                    end case;

                end if;
            end if;
        end if;
    end process;

end Behavioral;
