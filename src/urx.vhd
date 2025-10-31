/* uart rx */
-- test
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity urx is
	generic (
		constant SCLK_FREQ: positive := 50; /* system clock in MHz */
		constant BAUD_RATE: positive := 9600; /* B/s */
	);
	port (
		clk: in std_logic; /* system clock */
		rxi: in std_logic; /* rx serial in */
		vld: out std_logic; /* data valid */
		rxb: out std_logic  /* rx out byte */
	);
end entity;

architecture rtl of urx is
	constant N: positive := SCLK_FREQ / BAUD_RATE;

	type state is (idle, startbit, databit, stopbit, flush);
	signal s: state := idle;

	signal d: std_logic := '0'; /* rx serial data in */
	signal b: std_logic_vector(7 downto 0) := (others => '0'); /*byte out*/

	signal i: natural range 0 to 7 := 0; /* index */
	signal c: natural range 0 to N - 1 := 0; /* counter */

begin
	read: process(clk) begin
		if rising_edge(clk) then
			d <= rxi; /* read rx serial into rx data */
		end if;
	end process;

	main: process(clk) begin
		if rising_edge(clk) then
			case s is
				when idle =>
					d <= '0';
					c <= 0;
					i <= 0;
				when startbit =>
					if c = (N - 1) / 2 then
						if d = '0' then
							c <= 0; /* middle */
							s <= databit;
						else
							s <= idle;
						end if;
					else
						c <= c + 1;
						s <= startbit;
					end if;

				when databit =>
					if c < N - 1 then
						c <= c + 1;
						s <= databit;
					else
						c <= 0;
						b <=
				when stopbit =>
					-- pass
				when flush =>
					-- pass
			end case;
		end if;
	end process;
end architecture;
