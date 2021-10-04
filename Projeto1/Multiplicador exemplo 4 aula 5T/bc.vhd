LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (
	clk : IN STD_LOGIC;
	iniciar, reset : IN STD_LOGIC;
	Az, Bz : IN STD_LOGIC;
	mP, mA, cB : OUT STD_LOGIC;
	cP : OUT STD_LOGIC;
	cA, op, m1, m2 : OUT STD_LOGIC;
	cmult : OUT STD_LOGIC;
	pronto : OUT STD_LOGIC
);
END bc;


ARCHITECTURE estrutura OF bc IS
	TYPE state_type IS (S0, S1, S2, S3, S4, S5 );
	SIGNAL state: state_type;
BEGIN
	-- Logica de proximo estado (e registrador de estado)
	PROCESS (clk, Reset)
	BEGIN
		if(Reset = '1') THEN
			state <= S0 ;
		ELSIF (clk'EVENT AND clk = '1') THEN
			CASE state IS
				WHEN S0 =>
					IF iniciar = '1' THEN
						state <= S1;
					ELSE
						state <= S0;
					END IF;

				WHEN S1 =>
					state <= S2;

				WHEN S2 =>
					IF Az = '0' AND Bz = '0' THEN
						state <= S3;
					ELSE
						state <= S5;
					END IF;

				WHEN S3 =>
					state <= S4;

				WHEN S4 =>
					state <= S2;

				WHEN S5 =>
					state <= S0;

			END CASE;
		END IF;
	END PROCESS;
	
	-- Logica de saida
	PROCESS (state)
	BEGIN
		CASE state IS
			WHEN S0 =>
				mP <= '0';
				cP <= '0';
				mA <= '0';
				cA <= '0';
				cB <= '0';
				m1 <= '0';
				m2 <= '0';
				op <= '0';
				cmult <= '0';
				pronto <= '1';
				
			WHEN S1 =>
				mP <= '1';
				cP <= '1';
				mA <= '1';
				cA <= '1';
				cB <= '1';
				m1 <= '0';
				m2 <= '0';
				op <= '0';
				cmult <= '0';
				pronto <= '1';
				
			WHEN S2 =>
				mP <= '0';
				cP <= '0';
				mA <= '0';
				cA <= '0';
				cB <= '0';
				m1 <= '0';
				m2 <= '0';
				op <= '0';
				cmult <= '0';
				pronto <= '0';
				
			WHEN S3 =>
				mP <= '0';
				cP <= '1';
				mA <= '0';
				cA <= '0';
				cB <= '0';
				m1 <= '0';
				m2 <= '0';
				op <= '0';
				cmult <= '0';
				pronto <= '0';
				
			WHEN S4 =>
				mP <= '0';
				cP <= '0';
				mA <= '0';
				cA <= '1';
				cB <= '0';
				m1 <= '1';
				m2 <= '1';
				op <= '1';
				cmult <= '0';
				pronto <= '0';
				
			WHEN S5 =>
				mP <= '0';
				cP <= '0';
				mA <= '0';
				cA <= '0';
				cB <= '0';
				m1 <= '0';
				m2 <= '0';
				op <= '0';
				cmult <= '1';
				pronto <= '0';
				
		END CASE;
	END PROCESS;
END estrutura;