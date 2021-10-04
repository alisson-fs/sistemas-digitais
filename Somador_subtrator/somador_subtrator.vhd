library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity somador_subtrator is
    generic(N: integer := 8);
    port(
        A, B: in std_logic_vector(N-1 downto 0);
        opcode: in std_logic;
        S: out std_logic_vector(N-1 downto 0)
    );
end somador_subtrator;

architecture arch of somador_subtrator is
    signal BMUX: std_logic_vector(N-1 downto 0);
begin
    BMUX <= B when opcode = '0' else not B;
    S <= A + BMUX + opcode;
end arch;
