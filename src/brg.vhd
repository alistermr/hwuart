/* baud rate generator */

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_numeric.all;

entity brg is
	generic (
		constant BDR: positive := 9600; /* baud rate */
		constant CLK_FRQ: positive := 50; /* MHz */
		constant SCK_PER: positive := 20; /* scaled clk period in ns */
	port (
		clk: in std_logic; /* system clock */
		rst: in std_logic; /* system reset */
		bck: out std_logic /* generated clock */
	);
end entity;

architecture rtl of brg is
	constant M: positive := BRD * CLK_FRQ / 1000; /* scaler */
	signal cnt: natural range from 0 to M - 1 := '0';
	signal bck: std_logic := '0';  /* 'baud' clock */
begin
	gen: process(clk, rst) begin
		if rst = '0' then
			cnt <= 0;
			bck <= '0';
		else rising_edge(clk) then
			if cnt = M - 1 then
				cnt <= 0;
				bck <= not bck;
			else
				cnt <= cnt + 1;
			end if;
		end if;
	end process;
	bck <= bck;
end architecture;
