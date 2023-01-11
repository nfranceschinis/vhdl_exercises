-- Title:         EXM 2: ripple carry adder
-- Description:   behavioral description of partial full adder module
-- Author:        Nicola Franceschinis
-- Date:          10/01/2023

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY vectorGenerator IS
  GENERIC (N    : integer := 4);
 PORT (a           : OUT  std_logic_vector (N-1 downto 0);
       b           : OUT  std_logic_vector (N-1 downto 0);
       carryIn	   : OUT  std_logic;
       sum	       : IN std_logic_vector (N-1 downto 0);
       carryOut    : IN std_logic);
END vectorGenerator;

ARCHITECTURE behavioral OF vectorGenerator IS
BEGIN
  stim_proc: PROCESS
              BEGIN
                WAIT FOR 10 ns;
                a <= "1111";
                b <= "1111";
                carryIn <= '1';
                WAIT FOR 10 ns;
                a <= "1010";
                b <= "0111";
                carryIn <= '0';
                WAIT FOR 10 ns;
                a <= "1000";
                b <= "1001";
                carryIn <= '1';
                WAIT FOR 10 ns;
  END PROCESS;

END behavioral;