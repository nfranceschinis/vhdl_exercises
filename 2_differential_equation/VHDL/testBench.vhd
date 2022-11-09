-- Title:         ES 2: Differential equation
-- Description:   structural description of interconnection between computational module and vectorGenerator module
-- Author:        Nicola Franceschinis
-- Date:          09/11/2022

library ieee;
use ieee.std_logic_1164.all;
use   ieee.numeric_std.all;
use   ieee.fixed_pkg.all;     -- fixed , package

entity testBench is
end testBench;

architecture structural of testBench is                 -- structural -> describe how different parts are connected
  
  constant SSZ: integer := 16;
  constant DSZ: integer := 2 * SSZ;
  constant LLM: integer := -16;

  component diffeq is
   -- SSZ: Single Size
   -- DSZ: Double Size
   -- LLM: Lower Limit

   generic (SSZ : integer;
            DSZ : integer;
            LLM : integer);

	port (clk   : in  std_logic;
        rstn  : in  std_logic;
	      xin	  : in  sfixed (SSZ-1 downto LLM);
		    yin	  : in  sfixed (SSZ-1 downto LLM);
        uin   : in  sfixed (SSZ-1 downto LLM);
        dx    : in  sfixed (SSZ-1 downto LLM);
        a     : in  sfixed (SSZ-1 downto LLM);
        x     : out sfixed (SSZ-1 downto LLM);
        y     : out sfixed (SSZ-1 downto LLM);
        done  : out std_logic);
end component;
  -- In/out description of vectorGenerator block
  component vectorGenerator is
   -- SSZ: Single Size
   -- DSZ: Double Size
   -- LLM: Lower Limit

   generic (SSZ : integer;
            DSZ : integer;
            LLM : integer);

	port (clk   : out  std_logic;
        rstn  : out  std_logic;
	      xin	  : out  sfixed (SSZ-1 downto LLM);
		    yin	  : out  sfixed (SSZ-1 downto LLM);
        uin   : out  sfixed (SSZ-1 downto LLM);
        dx    : out  sfixed (SSZ-1 downto LLM);
        a     : out  sfixed (SSZ-1 downto LLM);
        x     : in   sfixed (SSZ-1 downto LLM);
        y     : in   sfixed (SSZ-1 downto LLM);
        done  : in   std_logic);
end component;
  -- description of interconnection signals (effective cables between blocks)
  signal clkTB, rstnTB : std_logic;
  signal xinTB, yinTB, uinTB, dxTB, aTB : sfixed (SSZ-1 downto LLM);
  signal xTB, yTB : sfixed (SSZ-1 downto LLM);
  signal doneTB : std_logic; 

BEGIN

  eqn1 : diffeq GENERIC MAP(SSZ <= SSZ,
                            DSZ <= DSZ,
                            LLM <= LLM)
                PORT MAP(rstn => rstnTB,
                         clk  => clkTB,
                         xin => xinTB,
                         yin => yinTB,
                         uin => uinTB,
                         dx => dxTB,
                         a => aTB,
                         x => xTB,
                         y => yTB,
                         done => doneTB);
  
  vectorGenerator1 : vectorGenerator GENERIC MAP(SSZ <= SSZ,
                            DSZ <= DSZ,
                            LLM <= LLM)
                PORT MAP(rstn => rstnTB,
                         clk  => clkTB,
                         xin => xinTB,
                         yin => yinTB,
                         uin => uinTB,
                         dx => dxTB,
                         a => aTB,
                         x => xTB,
                         y => yTB,
                         done => doneTB);
end structural;