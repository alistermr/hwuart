/* uart rx */

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity urx is
	generic (
		--pass
	);
	port (
		clk: in std_logic; /* system clock */
		rxs: in std_logic; /* rx serial in */
		rxd: out std_logic; /* data vector */
		rxb: out std_logic  /* rx out byte */
	);
end entity;

architecture rtl of urx is
	type state is (idle, startbit, databit, stopbit, flush);
	signal s: state := idle;
	signal rxd: std_logic := '0';
	signal rxb: std_logic_vector(7 downto 0) := (others => '0'); /* byte */
	signal i: natural range 0 to 7 := 0; /* one byte in total */
	--signal cnt: natural range 0 to ___ :=0;

end architecture;
		
