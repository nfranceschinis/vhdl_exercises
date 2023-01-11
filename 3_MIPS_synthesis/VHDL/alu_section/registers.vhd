-- Title:         ES 3: MIPS synthesis
-- Description:   behavioral description of registers module
-- Author:        Nicola Franceschinis
-- Date:          22/11/2022

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity registers is
  generic (N     : integer := 16);
  port (rd_reg1  : in std_logic_vector (N-1 downto 0);
        rd_reg2  : in std_logic_vector (N-1 downto 0);
        wr_reg   : in std_logic_vector (N-1 downto 0);
        wr_data  : in std_logic_vector (N-1 downto 0);
        rd_data1 : out std_logic_vector (N-1 downto 0);
        rd_data2 : out std_logic_vector (N-1 downto 0);
        wr_en    : in std_logic);
end entity;

architecture behavioral of registers is

type reg_type is array (0 to 7 ) of std_logic_vector (15 downto 0);
signal reg_array: reg_type;

begin

end architecture;