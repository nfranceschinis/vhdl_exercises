-- Title:         ES3: MIPS processor
-- Description:   structural description of interconnection between alu module and vectorGenerator module
-- Author:        Nicola Franceschinis
-- Date:          07/11/2022

library ieee;
use ieee.std_logic_1164.all;

entity aluTB is
end entity;

architecture structural of aluTB is                 -- structural -> describe how different parts are connected
  component alu is
  generic (N    : integer := 16);
  port (data1   : in  std_logic_vector (N-1 downto 0);
        data2   : in  std_logic_vector (N-1 downto 0);
        ALUctrl : in  std_logic_vector (3 downto 0);
        zflag   : out std_logic;
        result  : out std_logic_vector (N-1 downto 0));
end component;

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
  
  constant N_size: integer := 16;

  signal data1TB   :  std_logic_vector (N_size-1 downto 0);
  signal data2TB   : std_logic_vector (N_size-1 downto 0);
  signal ALUctrlTB : std_logic_vector (3 downto 0);
  signal zflagTB   : std_logic;
  signal resultTB  : std_logic_vector (N_size-1 downto 0);

begin
    alu1: alu generic map (N => 16)
            port map (data1   => data1TB,
                      data2   => data2TB,
                      ALUctrl => ALUctrlTB,
                      zflag   => zflagTB,
                      result  => resultTB);

end structural;