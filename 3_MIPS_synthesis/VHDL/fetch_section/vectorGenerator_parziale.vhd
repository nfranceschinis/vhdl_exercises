-- Title:         ES 3: MIPS synthesis
-- Description:   behavioral description of vectorGenerator
-- Author:        Nicola Franceschinis
-- Date:          22/11/2022

library ieee;
use   ieee.std_logic_1164.all;

use   ieee.std_logic_arith.all;
use   ieee.std_logic_unsigned.all;
entity vectorGenerator is
  generic (N  : integer := 16);
  port (clk   : out std_logic;
        jump  : out std_logic_vector (N-1 downto 0);
        q     : in  std_logic_vector (N-1 downto 0));
end entity;

architecture behavioral of vectorGenerator is

  constant ckDT      : time := 2 ns;
  constant jumpDT    : time := 100 ns;
begin
  
  clock : process -- clock signal description and data saving
    variable ck : std_logic := '0';
  begin
    clk <= ck;
    ck := not ck;
    wait for ckDT;
  end process;

  jump_it : process
  begin
    jump <= (others => '0');
    wait for jumpDT;
    jump <= x"0004";
  end process;

end architecture;