--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;

use work.param_disenyo_pkg.all;
use work.multis_pkg.all;

package componentes_arbitro_pkg is

component arbitro is 										
	port(reloj, pcero: in  std_logic;
		arb_control: in st_arb_peticiones;
		fin_trans: std_logic;
		arb_peticiones: in st_arb_peticiones;
		arb_concesiones: out st_arb_concesiones);
end component;

end package componentes_arbitro_pkg;
