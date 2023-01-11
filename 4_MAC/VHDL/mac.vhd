-- Title:         ES 4: MAC module
-- Description:   behavioral description of mac module
-- Author:        Nicola Franceschinis
-- Date:          20/12/2022

library ieee;
use	ieee.std_logic_1164.all;
use   ieee.fixed_pkg.all;
-- In/out description of buffer block
entity mac is
	generic (P  : integer := -16);	
      port (clr   : in  std_logic;
            clk   : in  std_logic;
            xr    : in  sfixed (0 downto P);
            xi    : in  sfixed (0 downto P);
            yr    : in  sfixed (0 downto P);
            yi    : in  sfixed (0 downto P);
            pr    : out  sfixed (0 downto P);
            pi    : out  sfixed (0 downto P);
            ovflw : out std_logic);
end entity;

--behavioral description of buffer block
architecture behavioral of mac is                  --behavioral -> functional description of the block
	constant p2    :  integer := 2 * P;

   constant N1    :  integer := 1;
   constant N2    :  integer := 2 * N1;
   constant N3    :  integer := N2 + 1;
   constant N4    :  integer := 2 * N2 + 1;
   constant N5    :  integer := 2 * N2 + 2;

   constant WIp   :  integer := N1;
   constant WIn   :  integer := P;
   constant WPPp  :  integer := N2;
   constant WPPn  :  integer := P2;
   constant WPCp  :  integer := N3;
   constant WPCn  :  integer := P2;
   constant WTp   :  integer := N3;
   constant WTn   :  integer := P - 2;
   constant WApE  :  integer := N5;
   constant WAnE  :  integer := P - 2;
   constant WAp   :  integer := N4;
   constant WAn   :  integer := P - 2;
   constant WOpE  :  integer := N2;
   constant WOnE  :  integer := P;
   constant WOp   :  integer := N1;
   constant WOn   :  integer := P;

   signal xryr    :  sfixed (WPPp downto WPPn);
   signal xiyi    :  sfixed (WPPp downto WPPn);
   signal xryi    :  sfixed (WPPp downto WPPn);
   signal xiyr    :  sfixed (WPPp downto WPPn);
   signal pcr     :  sfixed (WPCp downto WPCn);
   signal pci     :  sfixed (WPCp downto WPCn);
   signal pctr    :  sfixed (WTp  downto WTn);
   signal pcti    :  sfixed (WTp  downto WTn);
   signal pctrE   :  sfixed (WApE downto WAnE);
   signal pctiE   :  sfixed (WApE downto WAnE);

   signal accrE   :  sfixed (WApE downto WAnE);
   signal acciE   :  sfixed (WApE downto WAnE);
   signal accr    :  sfixed (WAp  downto WAn);
   signal acci    :  sfixed (WAp  downto WAn);
   signal prE     :  sfixed (WOpE downto WOnE);
   signal piE     :  sfixed (WOpE downto WOnE);

   signal SR      :  std_logic;

begin
	mac1 : process (clr, clk)  -- process description with signals sensitivity
   begin
      if (clk = '1' and clk'event) then
            if (clr = '0') then
               accr <= (others => '0');
               acci <= (others => '0');
               SR   <= '0';
            else
               xryr  <= resize (xr * yr, xryr);
               xiyi  <= resize (xi * yi, xiyi);
               xryi  <= resize (xr * yi, xryi);
               xiyr  <= resize (xi * yr, xiyr);
               pcr   <= resize (xryr - xiyi, pcr);
               pci   <= resize (xryi + xiyr, pci);
               pctr  <= resize (pcr, pctr);
               pcti  <= resize (pci, pcti);
               pctrE <= resize (pctr, pctrE);
               pctiE <= resize (pcti, pctiE);
               accrE <= resize (accrE + pctrE, accrE);
               acciE <= resize (acciE + pctiE, acciE);

               if (accrE >= 16 or accrE <= -16) then
                  SR <= '1';
               end if;

               accr <= resize (accrE, accr);
               acci <= resize (acciE, acci);

               prE <= resize (accrE, prE);
               piE <= resize (acciE, piE);

               if(prE >= 1 or accrE < -1) then
                  SR <= '1';
               end if;

               pr    <= resize (prE, pr);
               pi    <= resize (piE, pi);
               ovflw <= SR;

            end if;
      end if;
   end process;

end behavioral;