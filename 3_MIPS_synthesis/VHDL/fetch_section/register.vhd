-- Title:         ES 3: MIPS synthesis
-- Description:   structural description of single register module
-- Author:        Nicola Franceschinis
-- Date:          22/11/2022

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity Nregister is
  generic (N      : integer := 16);    -- default value 16
  port (rstn      : in  std_logic;
	      d	        : in  std_logic_vector (N-1 downto 0);
		    q	        : out std_logic_vector (N-1 downto 0));
end entity;

architecture structural of Nregister is
  component buffer1bit is
    port (rstnBit   : in  std_logic;
	        dBit	    : in  std_logic;
		      qBit	    : out std_logic);
  end component;

  signal qBus: std_logic_vector (N-1 downto 0);
begin
    q <= qBus;
    qBus <= d;
    bufferNbit : for i in 0 to N-1 generate
        bufferI : buffer1bit port map (rstnBit  => rstn,
                                       dBit     => d(i),
                                       qBit     => q(i));
    end generate;

end architecture;