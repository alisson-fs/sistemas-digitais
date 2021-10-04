library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity ULA is
	generic(N: integer := 4);
	port(
		A, B: in std_logic_vector(N-1 downto 0);
		ULAop: in std_logic_vector(1 downto 0);
		S: out std_logic_vector(N-1 downto 0);
		negativo, zero, overflow: out std_logic
	);
	
end ULA;

architecture arch of ULA is

	signal tempS: std_logic_vector(N-1 downto 0);
	
begin
	process(A, B, ULAop, tempS)
		begin
			case ULAop is
				when "00" =>
					tempS <= A and B;
				when "01" =>
					tempS <= A or B;
				when "10" =>
					tempS <= A + B;
				when others =>
					tempS <= "XXXX";
			end case;
	end process;
	
	S <= tempS;
	negativo <= '1' when tempS(N-1) = '1' else '0';
	zero <= '1' when tempS = "0000" else '0';
	overflow <= (A(N-1) and B(N-1) and not tempS(N-1)) or (not A(N-1) and not B(N-1) and tempS(N-1));

end arch;
