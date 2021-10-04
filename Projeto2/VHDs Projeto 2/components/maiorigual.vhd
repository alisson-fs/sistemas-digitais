LIBRARY ieee;
LIBRARY work;
USE work.constants.all;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY maiorigual IS
PORT (
	a : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
	b : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
	amaiorigualb : OUT STD_LOGIC
);
END maiorigual;

ARCHITECTURE estrutura OF maiorigual IS
BEGIN
	amaiorigualb <= '1' WHEN unsigned(a) >= unsigned(b) ELSE '0';
END estrutura;