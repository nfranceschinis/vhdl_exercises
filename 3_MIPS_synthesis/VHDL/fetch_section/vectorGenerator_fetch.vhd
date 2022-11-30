-- Title:         ES 3: MIPS synthesis
-- Description:   behavioral description of vectorGenerator
-- Author:        Nicola Franceschinis
-- Date:          22/11/2022

library ieee;
use   ieee.std_logic_1164.all;
use   ieee.numeric_std.all;
use   ieee.fixed_pkg.all;     -- fixed , package
use   std.textio.all;

entity vectorGenerator is
  generic (N  : integer := 16);
  port (clk   : out std_logic;
        jump  : out std_logic_vector (N-1 downto 0);
        q : in  std_logic_vector (N-1 downto 0));
end entity;

architecture behavioral of vectorGenerator is

  constant ckDT      : time := 100  ns;
  constant jumpDT    : time := 3 * ckDT;
  constant jumpConst : integer := 4;
  constant watchdog  : integer := 10;

  constant outputName: string := "..RESULTS/reg_mem_read.out";
  file     outputFile: text;

begin
  
  setup : process   -- file opening
  begin
    file_open (outputFile, outputName, write_mode);
    wait for ckDT;
  end process;
  
  clock : process   -- clock signal description and data saving
    variable ck : std_logic := '0';
    variable counter : integer := 0;
    variable outputLine : line;
  begin
    clk <= ck;
    ck := not ck;
    wait for ckDT;
    -- Print temporary results
    if (clk = '1') then   -- print temporary and final results
      write (outputLine, string '("instr: "));
      write (outputLine, to_integer (unsigned (q)));
      write (outputLine, string '(" jump: "));
      write (outputLine, to_integer (unsigned (jump)));
      writeline (outputFile, outputLine);
      counter := counter + 1;
    end if;
    if (counter > watchdog) then    --close file at the end
      file_close (outputFile);
      wait;
    end if;
  end process;

  jumper : process    -- bus signals description
  begin
    wait for jumpDT;
    jump <= std_logic_vector(to_unsigned(jumpConst, jump'length));
  end process;

end architecture;