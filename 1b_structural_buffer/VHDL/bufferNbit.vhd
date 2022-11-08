-- Title:         ES 1b: Syncronized n-buffer
-- Description:   structural description of  single buffer module
-- Author:        Nicola Franceschinis
-- Date:          08/11/2022

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity bufferNbit is
  generic (N    : integer := 8);    -- default value 8
  port (clk     : in  std_logic;
        rstn    : in  std_logic;
	    d	    : in  std_logic_vector (N-1 downto 0);
		q	    : out std_logic_vector (N-1 downto 0));
end entity;

architecture structural of bufferNbit is
  component buffer1bit is
    port (clkBit   : in  std_logic;
          rstnBit  : in  std_logic;
	      dBit	    : in  std_logic;
		  qBit	    : out std_logic);
  end component;

  signal dBus, qBus: std_logic_vector (N-1 downto 0);
begin
    q <= qBus;
    qBus <= d;
    bufferNbit : for i in 0 to N-1 generate
        bufferI : buffer1bit port map (clkBit   => clk,
                                       rstnBit  => rstn,
                                       dBit     => d(i),
                                       qBit     => q(i));
    end generate;

end architecture;