/* uart rx */

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity urx is
	generic (
		constant BITWIDTH: positive := 8;
		constant SYS_CLK_FRQ: positive := 50; /* MHz */
		constant BAUD_RATE: positive := 9600; /* B/s */
	);
	port (
		clk: in std_logic; /* system clock */
		si: in std_logic; /* serial in */
		dv: out std_logic; /* data valid */
		bo: out std_logic /* byte out */
	);
end entity;

architecture rtl of urx is
	constant N: positive := SYS_CLK_FRQ / BAUD_RATE;

	type state is (idle, startbit, databit, stopbit, flush);
	signal s: state := idle;

	signal d: std_logic := '0'; /* rx serial data in */
	signal b: std_logic_vector(BITWIDTH - 1 downto 0) := (others => '0'); /*byte out*/

	signal idx: natural range 0 to BITWIDTH - 1 := 0;
	signal cnt: natural range 0 to N - 1 := 0;

begin
	/* read:  read rx serial data into rx data register */
	read: process(clk) begin
		if rising_edge(clk) then
			d <= si;
		end if;
	end process;

	/* main:  receiver state machine */
	main: process(clk) begin
		if rising_edge(clk) then
			case s is
				when idle =>
					d <= '0';
					cnt <= 0;
					idx <= 0;
				when startbit =>
					if cnt = (N - 1) / 2 then
						if d = '0' then
							cnt <= 0; /* middle */
							s <= databit;
						else
							s <= idle;
						end if;
					else
						cnt <= cnt + 1;
						s <= startbit;
					end if;

				when databit =>
					if cnt < N - 1 then
						cnt <= cnt + 1;
						s <= databit;
					else
						cnt <= 0;
						b <= /* TODO: fix this */
				when stopbit =>
					s <= idle;
				when flush =>
					-- pass
			end case;
		end if;
	end process;
end architecture;
