--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library IEEE;
use IEEE.std_logic_1164.all;

use work.interface_observador_pkg.all;
use work.retardos_RegDes_pkg.all;

entity RD_pe_obser is							-- registro con inicializacion a cero asincrona
  port (reloj, pcero, pe: in std_logic;		-- pcero: senyal de inicializacion
         e: in tp_observacion;				-- pe: permiso de escritura
         s: out tp_observacion);
end;

architecture comportamiento of RD_pe_obser is
  begin
     process (reloj, pcero) begin
       if pcero = '1' then s <= (dir => (others => '0'), pet => '0', les => '0', iden => (others => '0')) after retREGDES;
       elsif rising_edge(reloj) then
			if pe = '1' then
              s <= e after retREGDES;
			end if;
       end if;
     end process;
end;

