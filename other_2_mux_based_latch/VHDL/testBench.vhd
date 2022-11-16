-- Title:         ES 1_other: mux based latch
-- Description:   structural description of interconnection between mux module and vectorGenerator module
-- Author:        Nicola Franceschinis
-- Date:          07/11/2022

library ieee;
use ieee.std_logic_1164.all;

entity testBench is
end testBench;

architecture structural of testBench is                 -- structural -> describe how different parts are connected
  
  -- In/out description of inverter block
  component inverter is
	  port (a    : in  std_logic;
		      q	   : out std_logic);
  end component;
  -- In/out description of pass transistor positive block
  component passTRp is
    port (i    : in  std_logic;
          clk  : in  std_logic;
          o    : out std_logic;
          s    : out std_logic);
  end component;
  -- In/out description of pass transistor negative block
  component passTRn is
    port (i    : in  std_logic;
          clk  : in  std_logic;
          o    : out std_logic;
          s    : out std_logic);
  end component;
  -- In/out description of vectorGenerator block
  component vectorGenerator is
    port (d    : out  std_logic;
          clk  : out  std_logic;
		      q	   : in   std_logic;
          sn    : in   std_logic;
          sp    : in   std_logic);
  end component;
  -- description of interconnection signals (effective cables between blocks)
  signal dTB, clkTB, qTB, statenTB, statepTB: std_logic;
  signal ip1, ip2, ip3: std_logic;
BEGIN

  inv1 : inverter PORT MAP(a    => dTB,
                           q    => ip1);

  passTRp1: passTRp PORT MAP(i    => ip1,
                             clk  => clkTB,
                             o    => ip2,
                             s    => statepTB);
  
  inv2 : inverter PORT MAP(a    => ip2,
                           q    => qTB);

  inv3 : inverter PORT MAP(a    => qTB,
                           q    => ip3);

  passTRn1: passTRn PORT MAP(i    => ip3,
                             clk  => clkTB,
                             o    => ip2,
                             s    => statenTB);

  vector1 : vectorGenerator PORT MAP(d    => dTB,
                                     clk  => clkTB,
                                     q    => qTB,
                                     sn   => statenTB,
                                     sp   => statepTB);

END structural;