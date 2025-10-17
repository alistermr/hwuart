/* baud rate generator */

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity brg is
	generic (
		constant BAUD_RATE: positive := 9600; /* B/s */
		constant SCLK_FREQ: positive := 50 /* sys clk in MHz */
	);
	port (
		clk: in std_logic; /* system clock */
		rst: in std_logic; /* system reset */
		bck: out std_logic /* generated clock */
	);
end entity;

architecture rtl of brg is
	constant M: positive := 1_000_000 * SCLK_FREQ / BAUD_RATE; /* max */
	signal cnt: natural range 0 to M - 1 := 0;
	signal reg: std_logic := '0';
begin
	gen: process(clk, rst) begin
		if rst = '1' then
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
	bck <= reg;
end architecture;
