-- Title:         ES 1_other: mux based latch
-- Description:   behavioral description of mux module
-- Author:        Nicola Franceschinis
-- Date:          15/11/2022

library ieee;
use	ieee.std_logic_1164.all;
-- In/out description of mux block
entity mux is
	port (a    : in  std_ulogic;
         b    : in  std_ulogic;
         sel  : in  std_ulogic;
		   q	  : out std_ulogic);
end mux;
--behavioral description of mux block
architecture behavioral of mux is                  --behavioral -> functional description of the block
   
   begin
      
      mux1 : process (a, b, q, sel)  -- process description with signals sensitivity
      begin
         if (sel = '0') then
            q <= a; -- update signal state with d input
         else
            q <= b;
         end if;
      end process;

end behavioral;