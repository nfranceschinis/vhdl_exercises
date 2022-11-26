-- Title:         ES 3: MIPS synthesis
-- Description:   structural description of instruction memory module
-- Author:        Nicola Franceschinis
-- Date:          22/11/2022

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity rom_mem is
  generic (N_reg       : integer := 16);    -- default value 16
      port (instr_addr : in  std_logic_vector (N_reg-1 downto 0);
            instr_out  : out std_logic_vector (N_reg-1 downto 0));
end entity;

architecture behavioral of rom_mem is

constant N_rom: integer := 4;

signal rom_addr: std_logic_vector (N_rom-1 downto 0);
type ROM_type is array (0 to 15) of std_logic_vector (15 downto 0);
constant rom_data: ROM_type:=(
   "1000000110000000",
   "0010110010001011",
   "1100010000000011",
   "0001000111000000",
   "1110110110000001",
   "1100000001111011",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000"
  );
begin
  rom_addr <= instr_addr (N_reg downto 1);
  instr_out <= rom_data (to_integer(unsigned (rom_addr))) when instr_addr < x"0020" else x"0000";
end architecture;