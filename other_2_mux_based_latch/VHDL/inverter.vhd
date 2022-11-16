-- Title:         ES 1_other: mux based latch
-- Description:   behavioral description of inverter module
-- Author:        Nicola Franceschinis
-- Date:          15/11/2022

library ieee;
use	ieee.std_logic_1164.all;
-- In/out description of inverter
entity inverter is
	port (a    : in  std_logic;
		   q	  : out std_logic);
end inverter;
--behavioral description of inverter block
architecture behavioral of inverter is                  --behavioral -> functional description of the block
   
   begin
      inv1 : process (a, q)  -- process description with signals sensitivity
      begin
         q <= not a after 1 fs;
      end process;
end behavioral;