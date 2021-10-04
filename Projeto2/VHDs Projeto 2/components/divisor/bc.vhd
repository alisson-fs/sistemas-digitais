LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc_div IS
PORT (
	Reset, clk, inicio : IN STD_LOGIC;
	AmaiorigualB, Bz : IN STD_LOGIC;
	mC, mA, cQ, cC, cR, cA, cB, pronto, erro: OUT STD_LOGIC
);
END bc_div;

ARCHITECTURE estrutura OF bc_div IS
	TYPE stateType IS (S0, S1, S2, S3, S4, Serro);
	SIGNAL state: stateType;
BEGIN
	PROCESS (clk, Reset)
	BEGIN
		if Reset = '1' THEN
			state <= S0 ;
		ELSIF clk'EVENT AND clk = '1' THEN
			CASE state IS
				WHEN Serro => 
					IF inicio = '1' THEN
						state <= S1;
					ELSE
						state <= Serro;
					END IF;
				
				WHEN S0 =>
					IF inicio = '1' THEN
						state <= S1;
					ELSE
						state <= S0;
					END IF;

				WHEN S1 =>
					state <= S2;

				WHEN S2 =>
					IF AmaiorigualB = '1' AND Bz = '0' THEN
						state <= S3;
					ELSIF Bz = '1' THEN
						state <= Serro;
					ELSE
						state <= S4;
					END IF;

				WHEN S3 =>
					state <= S2;

				WHEN S4 =>
					state <= S0;

			END CASE;
		END IF;
	END PROCESS;

	PROCESS (state)
	BEGIN
		CASE state IS
			WHEN Serro =>
				mC <= '0';
				mA <= '0';
				cQ <= '0';
				cA <= '0';
				cC <= '0';
				cR <= '0';
				cB <= '0';
				pronto <= '1';
				erro <= '1';
				
			WHEN S0 =>
				mC <= '0';
				mA <= '0';
				cQ <= '0';
				cA <= '0';
				cC <= '0';
				cR <= '0';
				cB <= '0';
				pronto <= '1';
				erro <= '0';
				
			WHEN S1 =>
				mC <= '1';
				mA <= '1';
				cQ <= '0';
				cA <= '1';
				cC <= '1';
				cR <= '0';
				cB <= '1';
				pronto <= '0';
				erro <= '0';
				
			WHEN S2 =>
				mC <= '0';
				mA <= '0';
				cQ <= '0';
				cA <= '0';
				cC <= '0';
				cR <= '0';
				cB <= '0';
				pronto <= '0';
				erro <= '0';
				
			WHEN S3 =>
				mC <= '0';
				mA <= '0';
				cQ <= '0';
				cA <= '1';
				cC <= '1';
				cR <= '0';
				cB <= '0';
				pronto <= '0';
				erro <= '0';

			WHEN S4 =>
				mC <= '0';
				mA <= '0';
				cQ <= '1';
				cA <= '0';
				cC <= '0';
				cR <= '1';
				cB <= '0';
				pronto <= '0';
				erro <= '0';
				
		END CASE;
	END PROCESS;
END estrutura;