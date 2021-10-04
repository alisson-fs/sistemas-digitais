library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity somador_comportamental_8bits is
	port(
		a, b: in std_logic_vector(7 downto 0);
		s: out std_logic_vector(7 downto 0)
	);
end somador_comportamental_8bits;

architecture arch of somador_comportamental_8bits is

begin
	s <= a + b;
end arch;