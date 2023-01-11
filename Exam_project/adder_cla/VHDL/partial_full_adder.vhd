-- Title:         EXM 1: CLA adder  
-- Description:   behavioral description of partial full adder module
-- Author:        Nicola Franceschinis
-- Date:          10/01/2023

LIBRARY ieee;
USE	ieee.std_logic_1164.all;
-- In/out description of buffer block
ENTITY partial_full_adder IS
	PORT (a           : IN  std_logic;
         b           : IN  std_logic;
	      carryIn	   : IN  std_logic;
		   sum	      : OUT std_logic;
         prop        : OUT std_logic;
         gen         : OUT std_logic);
END partial_full_adder;
--behavioral description of buffer block
ARCHITECTURE behavioral OF partial_full_adder IS                  --behavioral -> functional description of the block
BEGIN
   sum  <= a XOR b XOR carryIn;
   prop <= a XOR b;
   gen  <= a AND b;
END behavioral;