-- Title:         EXM 3: Sincronized serial comparator
-- Description:   behavioral description of vectorGenerator
-- Author:        Nicola Franceschinis
-- Date:          16/01/2023

LIBRARY ieee;
use ieee.std_logic_1164.all;

ENTITY vectorGenerator IS
    PORT (clk         : OUT  std_logic;
          serial_out  : OUT  std_logic;
		      result	    : IN   std_logic);
  END vectorGenerator;

ARCHITECTURE Behavioral OF vectorGenerator IS

  CONSTANT ckDT   : time := 2  ns;
  
  SIGNAL word1  : std_logic_vector (7 DOWNTO 0) := x"AA";
  SIGNAL word2  : std_logic_vector (7 DOWNTO 0) := x"AA";

  BEGIN
    clock : PROCESS   -- clock signal description
      VARIABLE ck: std_logic := '0';
      BEGIN
        clk <= ck;
        WAIT FOR ckDT;
        ck := NOT ck;
    END PROCESS;

    data : PROCESS (clk)    -- serial signal description        
    BEGIN
        serial_out <= '0';
        serial_out <= '0' AFTER ckDT;
        serial_out <= '0' AFTER ckDT;
        serial_out <= '0' AFTER ckDT;
        serial_out <= '1' AFTER ckDT;
    END PROCESS;

END Behavioral;