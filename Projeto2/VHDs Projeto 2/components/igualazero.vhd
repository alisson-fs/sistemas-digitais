LIBRARY ieee;
LIBRARY work;
USE work.constants.all;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY igualazero IS
PORT (
	a : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);
	igual : OUT STD_LOGIC
);
END igualazero;

ARCHITECTURE estrutura OF igualazero IS
BEGIN
	igual <= '1' WHEN unsigned(a) = 0 ELSE '0';
END estrutura;