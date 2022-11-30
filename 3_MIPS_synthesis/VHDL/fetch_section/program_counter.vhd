-- Title:         ES 3: MIPS synthesis
-- Description:   behavioral description of program counter module
-- Author:        Nicola Franceschinis
-- Date:          22/11/2022

library ieee;
use	ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-- In/out description of program counter block
entity pc is
	generic (N : integer := 16);	-- 16 valore di default se nessun valore assegnato
	port (clk  : in	 std_logic;
		  a    : in  std_logic_vector (N-1 downto 0);
		  q	   : out std_logic_vector (N-1 downto 0));
end entity;
--behavioral description of program counter block
architecture behavioral of pc is                  --behavioral -> functional description of the block

signal state : std_logic_vector (N-1 downto 0):= (others => '0'); --init signal (hw sintetized)

begin
	prog_counter : process (clk, a, q)  -- process description with signals sensitivity
   	begin
		--state <= a;
      	if (clk = '1' and clk'event) then
			state <= state + 1; -- update signal state with d input
		else
			state <= a after 1 fs;
		end if;
		q <= state;	
   	end process;

end behavioral;