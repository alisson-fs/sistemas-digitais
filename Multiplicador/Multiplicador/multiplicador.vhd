LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;

ENTITY multiplicador IS PORT (
	clk, inicio, reset : IN STD_LOGIC;
	pronto : OUT STD_LOGIC;
	entA, entB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	saida, conteudoA, conteudoB : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
);
END multiplicador;

ARCHITECTURE estrutura OF multiplicador IS

	COMPONENT bc IS PORT (
		Reset, clk, inicio : IN STD_LOGIC;
		Az, Bz : IN STD_LOGIC;
		pronto : OUT STD_LOGIC;
		ini, CA, dec, CP: OUT STD_LOGIC
	);
	END COMPONENT;

	COMPONENT bo IS PORT (
		clk : IN STD_LOGIC;
      ini, CP, CA, dec : IN STD_LOGIC;
      entA, entB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      Az, Bz : OUT STD_LOGIC;
      saida, conteudoA, conteudoB : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
	END COMPONENT;
	 
	SIGNAL sinal_pronto, sinal_ini, sinal_CA, sinal_dec, sinal_CP, sinal_Az, sinal_Bz: STD_LOGIC;

BEGIN
	dtp: bo PORT MAP (
		clk => clk,
		ini => sinal_ini,
		CP => sinal_CP,
		CA => sinal_CA,
		dec => sinal_dec,
		entA => entA,
		entB => entB,
		Az => sinal_Az, 
		Bz => sinal_Bz,
		saida => saida,
		conteudoA => conteudoA,
		conteudoB => conteudoB
	);
	
	ctrl: bc PORT MAP (
		Reset => reset, 
		clk => clk, 
		inicio => inicio,
		Az => sinal_Az, 
		Bz => sinal_Bz,
		pronto => pronto, 
		ini => sinal_ini, 
		CA => sinal_CA, 
		dec => sinal_dec, 
		CP => sinal_CP
	);

END estrutura;