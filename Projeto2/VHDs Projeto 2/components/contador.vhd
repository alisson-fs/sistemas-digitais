LIBRARY ieee;
LIBRARY work;
USE work.constants.all;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;


ENTITY contador IS
PORT (
	clk, carga : IN STD_LOGIC;
	q : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
);
END contador;

ARCHITECTURE comportamento OF contador IS
	SIGNAL d: STD_LOGIC_VECTOR(4 DOWNTO 0) := (others => '0');
BEGIN
	PROCESS(clk)
	BEGIN
		IF clk'EVENT AND clk = '1' AND carga = '1' THEN
			d <= d + '1';
		END IF;
	END PROCESS;
	q <= d;
END comportamento;