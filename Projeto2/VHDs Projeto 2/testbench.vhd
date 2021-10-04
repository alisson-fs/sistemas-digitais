library ieee;
library work;
use work.constants.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity testbench is
end testbench;

architecture tb of testbench is
	signal clk, reset, inicio: STD_LOGIC;
	signal flagZ, flagN, flagO, flagErro: STD_LOGIC;
	signal saida, resto: STD_LOGIC_VECTOR(size-1 DOWNTO 0);
begin
	UUT : entity work.projeto2 port map (clk => clk,
													reset => reset,
													inicio => inicio,
													resto => resto,
													flagZ => flagZ,
													flagO => flagO,
													flagN => flagN,
													flagErro=> flagErro,
													saida => saida);

	reset <= '0';
	inicio <= '1', '0' after 50 ns;
	
	-- processo gerador de clock
	tb1 : process
	constant periodo: time := 8 ns; -- periodo do clock
	begin
		clk <= '1';
		wait for periodo/2; -- 50% do periodo pra cada nivel
		clk <= '0';
		wait for periodo/2;
	end process;
end tb;
