LIBRARY ieee;
LIBRARY work;
USE work.constants.all;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

-- TODO Setup file(package =>variaveis globais de pacote )

ENTITY bo IS
PORT (
		clk : IN STD_LOGIC;
		
      mP, mA, cB : IN STD_LOGIC;
		cP : IN STD_LOGIC;
		cA, op, m1, m2 : IN STD_LOGIC;
		cmult : IN STD_LOGIC;
		
		entA, entB : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		
      Az, Bz : OUT STD_LOGIC;
      mult: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END bo;


ARCHITECTURE estrutura OF bo IS
	
	COMPONENT registrador IS
	PORT (clk, carga : IN STD_LOGIC;
		  d : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		  q : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT mux2para1 IS
	PORT ( a, b : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
           sel: IN STD_LOGIC;
           y : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT somadorsubtrator IS
	PORT (a, b : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		  op: IN STD_LOGIC;
		  s : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
    COMPONENT igualazero IS
	PORT (a : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
          igual : OUT STD_LOGIC);
	END COMPONENT;
		
	SIGNAL saimuxA, saimuxB, saimuxP, saimuxPA, sairegP, sairegA, sairegB, sairegMult, saisomasub: STD_LOGIC_VECTOR (n-1 DOWNTO 0);

BEGIN
	muxA: mux2para1 PORT MAP (a => saisomasub, b => entA, sel => mA, y => saimuxA);
	muxB: mux2para1 PORT MAP (a => sairegB, b => (0 => '1', others => '0'), sel => m2, y => saimuxB);
	muxP: mux2para1 PORT MAP (a => saisomasub, b => (others => '0'), sel => mP, y => saimuxP);
	muxPA: mux2para1 PORT MAP (a => sairegP, b => sairegA, sel => m1, y => saimuxPA);
	
	regA: registrador PORT MAP (clk => clk, carga => cA, d => saimuxA, q => sairegA);
	regB: registrador PORT MAP (clk => clk, carga => cB, d => entB, q => sairegB);
	regP: registrador PORT MAP (clk => clk, carga => cP, d => saimuxP, q => sairegP);
	regMult: registrador PORT MAP (clk => clk, carga => cmult, d => sairegP, q => sairegMult);
	
	somasub: somadorsubtrator PORT MAP (a => saimuxPA, b => saimuxB, op => op, s => saisomasub);
	
	geraAz: igualazero PORT MAP (a => sairegA, igual => Az);
	geraBz: igualazero PORT MAP (a => sairegB, igual => Bz);
	
	mult <= sairegMult;

END estrutura;