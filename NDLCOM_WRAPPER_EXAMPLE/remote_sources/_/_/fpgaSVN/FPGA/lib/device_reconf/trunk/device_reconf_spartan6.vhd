---------------------------------------------------------------------------------
--! @file device_reconf_spartan6.vhd
--!
--! @brief   This module triggers an spartan6 device reconfiguration.
--! @details This module triggers an spartan6 device reconfiguration such that
--!          the configuration is reloaded like on power up.\n
--!          For additional information see ug380.\n\n
--!          German Research Center for Artificial Intelligence\n
--!          Project: iStruct
--!
--! @date   20.05.2013
--! @author Tobias Stark (tobias.stark@dfki.de)
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
Library UNISIM;
use UNISIM.vcomponents.all;

entity device_reconf_spartan6 is
    port ( clk : in  std_logic;       --! system clock
           rst : in  std_logic;       --! system reset

           reconf_trigger : in std_logic );  --! reconf device trigger
end device_reconf_spartan6;

architecture Behavioral of device_reconf_spartan6 is

    type icap_data_type is array (0 to 13) of std_logic_vector(15 downto 0);
    constant icap_reconf_data : icap_data_type :=
        ( x"ffff",   -- dummy word
          x"aa99",   -- sync word part 1
          x"5566",   -- sync word part 2
          x"3261",   -- write to GENERAL1 register
          x"0000",   -- boot start address [15:0]
          x"3281",   -- write to GENERAL2 register
          x"0b00",   -- fast read opcode and boot start address [23:16]
          x"32a1",   -- write to GENERAL3 register
          x"0000",   -- fallback start address [15:0]
          x"32c1",   -- write to GENERAL4 register
          x"0b00",   -- fase read opcode and fallback start address[23:16]
          x"30a1",   -- write to CMD register
          x"000e",   -- reboot command
          x"2000" ); -- noop
    
    --signal icap_busy : std_logic;
    signal icap_nce : std_logic;
    signal icap_nwe : std_logic;
    signal icap_din : std_logic_vector(15 downto 0);
    signal icap_din_reversed : std_logic_vector(15 downto 0);

    type reconf_states is (idle, reconf);
    signal reconf_state : reconf_states;
    
begin
    
    ICAP_SPARTAN6_inst : ICAP_SPARTAN6
        port map (
            BUSY  => open,               -- 1-bit output: Busy/Ready output
            O     => open,               -- 16-bit output: Configuartion data output bus
            CE    => icap_nce,           -- 1-bit input: Active-Low ICAP Enable input
            CLK   => clk,                -- 1-bit input: Clock input
            I     => icap_din_reversed,  -- 16-bit input: Configuration data input bus
            WRITE => icap_nwe );         -- 1-bit input: Read/Write control input

    -- need to reverse bits to ICAP module since D0 bit is read first
    icap_din_reversed(0) <= icap_din(7);
    icap_din_reversed(1) <= icap_din(6);
    icap_din_reversed(2) <= icap_din(5);
    icap_din_reversed(3) <= icap_din(4);
    icap_din_reversed(4) <= icap_din(3);
    icap_din_reversed(5) <= icap_din(2);
    icap_din_reversed(6) <= icap_din(1);
    icap_din_reversed(7) <= icap_din(0);
    icap_din_reversed(8) <= icap_din(15);
    icap_din_reversed(9) <= icap_din(14);
    icap_din_reversed(10) <= icap_din(13);
    icap_din_reversed(11) <= icap_din(12);
    icap_din_reversed(12) <= icap_din(11);
    icap_din_reversed(13) <= icap_din(10);
    icap_din_reversed(14) <= icap_din(9);
    icap_din_reversed(15) <= icap_din(8);

    reconf_proc : process (clk)
        variable i : integer range 0 to 13;
    begin
        if clk'event and clk='1' then
            if rst='1' then
                i := 0;
                icap_nce <= '1';
                icap_nwe <= '1';
                icap_din <= (others => '1');
                reconf_state <= idle;
            else
                -- defaults
                icap_nce <= '1';
                icap_nwe <= '1';

                case reconf_state is

                    when idle =>
                        if reconf_trigger='1' then
                            reconf_state <= reconf;
                        end if;

                    when reconf =>
                        icap_nce <= '0';
                        icap_nwe <= '0';
                        icap_din <= icap_reconf_data(i);
                        i := i + 1;

                end case;

            end if;
        end if;
    end process;

end Behavioral;
