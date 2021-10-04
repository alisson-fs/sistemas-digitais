LIBRARY ieee;
LIBRARY work;
USE work.constants.all;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY bo_div IS
PORT (
	clk : IN STD_LOGIC;
	mC, mA, cQ, cA, cB, cC, cR: IN STD_LOGIC;
	entA, entB : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
	AmaiorigualB, Bz : OUT STD_LOGIC;
	quociente, resto: OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
);
END bo_div;

ARCHITECTURE estrutura OF bo_div IS
	
	COMPONENT registrador_r IS
	PORT (
		clk,  reset, carga : IN STD_LOGIC;
		d : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		q : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT registrador IS
	PORT (
		clk, carga : IN STD_LOGIC;
		d : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		q : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT mux2para1 IS
	PORT (
		a, b : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		sel: IN STD_LOGIC;
		y : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT somadorsubtrator IS
	PORT (
		a, b : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		op: IN STD_LOGIC;
		s : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT igualazero IS
	PORT (
		a : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		igual : OUT STD_LOGIC
	);
	END COMPONENT;
	
	COMPONENT maiorigual IS
	PORT (
		a : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		b : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		amaiorigualb : OUT STD_LOGIC
	);
	END COMPONENT;
		
	SIGNAL 
		saimuxCont,
		saimuxA,
		sairegQ,
		sairegA,
		sairegB,
		sairegR,
		sairegCont,
		saisoma,
		saisub: STD_LOGIC_VECTOR (size-1 DOWNTO 0);

BEGIN
	muxA: mux2para1 PORT MAP (a => saisub, b => entA, sel => mA, y => saimuxA);
	muxCont: mux2para1 PORT MAP (
		a => saisoma,
		b => (others => '0'),
		sel => mC,
		y => saimuxCont
	);

	regA: registrador PORT MAP (
		clk => clk,
		carga => cA,
		d => saimuxA,
		q => sairegA
	);

	regB: registrador PORT MAP (
		clk => clk,
		carga => cB,
		d => entB,
		q => sairegB
	);

	regCont: registrador PORT MAP (
		clk => clk,
		carga => cC,
		d => saimuxCont,
		q => sairegCont
	);

	regQ: registrador PORT MAP (
		clk => clk,
		carga => cQ,
		d => sairegCont,
		q => sairegQ
	);

	regR: registrador PORT MAP (
		clk => clk,
		carga => cR,
		d => sairegA,
		q => sairegR
	);

	sub: somadorsubtrator PORT MAP (
		a => sairegA,
		b => sairegB,
		op => '1',
		s => saisub
	);

	soma: somadorsubtrator PORT MAP (
		a => sairegCont,
		b => (0 => '1', others => '0'),
		op => '0',
		s => saisoma
	);

	Amaior_igualB: maiorigual PORT MAP (
		a => sairegA,
		b => sairegB,
		amaiorigualb => AmaiorigualB
	);
	
	geraBz: igualazero PORT MAP (a => sairegB, igual => Bz);
	
	quociente <= sairegQ;
	resto <= sairegR;

END estrutura;