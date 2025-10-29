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
		bi: in std_logic_vector(BITWIDTH-1 downto 0); /* byte in */
		dv: in std_logic; /* data valid */
		bs: out std_logic; /* busy */
		so: out std_logic; /* serial out */
	);
end entity;

architecture rtl of utx is
	constant NSAMP: positive := 8; /* Nx oversampling */
	constant NVOTE: positive := 5; /* majority votes */
	constant CLK_PER_BIT: positive := SYS_CLK_FRQ * 1000000 / BAUD_RATE;
	constant CLK_PER_SAMP: positive := CLK_PER_BIT / NSAMP; /* cycles/samp */

	type state is (idle, startbit, databit, stopbit, flush);
	signal s: state := idle;

	signal d: std_logic := '1'; /* serial data out, active low */


begin
	so <= d; /* put bit */

	main: process(clk) begin
		if rising_edge(clk) then
			bs <= '0' when s = idle else '1';

end architecture;