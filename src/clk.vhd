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
	constant M: positive := CLK_FRQ * SCK_PER / 1000;  /* scaler */
	signal sck: std_logic := '0';  /* scaled clock */
	signal cnt: natural range from 0 to M - 1 := '0';

begin
	/* presc:  prescale clock */
	presc: process(clk, rst) begin
		if rst = '0' then
			cnt <= 0;
			sck <= '0';
		else rising_edge(clk) then
			if cnt = M - 1 then
				cnt <= 0;
				sck <= not sck;
			else
				i <= i + 1;
			end if;
		end if;
	end process;

end architechture;
