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

	);
	port (

	);
end entity;

architecture rtl of utx is
begin
end architecture;