---------------------------------------------------------------------------------
--! @file fast_fifo.vhd
--! @author Tobias Stark (tobias.stark@dfki.de)
--! @date 14.01.2015

--! @brief A fifo which (can) provide one data-element per clock-cycle.
--!
--! This fifo module uses prefetching to be able to provide one data-elemebt per
--! clock-cycle on dout. Additionally bypassing is used to provide input data as
--! fast as possible on dout. This module uses a block-ram to store most part of
--! the data.\n
--! The size of this fifo is 2^ADDRWIDTH+2. The remaining size could be read
--! at the remaining output port.\n
--! USAGE: If the fifo is not empty the first data-element could be read directly
--! on dout. After reading dout the rd-signal must be set to indicate that the
--! data-element was read. In the next clock-cycle the next data-element could be
--! read on dout (if the fifo is not empty).\n
--! ATTENTION: If you use a process to read the data. The read-signal takes one
--! extra cycle to be recognized by this module. Therefore you have to use an
--! idle-cycle in your reading process (like with a bram).
--!
--! German Research Center for Artificial Intelligence
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fast_fifo is
    generic ( ADDRWIDTH : natural := 10;
              DATAWIDTH : natural := 8 );
    port ( clk    : in  std_logic;                               -- system clock
           rst    : in  std_logic;                               -- system reset
           wr     : in  std_logic;                               -- write flag
           din    : in  std_logic_vector(DATAWIDTH-1 downto 0);  -- input data
           rd     : in  std_logic;                               -- read flag (after data was read)
           dout   : out std_logic_vector(DATAWIDTH-1 downto 0);  -- output data
           empty  : out std_logic;                               -- empty flag
           full   : out std_logic;                               -- full flag
           remaining : out std_logic_vector(ADDRWIDTH downto 0) );  -- remaining size (max 2^ADDRWIDTH+2)
end fast_fifo;

architecture Behavioral of fast_fifo is

    type Array3x8 is array(0 to 2) of std_logic_vector(DATAWIDTH-1 downto 0);
    
    signal full_int : std_logic;

    signal waddr : unsigned(ADDRWIDTH-1 downto 0);
    signal raddr : unsigned(ADDRWIDTH-1 downto 0);
    signal wdata : std_logic_vector(DATAWIDTH-1 downto 0);
    signal rdata : std_logic_vector(DATAWIDTH-1 downto 0);
    
    -- signal which shows if a valid data from bram is in the prefetch state
    signal prefetch : std_logic_vector(1 downto 0);

    -- shift register for output data
    signal data_out : Array3x8;
    
begin

    dout      <= data_out(0);
    full_int  <= '1' when raddr=waddr+1 else '0';
    full      <= full_int;

    blockram : entity work.bram_dp_simple
        generic map ( ADDRWIDTH => ADDRWIDTH,
                      DATAWIDTH => DATAWIDTH )
        port map ( clk   => clk,
                   we    => '1',
                   waddr => std_logic_vector(waddr),
                   wdata => wdata,
                   raddr => std_logic_vector(raddr),
                   rdata => rdata );

    fifo_access : process ( clk )
        variable data_count    : natural range 0 to 3;  -- counter to show how much valid data is available
        variable remaining_int : natural range 0 to 2**ADDRWIDTH+2;
    begin
        if clk'event and clk='1' then
            if rst='1' then
                data_count    := 0;
                remaining_int := 2**ADDRWIDTH+2;
                remaining     <= std_logic_vector(to_unsigned(remaining_int,ADDRWIDTH+1));
                empty         <= '1';

                waddr <= (others => '0');
                wdata <= (others => '0');
                raddr <= (others => '0');

                prefetch <= "00";
                data_out <= (others => (others => '0'));
            else

                -- first read (from buffers)
                -- -------------------------
                if rd='1' and data_count>0 then
                    -- buffers are not empty
                    data_out <= data_out(1 to 2) & x"00";
                    data_count    := data_count-1;
                    remaining_int := remaining_int+1;
                end if;

                -- write into fifo(-buffers)
                -- -------------------------
                if wr='1' and full_int='0' then
                    remaining_int := remaining_int-1;
                    if data_count<3 and prefetch="00" and waddr=raddr then
                        -- we can bypass the bram and write din
                        -- directly into the buffers
                        data_out(data_count) <= din;
                        data_count := data_count+1;
                    else
                        -- write din into bram
                        waddr <= waddr+1;
                        wdata <= din;
                    end if;
                end if;

                -- try to (pre-)fetch from bram
                -- ----------------------------
                if prefetch(1)='1' then
                    -- output on bram is valid
                    data_out(data_count) <= rdata;
                    data_count := data_count+1;
                end if;

                -- handle prefetching of next data
                -- -------------------------------
                if data_count<2 or rd='1' then
                    -- we have buffers free and could
                    -- try to prefetch from bram
                    if waddr/=raddr then
                        raddr    <= raddr+1;
                        prefetch <= prefetch(0) & '1';
                    else
                        -- no more data in bram
                        prefetch <= prefetch(0) & '0';
                    end if;
                else
                    -- all buffers are full
                    prefetch <= prefetch(0) & '0';
                end if;

                -- set some output signals
                -- -----------------------
                if data_count=0 then
                    -- no data in buffers -> we are empty
                    empty <= '1';
                else 
                    empty <= '0';
                end if;
                remaining <= std_logic_vector(to_unsigned(remaining_int,ADDRWIDTH+1));
                
            end if;
        end if;
    end process;

end;
