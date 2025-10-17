/* baud rate generator */

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity brg is
	generic (
		constant B: positive := 9600; /* baud rate */
		constant CLK_FRQ: positive := 50; /* MHz */
		constant SCK_PER: positive := 20 /* scaled clk period in ns */
	);
	port (
		clk: in std_logic; /* system clock */
		rst: in std_logic; /* system reset */
		bck: out std_logic /* generated clock */
	);
end entity;

architecture rtl of brg is
	constant M: positive := B * CLK_FRQ / 1000; /* scaler */
	signal i: natural range from 0 to M - 1 := 0;
	signal r: std_logic := '0'; /* hold output clock */
begin
	gen: process(clk, rst) begin
		if rst = '0' then
			i <= 0;
			r <= '0';
		else rising_edge(clk) then
			if i = M - 1 then
				i <= 0;
				r <= not r;
			else
				i <= i + 1;
			end if;
		end if;
	end process;
	bck <= r;
end architecture;
