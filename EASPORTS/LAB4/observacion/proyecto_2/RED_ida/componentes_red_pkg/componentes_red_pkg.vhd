--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;

use work.multis_pkg.all;
use work.interface_cache_bus_pkg.all;
use work.bus_multi_pkg.all;

package componentes_red_pkg is

component ensamblado_red is 										
	port(reloj, pcero: in  std_logic;
		arb_control: in st_arb_peticiones;
		arb_peticiones: in st_arb_peticiones;
		arb_concesiones: out st_arb_concesiones;
		fin_trans: in std_logic;
		mpet_info_bus_c: in tp_bus_info;
		mpet_info_bus: out tp_peticion_info;
		mpet_cntl_bus_c: in tp_bus_control;
		mpet_cntl_bus: out tp_peticion_control);
end component;

end package componentes_red_pkg;



