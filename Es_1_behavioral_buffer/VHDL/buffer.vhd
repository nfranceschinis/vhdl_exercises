-- Title:         ES 1: Syncronized n-buffer
-- Description:   behavioral description of buffer module
-- Author:        Nicola Franceschinis
-- Date:          07/11/2022

library ieee;
use	ieee.std_logic_1164.all;
-- In/out description of buffer block
entity buf is
	generic (N : integer := 8);	-- 8 valore di default se nessun valore assegnato
	port (clk  : in  std_logic;
         rstn : in  std_logic;
	      d	  : in  std_logic_vector (N-1 downto 0);
		   q	  : out std_logic_vector (N-1 downto 0));
end buf;
--behavioral description of buffer block
architecture behavioral of buf is                  --behavioral -> functional description of the block
	
   signal state : std_logic_vector (N-1 downto 0); --init signal (hw sintetized)

begin

	buff : process (clk, rstn, d, q)  -- process description with signals sensitivity
   begin
      if (rstn = '0') then
         state <= (others => '0');  -- reset buffer caused by rst (negate) signal and exclude other signals
      else
         if (clk = '1' and clk'event) then
            state <= d; -- update signal state with d input
         end if;
      end if;
   end process;

   q <= state; -- update output state with signal state

end behavioral;