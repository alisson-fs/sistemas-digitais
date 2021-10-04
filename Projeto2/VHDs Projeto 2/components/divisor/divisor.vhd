LIBRARY IEEE;
LIBRARY work;
USE work.constants.all;
USE IEEE.Std_Logic_1164.ALL;

ENTITY divisor IS PORT (
	clk, inicio, reset : IN STD_LOGIC;
	pronto, erro : OUT STD_LOGIC;
	entA, entB : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
	quociente, resto: OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
);
END divisor;

ARCHITECTURE estrutura OF divisor IS

	COMPONENT bc_div IS
	PORT (
		Reset, clk, inicio : IN STD_LOGIC;
	  	AmaiorigualB, Bz : IN STD_LOGIC;
		mC, mA, cC, cQ, cR, cA, cB, pronto, erro: out STD_LOGIC
	);
	END COMPONENT;

	COMPONENT bo_div IS
	PORT (
		clk : IN STD_LOGIC;
		mC, mA, cC, cQ, cR, cA, cB: IN STD_LOGIC;
		entA, entB : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		AmaiorigualB, Bz : OUT STD_LOGIC;
		quociente, resto: OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
	);
	END COMPONENT;
	 
	SIGNAL 
		sinal_mC,
		sinal_mA,
		sinal_cC,
		sinal_cQ,
		sinal_cR,
		sinal_cA,
		sinal_cB,
		sinal_Amaior_igualB,
		sinal_Bz: STD_LOGIC;

BEGIN
	dtp: bo_div PORT MAP (
		clk => clk,
		mC => sinal_mC,
		mA => sinal_mA,
		cQ => sinal_cQ,
		cC => sinal_cC,
		cR => sinal_cR,
		cA => sinal_cA,
		cB => sinal_cB,
		entA => entA,
		entB => entB,
		AmaiorigualB => sinal_Amaior_igualB,
		Bz => sinal_Bz,
		quociente => quociente,
		resto => resto
	);
	ctrl: bc_div PORT MAP (
		Reset => reset, 
		clk => clk, 
		inicio => inicio,
		AmaiorigualB => sinal_Amaior_igualB, 
		Bz => sinal_Bz,
		mC => sinal_mC,
		mA => sinal_mA,
		cC => sinal_cC,
		cQ => sinal_cQ,
		cR => sinal_cR,
		cA => sinal_cA,
		cB => sinal_cB,
		pronto => pronto,
		erro => erro
	);
END estrutura;