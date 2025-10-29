/* requirements */
-- must support the UART protocol.
	-- 1 start bit.
	-- 8 data bits.
	-- 1 stop bit.
	-- no parity bits.
-- must support baud rate of at least 9600.
-- must be able to store the byte to be transmitted.
-- must indicate with a signal that tx is busy.
-- should support parity control (even, odd, none).
-- should be able to change baud rate when running.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity utx is
	generic (
		constant BITWIDTH: positive := 8;
		constant SYS_CLK_FRQ: positive := 50; /* MHz */
		constant BAUD_RATE: positive := 9600; /* B/s */
	);
	port (
		clk: in std_logic; /* system clock */
		bi: out std_logic /* byte in */
		dv: out std_logic; /* data valid */
		so: in std_logic; /* serial out */
	);
end entity;

architecture rtl of utx is
	type state is (idle, startbit, databit, stopbit, flush);
	signal s: state := idle;	
begin
end architecture;