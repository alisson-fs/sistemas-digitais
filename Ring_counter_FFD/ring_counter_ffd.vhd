library ieee;
use ieee.std_logic_1164.all;


entity ring_counter_ffd is
	port (
		RST, CLK: in std_logic
	);
end ring_counter_ffd;

architecture arch of ring_counter_ffd is
	component flipflop_d is
		port (
			D, S, RST, CLK: in std_logic;
			Q: out std_logic
		);
	end component;
	signal Q: std_logic_vector(3 downto 0);
begin
	FF3: flipflop_d port map (D => Q(0), S => RST, RST => '0', CLK => CLK, Q => Q(3));
	FF2: flipflop_d port map (D => Q(3), S => '0', RST => RST, CLK => CLK, Q => Q(2));
	FF1: flipflop_d port map (D => Q(2), S => '0', RST => RST, CLK => CLK, Q => Q(1));
	FF0: flipflop_d port map (D => Q(1), S => '0', RST => RST, CLK => CLK, Q => Q(0));
end arch;
