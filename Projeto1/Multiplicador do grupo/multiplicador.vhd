LIBRARY IEEE;
LIBRARY work;
USE work.constants.all;
USE IEEE.Std_Logic_1164.ALL;

ENTITY multiplicador IS PORT (
	clk, inicio, reset : IN STD_LOGIC;
	pronto : OUT STD_LOGIC;
	entA, entB : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	saida: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
);
END multiplicador;

ARCHITECTURE estrutura OF multiplicador IS

	COMPONENT bc IS PORT (
		Reset, clk, inicio : IN STD_LOGIC;
      Az, Bz : IN STD_LOGIC;
		mP, mA, cP, cA, cB, pronto: out STD_LOGIC
	);
	END COMPONENT;

	COMPONENT bo IS PORT (
		clk : IN STD_LOGIC;
		mP, mA, cP, cA, cB: IN STD_LOGIC;
      entA, entB : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      Az, Bz : OUT STD_LOGIC;
      saida: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
	);
	END COMPONENT;
	 
	SIGNAL sinal_mP, sinal_mA, sinal_cP, sinal_cA, sinal_cB, sinal_Az, sinal_Bz: STD_LOGIC;

BEGIN
	dtp: bo PORT MAP (
		clk => clk,
		mP => sinal_mP,
		mA => sinal_mA,
		cP => sinal_cP,
		cA => sinal_cA,
		cB => sinal_cB,
		entA => entA,
		entB => entB,
		Az => sinal_Az, 
		Bz => sinal_Bz,
		saida => saida
	);
	
	ctrl: bc PORT MAP (
		Reset => reset, 
		clk => clk, 
		inicio => inicio,
		Az => sinal_Az, 
		Bz => sinal_Bz,
		mP => sinal_mP,
		mA => sinal_mA,
		cP => sinal_cP,
		cA => sinal_cA,
		cB => sinal_cB,
		pronto => pronto
	);

END estrutura;