library ieee;
use	ieee.std_logic_1164.all;

entity buf is
	generic (N : integer := 8);	-- 8 valore di default se nessun valore assegnato
	   port(clk  : IN  std_logic;
           rstn : IN  std_logic;
			  d	 : IN  std_logic_vector (N-1 downto 0);
			  q	 : OUT std_logic_vector (N-1 downto 0));
end buf;

architecture behavioral of buf is                  --behavioral -> functional description of the block
	signal state : std_logic_vector (N-1 downto 0);
begin

	q <= state;

	process (clk, rstn, d, q)
		begin
		if (rstn = '0') then
			state <= (others => '0');
		else
			if (clk = '1' and clk'event) then
				state <= d;
			end if;
		end if;
	end process;

end behavioral;