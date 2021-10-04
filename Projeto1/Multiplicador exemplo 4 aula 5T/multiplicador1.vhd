LIBRARY IEEE;
LIBRARY work;
USE work.constants.all;
USE IEEE.Std_Logic_1164.ALL;

ENTITY multiplicador1 IS
PORT (
	clk, iniciar, reset : IN STD_LOGIC;
	pronto : OUT STD_LOGIC;
	entA, entB : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	mult: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
);
END multiplicador1;

ARCHITECTURE estrutura OF multiplicador1 IS

	COMPONENT bc IS PORT (
		clk : IN STD_LOGIC;
		iniciar, reset : IN STD_LOGIC;
		Az, Bz : IN STD_LOGIC;
		mP, mA, cB : OUT STD_LOGIC;
		cP : OUT STD_LOGIC;
		cA, op, m1, m2 : OUT STD_LOGIC;
		cmult : OUT STD_LOGIC;
		pronto : OUT STD_LOGIC
	);
	END COMPONENT;

	COMPONENT bo IS PORT (
		clk : IN STD_LOGIC;
      mP, mA, cB : IN STD_LOGIC;
		cP : IN STD_LOGIC;
		cA, op, m1, m2 : IN STD_LOGIC;
		cmult : IN STD_LOGIC;
		entA, entB : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      Az, Bz : OUT STD_LOGIC;
      mult: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
	);
	END COMPONENT;
	 
	SIGNAL s_mP, s_mA, s_cB, s_cP, s_cA, s_op, s_m1, s_m2, s_cmult, s_Az, s_Bz: STD_LOGIC;

BEGIN
	
	ctrl: bc PORT MAP (
		clk => clk,
		iniciar => iniciar, 
		reset => reset,
		Az => s_Az,
		Bz => s_Bz,
		mP => s_mP,
		mA => s_mA,
		cB => s_cB,
		cP => s_cP,
		cA => s_cA,
		op => s_op,
		m1 => s_m1,
		m2 => s_m2,
		cmult => s_cmult,
		pronto => pronto
	);
	
	dtp: bo PORT MAP (
		clk => clk,
		mP => s_mP,
		mA => s_mA,
		cB => s_cB,
		cP => s_cP,
		cA => s_cA,
		op => s_op,
		m1 => s_m1,
		m2 => s_m2,
		cmult => s_cmult,
		entA => entA,
		entB => entB,
		Az => s_Az,
		Bz => s_Bz,
		mult => mult
	);

END estrutura;