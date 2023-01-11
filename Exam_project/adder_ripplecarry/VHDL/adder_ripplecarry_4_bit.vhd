-- Title:         EXM 2: ripple carry adder
-- Description:   structural description of ripple carry adder module
-- Author:        Nicola Franceschinis
-- Date:          10/01/2023

LIBRARY ieee;
USE	ieee.std_logic_1164.all;
USE   ieee.numeric_std.all;
-- In/out description of buffer block
ENTITY ripple_carry_adder IS
   GENERIC (N    : integer := 4);
	PORT (a           : IN  std_logic_vector (N-1 DOWNTO 0);
         b           : IN  std_logic_vector (N-1 DOWNTO 0);
	      carryIn	   : IN  std_logic;
		   sum	      : OUT std_logic_vector (N-1 DOWNTO 0);
         carryOut    : OUT std_logic);
END ripple_carry_adder;

--behavioral description of buffer block
ARCHITECTURE behavioral OF ripple_carry_adder IS                  --behavioral -> functional description of the block

COMPONENT full_adder IS
   PORT (a           : IN  std_logic;
         b           : IN  std_logic;
         carryIn	   : IN  std_logic;
         sum	      : OUT std_logic;
         carryOut    : OUT std_logic);
END COMPONENT;

   SIGNAL s_carry : std_logic_vector (N DOWNTO 0);

BEGIN
   rcaN : FOR i IN 0 TO N-1 GENERATE
      s_carry(0) <= carryIn;
      fadderI : full_adder PORT MAP (a        => a (i),
                                     b        => b (i),
                                     carryIn  => s_carry(i),
                                     sum      => sum(i),
                                     carryOut => s_carry(i+1));
   END GENERATE;
   carryOut   <= s_carry(N);
END ARCHITECTURE;