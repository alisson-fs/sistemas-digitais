library ieee;
use ieee.std_logic_1164.all;


entity ring_counter_ffjk is
	port (
		RST, CLK: in std_logic;
		Q: out std_logic_vector(3 downto 0)
	);
end ring_counter_ffjk;

architecture arch of ring_counter_ffjk is
	component flipflop_jk is
		port (
			J, K, RST, CLK: in std_logic;
			Q: out std_logic
		);
	end component;
	signal QFF: std_logic_vector(3 downto 0);
begin
	FF3: flipflop_jk port map (J => QFF(0), K => not QFF(0), RST => RST, CLK => CLK, Q => QFF(3));
	FF2: flipflop_jk port map (J => QFF(3), K => not QFF(3), RST => RST, CLK => CLK, Q => QFF(2));
	FF1: flipflop_jk port map (J => QFF(2), K => not QFF(2), RST => RST, CLK => CLK, Q => QFF(1));
	FF0: flipflop_jk port map (J => QFF(1), k => not QFF(2), RST => RST, CLK => CLK, Q => QFF(0));
	Q <= QFF;
end arch;

