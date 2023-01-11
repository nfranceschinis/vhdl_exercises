-- Title:         EXM 1: CLA adder
-- Description:   structural description of carry look ahead adder module
-- Author:        Nicola Franceschinis
-- Date:          10/01/2023

LIBRARY ieee;
USE	ieee.std_logic_1164.all;
USE   ieee.numeric_std.all;
-- In/out description of buffer block
ENTITY carry_look_ahead IS
   GENERIC (N    : integer := 4);
	PORT (a           : IN  std_logic_vector (N-1 DOWNTO 0);
         b           : IN  std_logic_vector (N-1 DOWNTO 0);
	      carryIn	   : IN  std_logic;
		   sum	      : OUT std_logic_vector (N-1 DOWNTO 0);
         carryOut    : OUT std_logic);
END carry_look_ahead;

--behavioral description of buffer block
ARCHITECTURE behavioral OF carry_look_ahead IS                  --behavioral -> functional description of the block

   COMPONENT partial_full_adder IS
      PORT (a           : IN  std_logic;
            b           : IN  std_logic;
            carryIn	   : IN  std_logic;
            sum	      : OUT std_logic;
            prop        : OUT std_logic;
            gen         : OUT std_logic);
   END COMPONENT;

   SIGNAL s_carry : std_logic_vector (N DOWNTO 0);
   SIGNAL s_propagate, s_generate :  std_logic_vector (N-1 DOWNTO 0);

BEGIN
   claN : FOR i IN 0 TO N-1 GENERATE
      pfadderI : partial_full_adder PORT MAP (a       => a (i),
                                              b       => b (i),
                                              carryIn => s_carry(i),
                                              sum     => sum (i),
                                              prop    => s_propagate (i),
                                              gen     => s_generate (i));
   END GENERATE;
   
   s_carry(0) <= carryIn;
   
   carry_gen : FOR s IN 1 TO N GENERATE
      s_carry(s) <= s_generate(s-1) OR (s_propagate(s-1) AND s_carry(s-1));
   END GENERATE;
   carryOut   <= s_carry(N);
END ARCHITECTURE;