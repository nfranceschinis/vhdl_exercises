-- Title:         EXM 3: Sincronized serial comparator
-- Description:   structural description of inteconnections between 8 bit comparator and VectorGenerator
-- Author:        Nicola Franceschinis
-- Date:          16/01/2023

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testBench IS
END testBench;

ARCHITECTURE Structural OF testBench IS
  
  COMPONENT comparator IS
	    PORT (clk         : IN  std_logic;
            serial_in   : IN  std_logic;
		        result	    : OUT std_logic);
  END COMPONENT;
  -- In/out description of vectorGenerator block
  COMPONENT vectorGenerator IS
	    PORT (clk         : OUT  std_logic;
            serial_out  : OUT  std_logic;
		        result	    : IN   std_logic);
  END COMPONENT;
  -- description of interconnection signals (effective cables between blocks)
  signal clkTB, serialTB, resultTB : std_logic;

BEGIN

  comparator1 : comparator
          PORT MAP(clk        => clkTB,
                   serial_in  => serialTB,
                   result     => resultTB);

  vector1 : vectorGenerator
          PORT MAP(clk        => clkTB,
                   serial_out => serialTB,
                   result     => resultTB);

END structural;