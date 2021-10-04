LIBRARY ieee;
USE work.constants.all;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;


ENTITY projeto2 IS
PORT (
	clk, reset, inicio: IN STD_LOGIC;
	flagZ, flagN, flagO, flagErro: OUT STD_LOGIC;
	saida, resto: OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
);
END projeto2;

ARCHITECTURE arch OF projeto2 IS

	COMPONENT bo IS
	PORT (
        clk : IN STD_LOGIC;
        enPC, enA, enB, enOut, enOp, iniUla: IN STD_LOGIC;
        flagZ, flagN, flagO, pronto, erro: OUT STD_LOGIC;
        opcode : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        saida, resto: OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
    );
	END COMPONENT;
	
	COMPONENT bc IS
	PORT (
        clk, reset, inicio, pronto : IN STD_LOGIC;
        opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        enPC, enA, enB, enOut, enOp, iniUla: OUT STD_LOGIC
    );
	END COMPONENT;
	
	SIGNAL tempEnPC, tempEnA, tempEnB, tempEnOut, tempEnOp, 
           tempPronto, tempiniUla : STD_LOGIC;
    
	SIGNAL tempOpcode: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
BEGIN
	
	datapath: bo PORT MAP (
		clk => clk, 
		enPC => tempEnPC,
		enA => tempEnA,
		enb => tempEnB,
		enOut => tempEnOut,
		enOp => tempEnOp,
		opcode => tempOpcode,
		pronto => tempPronto,
		saida => saida,
		erro => flagErro,
		flagN=> flagN,
		flagZ=> flagZ,
		flagO=> flagO,
		resto => resto,
		iniUla => tempiniUla
	);
	
	controle: bc PORT MAP (
		clk => clk,
		reset => reset,
		inicio => inicio,
		pronto => tempPronto,
		enPC => tempEnPC,
		enA => tempEnA,
		enb => tempEnB,
		enOut => tempEnOut,
		enOp => tempEnOp,
		opcode => tempOpcode,
		iniUla => tempiniUla
	);
	
END arch;

