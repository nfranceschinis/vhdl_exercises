-- Title:         ES 3: MIPS synthesis
-- Description:   structural description of interconnection in fetch section
-- Author:        Nicola Franceschinis
-- Date:          22/11/2022

library ieee;
use ieee.std_logic_1164.all;

entity fetchBench is
end fetchBench;

architecture structural of fetchBench is                 -- structural -> describe how different parts are connected
  --constants space
  constant N_logic : integer := 16;   --Select logic dimension
-- In/out description of adder module
component adder is
	generic (N : integer := 16);	-- 16 valore di default se nessun valore assegnato
	port (a    : in  std_logic_vector (N-1 downto 0);
	      b	   : in  std_logic_vector (N-1 downto 0);
		    q	   : out std_logic_vector (N-1 downto 0));
end component;
-- In/out description of instruction module
component instr_mem is
  generic (N_reg       : integer := 16);    -- default value 16
  port (instr_addr : in  std_logic_vector (N_reg-1 downto 0);
        instr_out  : out std_logic_vector (N_reg-1 downto 0));
end component;
-- In/out description of instruction module
component pc is
	generic (N : integer := 16);	-- 16 valore di default se nessun valore assegnato
	port (clk  : in	 std_logic;
		    a    : in  std_logic_vector (N-1 downto 0);
		    q	   : out std_logic_vector (N-1 downto 0));
end component;
-- In/out description of vectorGenerator for functional check
component vectorGenerator is
  generic (N  : integer := 16);
  port (clk   : out std_logic;
        jump  : out std_logic_vector (N-1 downto 0);
        instr : in  std_logic_vector (N-1 downto 0));
end component;

  -- description of interconnection signals (effective cables between blocks)
  signal instr_rdTB, instr_busTB: std_logic_vector (N_logic-1 downto 0);
  signal instr_addrTB, jumpTB: std_logic_vector (N_logic-1 downto 0);
  signal clkTB : std_logic;

  begin

    instr_mem1 : instr_mem generic map (N_reg => N_logic)
                      port map (instr_addr => instr_rdTB,
                                instr_out  => instr_busTB);

    pc1 : pc generic map (N => N_logic)
            port map (clk => clkTB,
                      a   => instr_addrTB,
                      q   => instr_rdTB);
    
    adder1 : adder generic map (N => N_logic)
                port map (a => instr_rdTB,
                          b => jumpTB,
                          q => instr_addrTB);

  vectorGenerator1 : vectorGenerator generic map (N => N_logic)
                                  port map (clk   => clkTB,
                                            jump  => jumpTB,
                                            instr => instr_busTB);  

end structural;