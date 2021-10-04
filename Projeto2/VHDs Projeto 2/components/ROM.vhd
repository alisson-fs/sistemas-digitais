LIBRARY ieee;
LIBRARY work;
USE work.constants.all;
USE ieee.std_logic_1164.all;

ENTITY ROM IS
PORT (
    address : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    data : OUT STD_LOGIC_VECTOR(size-1 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE Rom_Arch OF ROM IS
    TYPE memory IS ARRAY (00 TO 26) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    CONSTANT my_Rom : memory := (
			00 => "0000000000000000", -- op soma
			01 => "1001000001000101", -- a 16: 36933 / 8: 69 / 4:  5
			02 => "1001000000000101", -- b 16: 36869 / 8: 5 / 4:  5
			03 => "0000000000000001", -- op sub
			04 => "0000100001000110", -- a 16: 2118 / 8: 70 / 4:  6
			05 => "0000100001000110", -- b 16: 2118 / 8: 70 / 4:  6
			06 => "0000000000000010", -- op incremento
			07 => "0000100000100101", -- a 16: 2085 / 8: 37 / 4:  5
			08 => "0000000000000011", -- op decremento
			09 => "0000100000100110", -- a 16: 2086 / 8: 38 / 4:  6
			10 => "0000000000000100", -- op not
			11 => "0011000010001111", -- a 16: 12431 / 8: 143 / 4:  11
			12 => "0000000000000101", -- op and
			13 => "0001100000100110", -- a 16: 6182 / 8: 38 / 4: 6 
			14 => "0010100010000010", -- b 16: 10370 / 8: 130 / 4:  2
			15 => "0000000000000110", -- op or
			16 => "0000101000001011", -- a 16: 2571 / 8: 11 / 4:  11
			17 => "0010000001001101", -- b 16: 8269 / 8: 77 / 4:  13
			18 => "0000000000000111", -- op xor
			19 => "0001100010001011", -- a 16: 6283 / 8: 139 / 4:  11
			20 => "0011000000101101", -- b 16: 12333 / 8: 45 / 4:  13
			21 => "0000000000001000", -- op mult
			22 => "0011000001000100", -- a 16: 12356 / 8: 68 / 4:  4
			23 => "0001100001000010", -- b 16: 6210 / 8: 66 / 4:  2
			24 => "0000000000001001", -- op div
			25 => "0100000000101000", -- a 16: 16424 / 8: 40 / 4:  8
			26 => "0010000000010010"  -- b 16: 8210 / 8: 18 / 4:  2
    );
    
    SIGNAL sliced : STD_LOGIC_VECTOR(15 downto 0);
    
BEGIN
   PROCESS (address)
   BEGIN
     CASE address IS
            WHEN "00000" => sliced <= my_rom(00);
            WHEN "00001" => sliced <= my_rom(01);
            WHEN "00010" => sliced <= my_rom(02);
            WHEN "00011" => sliced <= my_rom(03);
            WHEN "00100" => sliced <= my_rom(04);
            WHEN "00101" => sliced <= my_rom(05);
            WHEN "00110" => sliced <= my_rom(06);
            WHEN "00111" => sliced <= my_rom(07);
            WHEN "01000" => sliced <= my_rom(08);
            WHEN "01001" => sliced <= my_rom(09);
            WHEN "01010" => sliced <= my_rom(10);
            WHEN "01011" => sliced <= my_rom(11);
            WHEN "01100" => sliced <= my_rom(12);
            WHEN "01101" => sliced <= my_rom(13);
            WHEN "01110" => sliced <= my_rom(14);
            WHEN "01111" => sliced <= my_rom(15);
            WHEN "10000" => sliced <= my_rom(16);
            WHEN "10001" => sliced <= my_rom(17);
            WHEN "10010" => sliced <= my_rom(18);
            WHEN "10011" => sliced <= my_rom(19);
            WHEN "10100" => sliced <= my_rom(20);
            WHEN "10101" => sliced <= my_rom(21);
            WHEN "10110" => sliced <= my_rom(22);
            WHEN "10111" => sliced <= my_rom(23);
            WHEN "11000" => sliced <= my_rom(24);
            WHEN "11001" => sliced <= my_rom(25);
            WHEN "11010" => sliced <= my_rom(26);
       WHEN OTHERS => sliced <= "0000000000001111";
       END CASE;
  END PROCESS;
  data <= sliced(size-1 downto 0);
END ARCHITECTURE Rom_Arch;
