-- Title:         ES 2: Differential equation
-- Description:   behavioral description of computational module
-- Author:        Nicola Franceschinis
-- Date:          09/11/2022

library ieee;
use	ieee.std_logic_1164.all;
use   ieee.numeric_std.all;
use   ieee.fixed_pkg.all;     -- fixed , package
-- In/out description of differential equation block
entity diffeqn is
   -- SSZ: Single Size
   -- DSZ: Double Size
   -- LLM: Lower Limit

   generic (SSZ : integer;
            DSZ : integer;
            LLM : integer);

	port (clk   : in  std_logic;
         rstn  : in  std_logic;
	      xin	: in  sfixed (SSZ-1 downto LLM);
		   yin	: in  sfixed (SSZ-1 downto LLM);
         uin   : in  sfixed (SSZ-1 downto LLM);
         dx    : in  sfixed (SSZ-1 downto LLM);
         a     : in  sfixed (SSZ-1 downto LLM);
         x     : out sfixed (DSZ-1 downto LLM);
         y     : out sfixed (DSZ-1 downto LLM);
         done  : out std_logic);
end diffeqn;
-- using SFIXED instead of STD_LOGIC_VECTOR because we can use negative low values and represent fixed point numbers
--behavioral description of diffeq block
architecture behavioral of diffeqn is
	
   signal u : sfixed (DSZ-1 downto LLM);

   -- xin   : starting x
   -- yin   : y(xin)
   -- uin   : y'(xin)
   -- dx    : x increment
   -- a     : upper limit
   -- x     : output progressive x
   -- y     : output progressive y
   -- done  : completion flag

   -- u: resized uin
begin

	diffeq : process (rstn, clk)  -- process dBitescription with signals sensitivity
   begin
      if (rstn = '0') then
         x    <= resize (xin, x);
         y    <= resize (yin, y);
         u    <= resize (uin, u);
         done <= '0';
      else
         if (clk = '1' and clk'event) then
            x <= resize (x + dx, x);
            y <= resize (y + x * dx, y);
            u <= resize (u - (3 * x * u * dx) - (3 * y * dx), u);
            if (x >= a) then
               done <= '1';
            else
               done <= '0';
            end if;
         end if;
      end if;
   end process;

end behavioral;