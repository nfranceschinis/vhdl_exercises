-- Title:         ES 1_other: mux based latch
-- Description:   behavioral description of vectorGenerator
-- Author:        Nicola Franceschinis
-- Date:          07/11/2022

library ieee;
use ieee.std_logic_1164.all;

entity vectorGenerator is
    port (d    : out  std_logic;
          clk  : out  std_logic;
		      q	   : in   std_logic);
  end vectorGenerator;

architecture behavioral of vectorGenerator is

  constant ckDT   : time := 20  ns;
  constant dataDT : time := 10   ns;

begin
  clock : process   -- clock signal description
    variable ck: std_logic := '0';
  begin
    clk <= ck;
    wait for ckDT;
    ck := not ck;
  end process;

  data : process    -- bus signals description
  begin
    wait for dataDT;
    d <=  '0';
    wait for dataDT;
    d <=  '1';
  end process;

END behavioral;