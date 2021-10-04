LIBRARY ieee;
LIBRARY work;
USE work.constants.all;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY bo IS
PORT (
	clk : IN STD_LOGIC;
	enPC, enA, enB, enOut, enOp, iniUla: IN STD_LOGIC;
	flagZ, flagN, flagO, pronto, erro: OUT STD_LOGIC;
	opcode : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	saida, resto: OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
);
END bo;

ARCHITECTURE estrutura OF bo IS
	
	COMPONENT ULA IS
	PORT (
		clk, iniUla: IN STD_LOGIC;
		a, b: IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		ULAop: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		saida, resto: OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		negativo, zero, overflow, pronto, erro: OUT STD_LOGIC
	);
	END COMPONENT;
		
	COMPONENT ROM IS
	PORT (
		address : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		data : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT registrador IS
	PORT (
		clk, carga : IN STD_LOGIC;
		d : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
		q : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT contador IS
	PORT (
		clk, carga : IN STD_LOGIC;
		q : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
	END COMPONENT;
	
	SIGNAL saiULAZ, saiULAN, saiULAO, saiULAP, saiULAErro: STD_LOGIC;
	
	SIGNAL sairegPC : STD_LOGIC_VECTOR (4 DOWNTO 0);
	
	SIGNAL 
		sairegA,
		sairegB,
		sairegOp,
		saiULAS,
		saiULAResto,
		saiROM,
		tempFlagZ,
		tempFlagO,
		tempFlagN : STD_LOGIC_VECTOR (size-1 DOWNTO 0);


BEGIN
	
	ULAA: ULA PORT MAP (
		clk => clk,
		iniUla => iniUla,
		a => sairegA,
		b => sairegB,
		ULAop => sairegOp(3 DOWNTO 0),
		negativo => saiULAN,
		zero => saiULAZ,
		overflow => saiULAO,
		pronto => saiULAP,
		erro => saiULAErro,
		saida => saiULAS,
		resto => saiULAResto
	);

	ROMM: ROM PORT MAP (address => sairegPC, data => saiROM);
	
	regPC: contador PORT MAP (clk => clk, carga => enPC, q => sairegPC);
	
	regA: registrador PORT MAP (
		clk => clk,
		carga => enA,
		d => saiROM,
		q => sairegA
	);

	regB: registrador PORT MAP (
		clk => clk,
		carga => enB,
		d => saiROM,
		q => sairegB
	);
	
	regOp: registrador PORT MAP (
		clk => clk,
		carga => enOp,
		d => saiROM,
		q => sairegOp
	);

	regS: registrador PORT MAP (
		clk => clk,
		carga => enOut,
		d => saiULAS,
		q => saida
	);

	regResto: registrador PORT MAP (
		clk => clk,
		carga => enOut,
		d => saiULAResto,
		q => resto
	);
	
	regZ: registrador PORT MAP (
		clk => clk,
		carga => enOut,
		d(0) => saiULAZ,
		d(size-1 downto 1)  => (others => '0'),
		q => tempFlagZ
	);

	regO: registrador PORT MAP (
		clk => clk,
		carga => enOut,
		d(0) => saiULAO,
		d(size-1 downto 1)  => (others => '0'),
		q => tempFlagO
	);

	regN: registrador PORT MAP (
		clk => clk,
		carga => enOut,
		d(0) => saiULAN,
		d(size-1 downto 1)  => (others => '0'),
		q => tempFlagN
	);
	
	flagN <= tempFlagN(0);
	flagZ <= tempFlagZ(0);
	flagO <= tempFlagO(0);
	pronto <= saiULAP;
	erro <= saiULAErro;
	
	opcode <= sairegOp(3 DOWNTO 0);
END estrutura;