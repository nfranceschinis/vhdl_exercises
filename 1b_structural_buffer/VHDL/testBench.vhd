-- Title:         ES 1: Syncronized n-buffer
-- Description:   structural description of interconnection between buffer module and vectorGenerator module
-- Author:        Nicola Franceschinis
-- Date:          07/11/2022

library ieee;
use ieee.std_logic_1164.all;

entity testBench is
end testBench;

architecture structural of testBench is                 -- structural -> describe how different parts are connected
  --constants space
  constant NTB : integer := 16;   --Select number of input/output
  
  -- In/out description of buffer block
  component bufferNbit is
	  generic (N  : integer);
	  port (clk   : in  std_logic;
          rstn  : in  std_logic;
			    d	    : in  std_logic_vector (N-1 downto 0);
			    q	    : out std_logic_vector (N-1 downto 0));
  end component;
  -- In/out description of vectorGenerator block
  component vectorGenerator is
    generic (N  : integer);
    port (clk   : out  std_logic;
          rstn  : out  std_logic;
          d     : out  std_logic_vector (N-1 downto 0);
          q     : in   std_logic_vector (N-1 downto 0));
  end component;
  -- description of interconnection signals (effective cables between blocks)
  signal clkTB, rstnTB : std_logic;
  signal dTB, qTB : std_logic_vector (NTB-1 downto 0);

BEGIN

  buffer1 : bufferNbit GENERIC MAP( N => NTB)
           PORT MAP(q    => qTB,
                    rstn => rstnTB,
                    clk  => clkTB,
                    d    => dTB);

  vector1 : vectorGenerator GENERIC MAP( N => NTB)
                       PORT MAP(q    => qTB,
                                rstn => rstnTB,
                                clk  => clkTB,
                                d    => dTB);

END structural;