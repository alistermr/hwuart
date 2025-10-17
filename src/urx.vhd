/* uart rx */

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity urx is
	generic (
		-- pass
	);
	port (
		clk: in std_logic; /* system clock */
		rxs: in std_logic; /* rx serial in */
		rxd: out std_logic; /* data vector */
		rxb: out std_logic  /* rx out byte */
	);
end entity;

architecture rtl of urx is
	type s is (idle, startbit, databit, stopbit, flush);
end architecture;
		
