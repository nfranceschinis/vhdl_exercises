-- Title:         ES 4: MAC module
-- Description:   structural description of interconnection between mac module and vectorGenerator module
-- Author:        Nicola Franceschinis
-- Date:          20/12/2022

library ieee;
use ieee.std_logic_1164.all;

entity testBench is
end testBench;

architecture structural of testBench is                 -- structural -> describe how different parts are connected
  --constants space
  constant LP   : integer := -15;
  constant LNP  : integer := 1;
  constant LN   : integer := 3;
  
  -- In/out description of buffer block
  component mac is
    generic (P  : integer := -16);	
      port (clr   : in  std_logic;
            clk   : in  std_logic;
            xr    : in  sfixed (0 downto P);
            xi    : in  sfixed (0 downto P);
            yr    : in  sfixed (0 downto P);
            yi    : in  sfixed (0 downto P);
            pr    : out  sfixed (0 downto P);
            pi    : out  sfixed (0 downto P);
            ovflw : out std_logic);
  end component;
  -- In/out description of vectorGenerator block
  component vectorGenerator is
    generic (P  : integer;
             NP : integer;
             N  : integer);	
      port (clr   : out  std_logic;
            clk   : out  std_logic;
            xr    : out  sfixed (0 downto P);
            xi    : out  sfixed (0 downto P);
            yr    : out  sfixed (0 downto P);
            yi    : out  sfixed (0 downto P);
            pr    : in  sfixed (0 downto P);
            pi    : in  sfixed (0 downto P);
            ovflw : in std_logic);
  end component;
  -- description of interconnection signals (effective cables between blocks)
  signal clrTB     : std_logic;
  signal clkTB     : std_logic;
  signal xrTB      : sfixed (0 downto LP);
  signal xiTB      : sfixed (0 downto LP);
  signal yrTB      : sfixed (0 downto LP);
  signal yiTB      : sfixed (0 downto LP);
  signal prTB      : sfixed (0 downto LP);
  signal piTB      : sfixed (0 downto LP);
  signal ovflwTB   : std_logic;

begin

  mac1 : mac generic map(P => LP)
        port map(clr => clrTB,
          clk => clkTB,
          xr  => xrTB,
          xi  => xiTB,
          yr  => yrTB,
          yi  => yiTB,
          pr  => prTB,
          pi  => piTB,
          ovflw => ovflwTB);

  vector1 : vectorGenerator generic map(P  => LP,
                                        NP => LNP,
                                        N  => LN)
                       port map(clr => clrTB,
                                clk => clkTB,
                                xr  => xrTB,
                                xi  => xiTB,
                                yr  => yrTB,
                                yi  => yiTB,
                                pr  => prTB,
                                pi  => piTB,
                                ovflw => ovflwTB);

end structural;