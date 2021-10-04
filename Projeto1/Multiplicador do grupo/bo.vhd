LIBRARY ieee;
LIBRARY work;
USE work.constants.all;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY bo IS
PORT (clk : IN STD_LOGIC;
		mP, mA, cP, cA, cB: IN STD_LOGIC;
      entA, entB : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      Az, Bz : OUT STD_LOGIC;
      saida: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END bo;

ARCHITECTURE estrutura OF bo IS
	
	COMPONENT registrador_r IS
	PORT (clk,  reset, carga : IN STD_LOGIC;
		  d : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		  q : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT;
	
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
		
	SIGNAL saimuxP, saimuxA, sairegP, sairegA, sairegB, saisoma, saisub: STD_LOGIC_VECTOR (n-1 DOWNTO 0);

BEGIN
	muxP: mux2para1 PORT MAP (a => saisoma, b => (others => '0'), sel => mP, y => saimuxP);
	muxA: mux2para1 PORT MAP (a => saisub, b => entA, sel => mA, y => saimuxA);	
	regP: registrador PORT MAP (clk => clk, carga => cP, d => saimuxP, q => sairegP);
	regA: registrador PORT MAP (clk => clk, carga => cA, d => saimuxA, q => sairegA);
	regB: registrador PORT MAP (clk => clk, carga => cB, d => entB, q => sairegB);
	soma: somadorsubtrator PORT MAP (a => sairegP, b => sairegB, op => '0', s => saisoma);
	sub: somadorsubtrator PORT MAP (a => sairegA, b => (0 => '1', others => '0'), op => '1', s => saisub);
	geraAz: igualazero PORT MAP (a => sairegA, igual => Az);
	geraBz: igualazero PORT MAP (a => sairegB, igual => Bz);	
	
	saida <= sairegP;

END estrutura;