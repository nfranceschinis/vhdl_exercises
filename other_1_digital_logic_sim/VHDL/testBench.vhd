-- Title:         ES 1_other: mux based latch
-- Description:   structural description of interconnection between mux module and vectorGenerator module
-- Author:        Nicola Franceschinis
-- Date:          07/11/2022

library ieee;
use ieee.std_logic_1164.all;

entity testBench is
end testBench;

architecture structural of testBench is                 -- structural -> describe how different parts are connected
  
  -- In/out description of mux block
  component mux is
	  port (a    : in  std_ulogic;
          b    : in  std_ulogic;
          sel  : in  std_ulogic;
		      q	  : out std_ulogic);
  end component;
  -- In/out description of vectorGenerator block
  component vectorGenerator is
    port (d    : out  std_ulogic;
          clk  : out  std_ulogic;
		      q	   : in   std_ulogic);
  end component;
  -- description of interconnection signals (effective cables between blocks)
  signal dTB, selTB, qTB: std_ulogic;

BEGIN

  mux1 : mux PORT MAP(a    => dTB,
                      b    => qTB,
                      sel  => selTB,
                      q  => qTB);

  vector1 : vectorGenerator PORT MAP(d    => dTB,
                                     clk  => selTB,
                                     q    => qTB);

END structural;