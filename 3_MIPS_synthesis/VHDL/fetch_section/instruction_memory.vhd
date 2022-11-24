-- Title:         ES 3: MIPS synthesis
-- Description:   structural description of instruction memory module
-- Author:        Nicola Franceschinis
-- Date:          22/11/2022

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity instr_mem is
  generic (N_reg       : integer := 16);    -- default value 16
      port (instr_addr : in  std_logic_vector (N_reg-1 downto 0);
            instr_out  : out std_logic_vector (N_reg-1 downto 0));
end entity;

architecture structural of instr_mem is
  component Nregister is
    generic (N      : integer := 16);    -- default value 16
    port (rstn      : in  std_logic;
	      d	          : in  std_logic_vector (N-1 downto 0);
		    q	          : out std_logic_vector (N-1 downto 0));
end component;

  --signal rstnBus: std_logic_vector (N-1 downto 0);
begin
    instr_mem : for i in 0 to N_reg-1 generate
        registerI : Nregister port map (
                                        d     => instr_addr(i),
                                        q     => instr_out(i));
    end generate;
-- Rivedere assolutamente!
end architecture;