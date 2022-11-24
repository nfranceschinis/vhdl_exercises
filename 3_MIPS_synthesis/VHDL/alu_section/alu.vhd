-- Title:         ES 3: MIPS synthesis
-- Description:   behavioral description of alu module
-- Author:        Nicola Franceschinis
-- Date:          22/11/2022

library ieee;
use ieee.std_logic_1164.all;
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
  --cmd table
  constant sumOP : std_logic_vector := 0b"0000";
  constant subOP : std_logic_vector := 0b"0001";
  constant eqOP  : std_logic_vector := 0b"0010";
  constant neqOP : std_logic_vector := 0b"0011";
  constant andOP : std_logic_vector := 0b"0100";
  constant orOP  : std_logic_vector := 0b"0101";
  constant xorOP : std_logic_vector := 0b"0110";
  constant lshOP : std_logic_vector := 0b"0111";
  constant rshOP : std_logic_vector := 0b"1000";

  begin
  process (data1, data2, ALUctrl)
  begin
      case ALUctrl is
          when sumOP => 
            result <= std_logic_vector (unsigned (data1) + unsigned (data2));
          when subOP => 
            result <= std_logic_vector (unsigned (data1) - unsigned (data2));
          when eqOP =>
            zflag <= '1' when (data1 = data2) else '0';
          when neqOP =>
            zflag <= '1' when (data1 /= data2) else '0';
          when andOP =>
            result <= data1 and data2;
          when orOP =>
            result <= data1 or data2;
          when xorOP =>
            result <= data1 xor data2;
          when lshOP =>
            result <= shift_left (data1);
          when rshOP =>
            result <= shift_right (data1);
      end case;
end process;
end architecture;