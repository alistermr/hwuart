/* vhdl 2008 */

library ieee;
use ieee.std_logic_1164.all;

entity clkd is
	generic (
		constant NUM_BIT: positive := 4;
		constant CLK_FRQ: positive := 50; /* MHz */
		constant SCK_PER: positive := 20; /* scaled clk period in ns */
	port (
		clk: in std_logic; /* system clock */
		rst: in std_logic; /* system reset */
		sck: out std_logic
	);
end entity;

architechture rtl of clkd is
	constant CLK_DIV: positive := 0;
	signal sck: std_logic := '0'; /* scaled clock */
	signal cnt: natural range from 0 to M - 1 := '0';
end architechture;
