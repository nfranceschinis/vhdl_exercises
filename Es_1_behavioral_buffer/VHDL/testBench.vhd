LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testBench IS
END testBench;

ARCHITECTURE structural OF testBench IS                 -- structural -> describe how different parts are connected
  CONSTANT N : INTEGER := 16;
  CONSTANT NTB : INTEGER := 16;
  
  COMPONENT buf
    GENERIC (N : integer);
      PORT (clk  : IN STD_LOGIC;
            rstn : IN STD_LOGIC;
            d    : IN STD_LOGIC_VECTOR (N-1 downto 0);
            q    : OUT STD_LOGIC_VECTOR (N-1 downto 0));
  END COMPONENT;

  COMPONENT vectorGenerator
    GENERIC (N : integer);
    PORT (clk  : OUT STD_LOGIC;
          rstn : OUT STD_LOGIC;
          d    : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0);
          q    : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0));
  END COMPONENT;

  SIGNAL clkTB, rstnTB : STD_LOGIC;
  SIGNAL dTB, qTB : STD_LOGIC_VECTOR (N-1 DOWNTO 0);

BEGIN
  d1 : buf GENERIC MAP( N => NTB)
          PORT MAP(q    => qTB,
                               rstn => rstnTB,
                               clk  => clkTB,
                               d    => dTB);

  v1 : vectorGenerator GENERIC MAP( N => NTB)
                               PORT MAP(q    => qTB,
                                        rstn => rstnTB,
                                        clk  => clkTB,
                                        d    => dTB);

END structural;