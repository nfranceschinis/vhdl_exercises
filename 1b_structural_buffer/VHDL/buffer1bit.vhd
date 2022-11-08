-- Title:         ES 1b: Syncronized n-buffer
-- Description:   behavioral description of  single buffer module
-- Author:        Nicola Franceschinis
-- Date:          08/11/2022

library ieee;
use	ieee.std_logic_1164.all;
-- In/out description of buffer block
entity buffer1bit is
	port (clkBit  : in  std_logic;
         rstnBit : in  std_logic;
	      dBit	  : in  std_logic;
		   qBit	  : out std_logic);
end buffer1bit;
--behavioral description of buffer block
architecture behavioral of buffer1bit is                  --behavioral -> functional description of the block
	
   signal state : std_logic; --init signal (hw sintetized)
   constant technology_delay : time := 5 ns;
begin

	buffer1bit : process (clkBit, rstnBit, dBit, qBit)  -- process dBitescription with signals sensitivity
   begin
      if (rstnBit = '0') then
         state <= '0';  -- reset buffer caused by rst (negate) signal and exclude other signals
      else
         if (clkBit = '1' and clkBit'event) then
            state <= dBit after technology_delay; -- update signal state with d input
         end if;
      end if;
   end process;

   qBit <= state; -- update output state with signal state

end behavioral;