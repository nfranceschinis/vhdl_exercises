-- Title:         ES 1: Syncronized n-buffer
-- Description:   behavioral description of vectorGenerator
-- Author:        Nicola Franceschinis
-- Date:          07/11/2022

library ieee;
use ieee.std_logic_1164.all;

entity vectorGenerator is
    generic (N  : integer := 8);
    port (clk   : out  std_logic;
          rstn  : out  std_logic;
          d     : out  std_logic_vector (N-1 downto 0);
          q     : in   std_logic_vector (N-1 downto 0));
  end vectorGenerator;

architecture behavioral of vectorGenerator is

  constant ckDT   : time := 50  ns;
  constant rstDT  : time := 145 ns;
  constant dataDT : time := 100 ns;

begin
  clock : process   -- clock signal description
    variable ck: std_logic := '0';
  begin
    clk <= ck;
    wait for ckDT;
    ck := not ck;
  end process;

  reset : process   -- rst signal description
    variable rst: std_logic := '0';
  begin
    rstn <= rst;
    wait for rstDT;
    rst := not rst;
  end process;

  data : process    -- bus signals description
  begin
    d <= (others => '0');
    wait for rstDT;
    d <= x"ff00";
    wait for dataDT;
    d <= x"00ff";
    wait for dataDT;
    d <= x"ffff";
    wait for dataDT;
    d <= x"f0f0";
    wait for dataDT;
    d <= x"0f0f";
    wait for dataDT;
    d <= x"0000";
    wait for dataDT;
  end process;

END behavioral;