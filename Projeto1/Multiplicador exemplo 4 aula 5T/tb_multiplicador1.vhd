library ieee;
LIBRARY work;
USE work.constants.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_multiplicador is
end tb_multiplicador;

architecture tb of tb_multiplicador is
    signal clk, rst, iniciar, pronto: std_logic;
	 signal entA, entB, saida: std_logic_vector(n-1 downto 0);
begin
	-- conectando os sinais do test bench aos sinais do multiplicador
	UUT : entity work.multiplicador1 port map (clk => clk,
															reset => rst,
															pronto => pronto,
															iniciar => iniciar,
															entA => entA,
															entB => entB,
															mult => saida);

	rst <= '1', '0' after 10 ns;
	iniciar <= '1';
	entA <= (1 => '1', 0 => '1', others => '0');
	entB <= (1 => '1', 0 => '0', others => '0');
	
	-- processo gerador de clock
	tb1 : process
	constant periodo: time := 20 ns; -- periodo do clock
	begin
		clk <= '1';
		wait for periodo/2; -- 50% do periodo pra cada nivel
		clk <= '0';
		wait for periodo/2;
	end process;
end tb;