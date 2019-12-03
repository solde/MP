--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;

use work.param_disenyo_pkg.all;
use work.componentes_cache_multi_interface_pkg.all;
use work.componentes_memoria_interface_pkg.all;
use work.cache_pkg.all;
use work.interface_cache_bus_pkg.all;
use work.interface_observador_pkg.all;
use work.componentes_arbitro_pkg.all;
use work.multis_pkg.all;
use work.bus_multi_pkg.all;
use work.componentes_bus_multi_pkg.all;
use work.componentes_interfaces_bus_multi_pkg.all;
use work.componentes_red_pkg.all;
--! @image html sistema_multi_vuelta_pto_pto.png 

entity ensamblado_multi is 										
	port(reloj, pcero: in  std_logic;
		arb_control: in st_arb_peticiones;
		pet_proc: in tp_peticiones_multi;
		pet_listo: out tp_cache_listo_multi;
		resp_cache: out tp_respuesta_multi);
end ensamblado_multi;


architecture estructural of ensamblado_multi is

signal mpet_cntl_bus: tp_peticion_control;
signal mresp_cntl_bus_c: tp_bus_control_resp;

signal mpet_info_bus: tp_peticion_info;
signal mresp_info_bus_c: tp_bus_info_resp;

signal mpet_cntl_bus_c: tp_bus_control;
signal mpet_info_bus_c: tp_bus_info;

signal arb_peticiones: st_arb_peticiones;
signal arb_concesiones: st_arb_concesiones;

signal obs_bus_c: tp_bus_observacion;

signal t_arb_concesiones: st_arb_concesiones;
signal t_mpet_info_bus: tp_peticion_info;
signal t_mpet_cntl_bus: tp_peticion_control;

signal t_t_mpet_cntl_bus: tp_bus_control;
signal t_t_mpet_info_bus: tp_bus_info;

signal t_mresp_cntl_bus: tp_respuesta_control;
signal t_mresp_info_bus: tp_respuesta_info;

signal t_final_trans: std_logic_vector(Nproc-1 downto 0);
signal fin_trans: std_logic;

begin

proc_multi: for i in 0 to Nproc-1 generate
-- cache con interfaces procesador y red
cache: cache_multi_con_interface_bus port map (reloj => reloj, pcero => pcero, 
										arb_peticion => arb_peticiones(i), arb_concesion => arb_concesiones(i), 
										pet_proc => pet_proc(i), pet_listo => pet_listo(i), 
										obs_bus => obs_bus_c(i),
										resp_cache => resp_cache(i), 
										mresp_cntl_bus => mresp_cntl_bus_c(i), mpet_cntl_bus => mpet_cntl_bus_c(i),
										mresp_info_bus => mresp_info_bus_c(i), mpet_info_bus => mpet_info_bus_c(i),
										identificador => i);
end generate;

-- senyal or de final_trans, utilizada por el gestor de la red
t_final_trans(0) <=  mresp_cntl_bus_c(0).m_val;
or_fin_trans: for i in 1  to Nproc-1 generate
begin
	t_final_trans(i) <= mresp_cntl_bus_c(i).m_val or t_final_trans(i-1);
end generate;
-- salida senyal fin_trans
fin_trans <= t_final_trans(Nproc-1);

-- interconexiones: RED
red: ensamblado_red port map (reloj => reloj, pcero => pcero, arb_control => arb_control, arb_peticiones => arb_peticiones, arb_concesiones => arb_concesiones, 
						fin_trans => fin_trans,
						mpet_info_bus_c => mpet_info_bus_c, mpet_cntl_bus_c => mpet_cntl_bus_c, 
						mpet_info_bus => mpet_info_bus, mpet_cntl_bus => mpet_cntl_bus);

-- memoria con interface al bus
memoria: mem_con_interface_bus port map (reloj => reloj, pcero => pcero, 
										mpet_info_bus => mpet_info_bus, mresp_info_bus => mresp_info_bus_c, 
										obs_s => obs_bus_c,
										mpet_cntl_bus => mpet_cntl_bus, mresp_cntl_bus => mresp_cntl_bus_c);

end;

