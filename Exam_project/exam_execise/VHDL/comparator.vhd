-- Title:         EXM 3: Sincronized serial comparator
-- Description:   behavioral description of 8 bit comparator
-- Author:        Nicola Franceschinis
-- Date:          16/01/2023

LIBRARY ieee;
USE	ieee.std_logic_1164.ALL;
USE   ieee.numeric_std.ALL;

ENTITY comparator IS
	PORT (clk        : IN  std_logic;
         serial_in  : IN  std_logic;
		   result	  : OUT std_logic);
END comparator;
--behavioral description of buffer block
ARCHITECTURE Behavioral OF comparator IS
   SIGNAL word1, word2 : std_logic_vector (7 DOWNTO 0) := (others => '0');
   BEGIN
      compare : PROCESS (clk, serial_in)
         VARIABLE ptr1, ptr2 : integer;
         BEGIN
            ptr1 := 0;
            ptr2 := 0;
            IF (clk = '1' AND clk'event) THEN
               IF (ptr1 < 7) THEN
                  word1 (ptr1) <= serial_in;
                  ptr1 := ptr1 + 1;
               ELSE IF (ptr2 < 7) THEN
                  word2 (ptr2) <= serial_in;
                  ptr2 := ptr2 + 1;
               END IF;
               END IF;
            END IF;
            IF (ptr1 = 7 AND ptr2 = 7) THEN
               IF (word1 = word2) THEN
                  result <= '1';
               ELSE
                  result <= '0';
               END IF;
            END IF;
      END PROCESS;
END ARCHITECTURE;