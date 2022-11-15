-- Title:         ES 1_other: mux based latch
-- Description:   behavioral description of pass transistor positive module
-- Author:        Nicola Franceschinis
-- Date:          15/11/2022

library ieee;
use	ieee.std_logic_1164.all;
-- In/out of pass transistor positive
entity passTRp is
  port (i    : in  std_logic;
        clk  : in  std_logic;
        o    : out std_logic);
end entity;
--behavioral description of mux block
architecture behavioral of passTRp is                  --behavioral -> functional description of the block
   
begin
      passTRp1 : process (i, o, clk)  -- process description with signals sensitivity
      begin
         o <= i when clk = '1' else 'Z';
      end process;
end behavioral;