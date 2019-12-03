--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library IEEE;
use IEEE.std_logic_1164.all;

use work.interface_observador_pkg.all;
use work.retardos_RegDes_pkg.all;

entity RD_obser_cntl_mem is							
  port (reloj: in std_logic;		
         e: in tp_observacion;
         s: out tp_observacion);
end;

architecture comportamiento of RD_obser_cntl_mem is
  begin
     process (reloj) begin
       if rising_edge(reloj) then
           s <= e after retREGDES; 
       end if;
     end process;
end;

