-- Title:         ES 1: Differential equation
-- Description:   behavioral description of vectorGenerator
-- Author:        Nicola Franceschinis
-- Date:          09/11/2022

library ieee;
use   ieee.std_logic_1164.all;
use   ieee.numeric_std.all;
use   ieee.fixed_pkg.all;     -- fixed , package
use   std.textio.all;

entity vectorGenerator is
   -- SSZ: Single Size
   -- DSZ: Double Size
   -- LLM: Lower Limit

   generic (SSZ : integer := 16;
            DSZ : integer := 2 * SSZ;
            LLM : integer := -16);

	port (clk   : out  std_logic;
        rstn  : out  std_logic;
	      xin	  : out  sfixed (SSZ-1 downto LLM);
		    yin	  : out  sfixed (SSZ-1 downto LLM);
        uin   : out  sfixed (SSZ-1 downto LLM);
        dx    : out  sfixed (SSZ-1 downto LLM);
        a     : out  sfixed (SSZ-1 downto LLM);
        x     : in   sfixed (DSZ-1 downto LLM);
        y     : in   sfixed (DSZ-1 downto LLM);
        done  : in   std_logic);
end vectorGenerator;

architecture behavioral of vectorGenerator is

  constant ckDT   : time := 100  ns;
  constant rstDT  : time := (0.5 * ckDT) - 20 ns;

  constant watchdog : integer := 100;

  constant outputName: string := "RESULTS/diffeqn.out";
  file     outputFile: text;

begin
  
  reset : process   -- rst signal description and file opening
  begin
    rstn <= '0';
    file_open (outputFile, outputName, write_mode);
    wait for rstDT;
    rstn <= '1';
    wait;
  end process;
  
  clock : process   -- clock signal description and data saving
    variable ck : std_logic := '0';
    variable counter : integer := '0';
    variable outputLine : line;
  begin
    clk <= ck;
    ck := not ck;
    wait for ckDT;
    -- Print temporary results
    if (clk = '1') then   -- print temporary and final results
      write (outputLine, string '("x: "));
      write (outputLine, to_real (x));
      write (outputLine, string '(" y: "));
      write (outputLine, to_real (y));
      writeline (outputFile, outputLine);
      counter := counter + 1;
    end if;
    if (done = '1' or counter > watchdog) then    --close file at the end
      file_close (outputFile);
      wait;
    end if;
  end process;

  inputValues : process    -- bus signals description
  begin
    xin <= to_sfixed (0.0, xin);
    yin <= to_sfixed (1.0, yin);
    uin <= to_sfixed (0.0, uin);
    dx  <= to_sfixed (0.001, dx);
    a   <= to_sfixed (3.0, a);
    wait;
  end process;

END behavioral;