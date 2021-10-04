library ieee;
use ieee.std_logic_1164.all;


entity flipflop_jk is
	port (
		J, K, RST, CLK: in std_logic;
		Q: out std_logic
	);
end flipflop_jk;

architecture arch of flipflop_jk is
	signal JK: std_logic_vector(1 downto 0);
	signal V: std_logic;
begin
	JK <= J & K;
	process(RST, CLK)
	begin
		if (RST = '0') then
			if (CLK'event and CLK = '1') then
				case JK is
					when "00" => V <= V;
					when "01" => V <= '0';
					when "10" => V <= '1';
					when "11" => V <= not V;
				end case;
			end if;
		else
			V <= '0';
		end if;
	end process;
	Q <= V;
end arch;