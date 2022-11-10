-- Title:         ES 1: Syncronized n-buffer
-- Description:   behavioral description of vectorGenerator test for parametric input data
-- Author:        Nicola Franceschinis
-- Date:          07/11/2022

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

  constant ckDT   : time := 50  ns;
  constant rstDT  : time := 145 ns;
  constant dataDT : time := 5   ns;

  constant inputValues : string := "VHDL/inputData.vsg";
  file     inputFile   : text; 

  constant outputName : string := "RESULTS/diffeqn.out";
  file     outputFile : text;

begin
  
  reset : process   -- rst signal description and file opening
    variable rst: std_logic := '0';
  begin
    rstn <= rst;
    file_open (outputFile, outputName, write_mode);
    wait for rstDT;
    rst := not rst;
  end process;
  
  clock : process   -- clock signal description and data saving
    variable ck : std_logic := '0';
    variable outputLine : line;
  begin
    clk <= ck;
    ck := not ck;
    wait for ckDT;
    if (clk = '1') then   -- print temporary and final results
      write (outputLine, string '("x: "));
      write (outputLine, to_real (x));
      write (outputLine, string '(" y: "));
      write (outputLine, to_real (y));
      writeline (outputFile, outputLine);
    end if;
    if (done = '1') then    --close file at the end
      file_close (outputFile);
      end if;
  end process;

  initValues : process    -- bus signals description
    variable row : line;
    variable raw_data : std_logic := 0;
  begin
    file_open (inputFile, inputValues, read_mode);
    readline (inputFile, row);
    read (row, raw_data);
    xin <= to_sfixed (raw_data, uin);
    readline (inputFile, row);
    read (row, raw_data);
    yin <= to_sfixed (raw_data, yin);
    readline (inputFile, row);
    read (row, raw_data);
    uin <= to_sfixed (raw_data, uin);
    readline (inputFile, row);
    read (row, raw_data);
    dx  <= to_sfixed (raw_data, dx);
    readline (inputFile, row);
    read (row, raw_data);
    a   <= to_sfixed (raw_data, a);
    wait for dataDT;
  end process;

END behavioral;