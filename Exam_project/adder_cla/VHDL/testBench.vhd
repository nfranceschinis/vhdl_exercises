-- Title:         EXM 1: CLA adder
-- Description:   behavioral description of partial full adder module
-- Author:        Nicola Franceschinis
-- Date:          10/01/2023

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY testBench IS
END testBench;

ARCHITECTURE structural OF testBench IS                 -- structural -> describe how different parts are connected
  --EDIT THIS VARIABLE TO CHANGE INPUT/OUTPUT SIZE NUMBER
  CONSTANT NTB : integer := 4;   
  
  -- In/out description of carry look ahead block
  COMPONENT carry_look_ahead IS
    GENERIC (N    : integer);
       PORT (a           : IN  STD_LOGIC_VECTOR (N-1 DOWNTO 0);
             b           : IN  STD_LOGIC_VECTOR (N-1 DOWNTO 0);
             carryIn	   : IN  STD_LOGIC;
             sum	       : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0);
             carryOut    : OUT STD_LOGIC);
  END COMPONENT;
  -- In/out description of vectorGenerator block
  COMPONENT vectorGenerator IS
    generic (N    : integer);
       port (a           : OUT  STD_LOGIC_VECTOR (N-1 DOWNTO 0);
             b           : OUT  STD_LOGIC_VECTOR (N-1 DOWNTO 0);
             carryIn	   : OUT  STD_LOGIC;
             sum	       : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
             carryOut    : IN STD_LOGIC);
  END COMPONENT;
  -- Input
  SIGNAL aTB, bTB : STD_LOGIC_VECTOR (NTB - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL CinTB    : STD_LOGIC := '0';
  -- Output
  SIGNAL sumTB      : STD_LOGIC_VECTOR (NTB - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL CoutTB   : STD_LOGIC := '0';

BEGIN

  

  clu : carry_look_ahead GENERIC MAP( N       => NTB)
                            PORT MAP(a        => aTB,
                                     b        => bTB,
                                     carryIn  => CinTB,
                                     sum      => sumTB,
                                     carryOut => CoutTB);

  vector1 : vectorGenerator GENERIC MAP( N       => NTB)
                               PORT MAP(a        => aTB,
                                        b        => bTB,
                                        carryIn  => CinTB,
                                        sum      => sumTB,
                                        carryOut => CoutTB);

END structural;