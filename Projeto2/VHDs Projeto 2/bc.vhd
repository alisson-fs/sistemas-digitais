LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (
	clk, reset, inicio, pronto : IN STD_LOGIC;
	opcode : IN STD_LOGIC_VECTOR(3 downto 0);
	enPC, enA, enB, enOut, enOp, iniUla: OUT STD_LOGIC
);
END bc;

ARCHITECTURE estrutura OF bc IS
	TYPE stateType IS (S0, S1, S2, S3, S4, S5);
	SIGNAL state: stateType;
BEGIN
	PROCESS (clk, reset, inicio, pronto, opcode)
	BEGIN
		if reset = '1' THEN
			state <= S0 ;
		ELSIF clk'EVENT AND clk = '1' THEN
			CASE state IS
				WHEN S0 =>
					IF inicio = '1' THEN
						state <= S1;
					ELSE
						state <= S0;
					END IF;

				WHEN S1 =>
					IF opcode = "1111" THEN
						state <= S0;
					ELSE
						state <= S2;
					END IF;

				WHEN S2 =>
					IF (
						(opcode = "0010") OR 
						(opcode = "0011") OR 
						(opcode = "0100")
					) THEN
						state <= S4;
					ELSE
						state <= S3;
					END IF;

				WHEN S3 =>
					state <= S4;
				
				WHEN S4 =>
					IF pronto = '0' THEN
						state <= S4;
					ELSE
						state <= S5;
					END IF;
				
				WHEN S5 =>
					state <= S1;

			END CASE;
		END IF;
	END PROCESS;
	
	PROCESS (state)
	BEGIN
		CASE state IS
			WHEN S0 =>
				enPC <= '0';
				enA <= '0';
				enB <= '0';
				enOut <= '0';
				enOp <= '0';
				iniUla <= '0';
				
			WHEN S1 =>
				enPC <= '1';
				enA <= '0';
				enB <= '0';
				enOut <= '0';
				enOp <= '1';
				iniUla <= '0';
				
			WHEN S2 =>
				enPC <= '1';
				enA <= '1';
				enB <= '0';
				enOut <= '0';
				enOp <= '0';
				iniUla <= '0';
				
			WHEN S3 =>
				enPC <= '1';
				enA <= '0';
				enB <= '1';
				enOut <= '0';
				enOp <= '0';
				iniUla <= '1';
			
			WHEN S4 =>
				enPC <= '0';
				enA <= '0';
				enB <= '0';
				enOut <= '0';
				enOp <= '0';
				iniUla <= '0';
				
			WHEN S5 =>
				enPC <= '0';
				enA <= '0';
				enB <= '0';
				enOut <= '1';
				enOp <= '0';
				iniUla <= '0';
				
		END CASE;
	END PROCESS;
END estrutura;

