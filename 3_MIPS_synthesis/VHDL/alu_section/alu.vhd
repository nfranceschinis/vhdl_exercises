-- Title:         ES 3: MIPS synthesis
-- Description:   behavioral description of alu module
-- Author:        Nicola Franceschinis
-- Date:          22/11/2022

library ieee;
  use	ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity alu is
  generic (N    : integer := 16);
  port (data1   : in  std_logic_vector (N-1 downto 0);
        data2   : in  std_logic_vector (N-1 downto 0);
        ALUctrl : in  std_logic_vector (3 downto 0);
        zflag   : out std_logic;
        result  : out std_logic_vector (N-1 downto 0));
end entity;

architecture behavioral of alu is

  constant sumOP : std_logic_vector := "0000";
  constant subOP : std_logic_vector := "0001";
  constant eqOP  : std_logic_vector := "0010";
  constant neqOP : std_logic_vector := "0011";
  constant andOP : std_logic_vector := "0100";
  constant orOP  : std_logic_vector := "0101";
  constant xorOP : std_logic_vector := "0110";
  constant lshfOP: std_logic_vector := "0111";
  constant rshfOP: std_logic_vector := "1000";

process (data1, data2, ALUctrl)
  begin
      case ALUctrl is
          when sumOP => result <= unsigned (data1) + unsigned (data2);
          when others
      end case;
  end process;
end architecture;