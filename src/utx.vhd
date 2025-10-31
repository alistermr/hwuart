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

library work;
use work.uart_pkg.all;

entity utx is
	port (
		clk: in std_logic; /* system clock */
		bi: in std_logic_vector(BITWIDTH-1 downto 0); /* byte in */
		dv: in std_logic; /* data valid */
		bs: out std_logic; /* busy */
		so: out std_logic; /* serial out */
	);
end entity;

architecture rtl of utx is
	signal s: state_t := idle;

	signal d: std_logic := '1'; /* serial data out, active low */


begin
	so <= d; /* put bit */

	main: process(clk) begin
		if rising_edge(clk) then
			bs <= '0' when s = idle else '1';

end architecture;