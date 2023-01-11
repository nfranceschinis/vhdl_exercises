-- Title:         EXM 2: ripple carry adder
-- Description:   behavioral description of partial full adder module
-- Author:        Nicola Franceschinis
-- Date:          10/01/2023

LIBRARY ieee;
USE	ieee.std_logic_1164.all;
-- In/out description of buffer block
ENTITY full_adder IS
	PORT (a           : in  std_logic;
         b           : in  std_logic;
	      carryIn	   : in  std_logic;
		   sum	      : out std_logic;
         carryOut        : out std_logic);
END full_adder;
--behavioral description of buffer block
ARCHITECTURE behavioral OF full_adder IS                  --behavioral -> functional description of the block
   BEGIN
      sum      <= a XOR b XOR carryIn;
      carryOut <= (a AND b) OR (carryIn AND A) OR (carryIn AND B); 
END behavioral;