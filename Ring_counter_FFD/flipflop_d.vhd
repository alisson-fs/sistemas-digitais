library ieee;
use ieee.std_logic_1164.all;


entity flipflop_d is
	port (
		D, S, RST, CLK: in std_logic;
		Q: out std_logic
	);
end flipflop_d;

architecture arch of flipflop_d is
	signal Q_temp: std_logic;
begin
	process(D, S, RST, CLK)
	begin
		if (CLK'event and CLK = '1') then
			if (RST = '0') then
				if (S = '1') then
					Q_temp <= '1';
				else
					Q_temp <= D;
				end if;
			else
				Q_temp <= '0';
			end if;
		end if;
	end process;
	Q <= Q_temp;
end arch;
