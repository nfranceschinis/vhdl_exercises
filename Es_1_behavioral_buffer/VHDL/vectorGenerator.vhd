LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY vectorGenerator IS
    GENERIC (N : integer);
  PORT (
    clk  : OUT STD_LOGIC;
    rstn : OUT STD_LOGIC;
    d    : OUT STD_LOGIC_VECTOR (N-1 downto 0);
    q    : IN STD_LOGIC_VECTOR (N-1 downto 0));
END vectorGenerator;

ARCHITECTURE behavioral OF vectorGenerator IS

  CONSTANT DT           : TIME := 50 ns;
  constant dtr          : time := 120 ns;

  --SIGNAL id, iClk, iRstn : STD_LOGIC;

BEGIN
  PROCESS
        VARIABLE ck : std_logic := '0';
  BEGIN
    clk <= ck;
    WAIT FOR DT;
    ck := NOT ck;
  END PROCESS;

  PROCESS
    VARIABLE clkTmp : STD_LOGIC := '0';
        BEGIN
        rstn <= '0';
        WAIT FOR dtr;
        rstn <= '1';
        wait;
  END PROCESS;

  PROCESS
    BEGIN
        d <= (OTHERS => '0');
        WAIT FOR dtr;
        d <= X"FF00";
        WAIT FOR dtr;
        d <= X"F0F0";
        WAIT FOR dtr;
        d <= X"F00F";
        WAIT FOR dtr;
        d <= X"0FF0";
        WAIT FOR Dtr;
        d <= X"0F0F";
        WAIT FOR dtr;
        d <= X"00FF";
        WAIT;
    END PROCESS;

  --clk  <= iClk;
  --rstn <= iRstn;
  --d    <= id;
END behavioral;