--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library IEEE;
use IEEE.std_logic_1164.all;

entity RD_arbi_0 is							-- registro con puesta a cero asincrona
  port (reloj, pini, pe: in std_logic;		-- pini: senyal de puesta a cero
         e: in std_logic;
         s: out std_logic);
end;

architecture comportamiento of RD_arbi_0 is
  begin
process (reloj, pini, pe) begin
	if pini = '1' then
		s <= '0';
	elsif rising_edge(reloj) then
		if pe = '1' then
			s <= e;
		end if;
	end if;
end process;
end;

