LIBRARY ieee;
USE work.constants.all;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;


ENTITY ULA IS
PORT(
	a, b: IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
	ULAop: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	saida, resto: OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0);
	negativo, zero, overflow, pronto, erro: OUT STD_LOGIC;
	clk, iniUla: IN STD_LOGIC
);
END ULA;

ARCHITECTURE arch OF ULA IS

	COMPONENT multiplicador IS
	PORT (
		clk, inicio, reset : IN STD_LOGIC;
		entA, entB : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		pronto : OUT STD_LOGIC;
		saida: OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT divisor IS
	PORT (
		clk, inicio, reset : IN STD_LOGIC;
		entA, entB : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		pronto, erro : OUT STD_LOGIC;
		quociente, resto: OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
	);
	END COMPONENT;

	SIGNAL 
		temp_saida,
		temp_mult,
		temp_div,
		temp_resto,
		temp_resto_div: STD_LOGIC_VECTOR(size-1 DOWNTO 0);
	
	SIGNAL 
		may_overflow,
		temp_inicio_mult,
		temp_inicio_div,
		temp_pronto,
		temp_pronto_mult,
		temp_pronto_div,
		temp_erro,
		temp_erro_div: STD_LOGIC;

BEGIN	

	mult: multiplicador PORT MAP (
		clk => clk,
		inicio => iniUla,
		reset => '0',
		entA => a,
		entB => b,
		saida => temp_mult,
		pronto => temp_pronto_mult
	);
	
	div: divisor PORT MAP (
		clk => clk,
		inicio => iniUla,
		reset => '0',
		entA => a,
		entB => b,
		quociente => temp_div,
		resto => temp_resto_div,
		pronto => temp_pronto_div,
		erro => temp_erro_div
	);

	PROCESS (a, b, ULAop) 
	BEGIN
		temp_erro <= '0';
		temp_pronto <= '1';
		temp_resto <= (OTHERS => '0');
		may_overflow<= '1';
		
		CASE ULAop IS
			WHEN "0000" =>
				temp_saida <= a + b;

			WHEN "0001" =>
				temp_saida <= a - b;

			WHEN "0010" =>
				temp_saida <= a + '1';

			WHEN "0011" =>
				temp_saida <= a - '1';

			WHEN "0100" =>
				temp_saida <= not a;
				may_overflow<= '0';

			WHEN "0101" =>
				temp_saida <= a and b;
				may_overflow<= '0';

			WHEN "0110" =>
				temp_saida <= a or b;
				may_overflow<= '0';

			WHEN "0111" =>
				temp_saida <= a xor b;
				temp_pronto <= '1';
				may_overflow<= '0';

			WHEN "1000" =>
				temp_saida <= temp_mult;
				temp_pronto <= temp_pronto_mult;

			WHEN "1001" =>
				temp_saida <= temp_div;
				temp_pronto <= temp_pronto_div;
				temp_erro <= temp_erro_div;
				temp_resto <= temp_resto_div;

			WHEN OTHERS =>
				temp_saida <= (others => '0');
				temp_erro <= '1';
		END CASE;
	END PROCESS;
	
	resto <= temp_resto;
	erro <= temp_erro;
	pronto <= temp_pronto;
	
	negativo <= '1' WHEN temp_saida(size-1) = '1' ELSE '0';
	
	zero <= '1' WHEN unsigned(temp_saida) = 0 ELSE '0';
	
	overflow <= (((NOT a(size-1)) AND (NOT b(size-1)) AND temp_saida(size-1)) OR
				   (a(size-1) AND b(size-1) AND (NOT temp_saida(size-1)))) AND may_overflow;

	saida <= temp_saida;
	
END arch;