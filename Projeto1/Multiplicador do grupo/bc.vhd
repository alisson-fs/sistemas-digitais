LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (Reset, clk, inicio : IN STD_LOGIC;
      Az, Bz : IN STD_LOGIC;
		mP, mA, cP, cA, cB, pronto: OUT STD_LOGIC);
END bc;

ARCHITECTURE estrutura OF bc IS
	TYPE state_type IS (S0, S1, S2, S3);
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
					IF inicio = '1' THEN
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
						state <= S0;
					END IF;

				WHEN S3 =>
					state <= S2;

			END CASE;
		END IF;
	END PROCESS;
	
	-- Logica de saida
	PROCESS (state)
	BEGIN
		CASE state IS
			WHEN S0 =>
				mP <= '0';
				mA <= '0';
				cP <= '0';
				cA <= '0';
				cB <= '0';
				pronto <= '1';
				
			WHEN S1 =>
				mP <= '1';
				mA <= '1';
				cP <= '1';
				cA <= '1';
				cB <= '1';
				pronto <= '0';
				
			WHEN S2 =>
				mP <= '0';
				mA <= '0';
				cP <= '0';
				cA <= '0';
				cB <= '0';
				pronto <= '0';
				
			WHEN S3 =>
				mP <= '0';
				mA <= '0';
				cP <= '1';
				cA <= '1';
				cB <= '0';
				pronto <= '0';
				
		END CASE;
	END PROCESS;
END estrutura;