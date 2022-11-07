LIBRARY ieee;
USE	ieee.std_logic_1164.ALL;

ENTITY buf IS
	GENERIC (N : INTEGER := 8);	-- 8 valore di default se nessun valore assegnato
	PORT(clk  : IN  STD_LOGIC;
		rstn : IN  STD_LOGIC;
		d	  : IN  STD_LOGIC_VECTOR (N-1 downto 0);
		q	  : OUT STD_LOGIC_VECTOR (N-1 downto 0));
END buf;

ARCHITECTURE behavioral OF buf IS
	signal state : STD_LOGIC_VECTOR (N-1 downto 0);
begin

	q <= state;

	process (clk, rstn, d, q)
		begin
		if (rstn = '0') then
			state <= (others => '0');
		else
			if (clk = '1' and clk'EVENT) then
				state <= d;
			end if;
		end if;
	end process;

END behavioral;