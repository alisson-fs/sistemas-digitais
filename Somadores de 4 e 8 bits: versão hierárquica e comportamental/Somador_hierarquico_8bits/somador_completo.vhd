library ieee;
use ieee.std_logic_1164.all;


entity somador_completo is
	port(
		a, b, cin: in std_logic;
		s, cout: out std_logic
	);
end somador_completo;

architecture arch of somador_completo is

begin
	s <= a xor b xor cin;
	cout <= (a and b) or (b and cin) or (a and cin);
end arch;