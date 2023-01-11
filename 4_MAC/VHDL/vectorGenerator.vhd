-- Title:         ES 4: MAC module
-- Description:   behavioral description of VectorGenerator
-- Author:        Nicola Franceschinis
-- Date:          20/12/2022
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;
use ieee.math_real.all;
use std.textio.all;


entity vectorGenerator is
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
end entity;

architecture behavioral of vectorGenerator is

  constant ckDT   : time := 50  ns;
  constant ckHDT  : time := 0.5 * ckDT;

  constant totalDataN : integer := NP * N;
  
  file iFile  : text;
  file oFile  : text;

begin

  fileopen : process
    constant Ifilename : string := "RESULTS/MAC.in";
    constant Ofilename : string := "RESULTS/MAC.out";
  begin
    file_open (iFile, Ifilename, READ_MODE);
    file_open (oFile, Ofilename, WRITE_MODE);
    wait;
  end process;

  clock : process   -- clock signal description and data saving
    variable inLine     : line;
    variable outLine    : line;
    variable clkTmp     : std_logic := '0';
    variable endFlag    : boolean;
    variable xrR, xiR, yrR, yiR : real;
    variable count      : integer := 0;
    variable clrCounter : integer := 0;

  begin
    if (count = totalDataN) then
      file_close (iFile);
      file_close (oFile);
      wait;
    end if;
    if (clrCounter = N) then
      clr <= '0';
    else
      clr <= '1';
    end if;
    clk <= clkTmp;
    clkTmp := not clkTmp;
    readline (iFile, inLine);
    read (inLine, xrR, endFlag);
    read (inLine, xiR, endFlag);
    read (inLine, yrR, endFlag);
    read (inLine, yiR, endFlag);
    xr <= to_sfixed (xrR, 0, endFlag);
    xi <= to_sfixed (xiR, 0, endFlag);
    yr <= to_sfixed (yrR, 0, endFlag);
    yi <= to_sfixed (yiR, 0, endFlag);
    wait for ckHDT;
    if (clrCounter = N) then
      clr <= '1';
      clrCounter := 0;
    end if;
    write (outLine, pr);
    write (outLine, string'(" - "));
    write (outLine, pi);
    writeline (oFile, outLine);
    count := count + 1;
    clrCounter := clrCounter + 1;
  end process;

end behavioral;