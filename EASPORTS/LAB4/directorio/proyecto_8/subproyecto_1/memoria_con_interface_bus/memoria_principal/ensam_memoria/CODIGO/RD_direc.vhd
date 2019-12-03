--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library IEEE;
use IEEE.std_logic_1164.all;

use work.param_disenyo_pkg.all;
use work.retardos_RegDes_pkg.all;

entity RD_direc is							
  port (reloj: in std_logic;		
         e: in st_dir;
         s: out st_dir);
end;

architecture comportamiento of RD_direc is
  begin
     process (reloj) begin
       if rising_edge(reloj) then
           s <= e after retREGDES; 
       end if;
     end process;
end;

