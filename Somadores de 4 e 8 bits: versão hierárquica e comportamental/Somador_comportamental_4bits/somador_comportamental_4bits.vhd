library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity somador_comportamental_4bits is
	port(
		a, b: in std_logic_vector(3 downto 0);
		s: out std_logic_vector(3 downto 0)
	);
end somador_comportamental_4bits;

architecture arch of somador_comportamental_4bits is

begin
	s <= a + b;
end arch;