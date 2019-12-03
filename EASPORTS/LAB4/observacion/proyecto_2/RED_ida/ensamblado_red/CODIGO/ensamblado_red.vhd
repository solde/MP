--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;

use work.param_disenyo_pkg.all;
use work.multis_pkg.all;
use work.bus_multi_pkg.all;
use work.componentes_bus_multi_pkg.all;
use work.componentes_arbitro_pkg.all;
use work.interface_cache_bus_pkg.all;
use work.componentes_arbitraje_pkg.all;

entity ensamblado_red is 										
	port(reloj, pcero: in  std_logic;
		arb_control: in st_arb_peticiones;
		arb_peticiones: in st_arb_peticiones;
		arb_concesiones: out st_arb_concesiones;
		fin_trans: in std_logic;
		mpet_info_bus_c: in tp_bus_info;
		mpet_info_bus: out tp_peticion_info;
		mpet_cntl_bus_c: in tp_bus_control;
		mpet_cntl_bus: out tp_peticion_control);
end ensamblado_red;

architecture estructural of ensamblado_red is
signal t_arb_concesiones, t_t_arb_concesiones: st_arb_concesiones;
begin

--arbitro
arbitraje: arbitro port map (reloj => reloj, pcero => pcero, arb_control => arb_control, fin_trans => fin_trans,
							arb_peticiones => arb_peticiones, arb_concesiones => t_t_arb_concesiones);
arb_concesiones <= t_t_arb_concesiones;

reg_cnt: RD_arbi port map (reloj => reloj, pcero => pcero, e => t_t_arb_concesiones, s => t_arb_concesiones);

-- interconexiones: BUS
red_mu: red_multi port map (arb_concesiones => t_arb_concesiones, e_info => mpet_info_bus_c, e_cntl => mpet_cntl_bus_c, s_info => mpet_info_bus, s_cntl => mpet_cntl_bus);

end;

