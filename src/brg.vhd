/* baud rate generator */

/*
 * TODO:
 * rename file and some signals to fit with other source files
*/

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity brg is
	generic (
		constant BAUD_RATE: positive := 9600; /* B/s */
		constant SYS_CLK_FRQ: positive := 50  /* MHz */
	);
	port (
		sclk: in std_logic; /* system clock */
		rstn: in std_logic; /* system reset */
		gclk: out std_logic /* generated clock */
	);
end entity;

architecture rtl of brg is
	constant MAX: positive := 1_000_000 * SYS_CLK_FRQ / BAUD_RATE; /* max */
	signal cnt: natural range 0 to M - 1 := 0;
	signal reg: std_logic := '0';
begin
	clkgen: process(sclk, rstn) begin
		if rstn = '0' then
			cnt <= 0;
			reg <= '0';
		elsif rising_edge(clk) then
			if cnt = M - 1 then
				cnt <= 0;
				reg <= not reg;
			else
				cnt <= cnt + 1;
				/*
				 * uncomment to generate one pulse per baud
				 * instead of a square wave clock signal
				 */
				--reg <= '0'; /* pulse */
			end if;
		end if;
	end process;
	gclk <= reg;
end architecture;
