-- Title:         ES 3: MIPS synthesis
-- Description:   behavioral description of add module
-- Author:        Nicola Franceschinis
-- Date:          22/11/2022

library ieee;
use	ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- In/out description of add block
entity adder is
	generic (N : integer := 16);	-- 16 valore di default se nessun valore assegnato
	port (a    : in  std_logic_vector (N-1 downto 0);
	      b	   : in  std_logic_vector (N-1 downto 0);
		  q	   : out std_logic_vector (N-1 downto 0));
end entity;
--behavioral description of add block
architecture behavioral of adder is                  --behavioral -> functional description of the block
	
begin

	add : process (a, b, q)  -- process description with signals sensitivity
   begin
      q <= std_logic_vector (unsigned(a) + unsigned(b));
   end process;

end behavioral;