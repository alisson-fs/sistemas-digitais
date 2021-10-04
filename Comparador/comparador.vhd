library ieee;
use ieee.std_logic_1164.all;

entity comparador is
	generic(N: integer := 4);
	port(
		A, B: in std_logic_vector(N-1 downto 0);
		AigualB, AmaiorB, AmenorB: out std_logic:= '0'
	);
end comparador;

architecture arch of comparador is
begin
	
	AigualB <= '1' when A = B else '0';
	AmaiorB <= '1' when A > B else '0';
	AmenorB <= '1' when A < B else '0';

end arch;