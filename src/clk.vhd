/* vhdl 2008 */

library ieee;
use ieee.std_logic_1164.all;

entity clkd is
	port (
		clk: in std_logic; /* system clock */
		rst: in std_logic; /* system reset */
		sck: out std_logic
	);
end entity;

