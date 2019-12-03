--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.param_disenyo_pkg.all;
use work.camino_dat_pkg.all;
use work.controlador_pkg.all;
use work.controlador_Obs_pkg.all;
use work.componentes_cache_multi_pkg.all;
use work.cache_pkg.all;
use work.interface_observador_pkg.all;
--! @image html cache_expul_9.png 

entity cache_multi is
port (reloj, pcero: in std_logic;
		arb_peticion: out std_logic;
		arb_concesion: in std_logic;
		peticion: in tp_peticion;
		pet_listo: out st_cache_listo;
		resp_O: out tp_contro_Obs_s;
		mdato: in st_elem_dat;
		obs_bus: in tp_observacion;
		respuesta: out tp_respuesta;
		resp_m: in tp_cntl_memoria_e;
		pet_m: out tp_cntl_memoria_s;
		dir_acceso_mem: out st_dir;
		identificador: in natural);
end;
  
architecture estruc of cache_multi is

signal cami_e : tp_camino_e;
signal cami_s : tp_camino_s;

signal pet: tp_contro_e;
signal s_estado: tp_contro_cam_estado;
signal s_control: tp_contro_cam_cntl;
signal resp: tp_contro_s;

signal mx_DAT: st_palabra_dat;
signal dir_cache: st_dir;
signal muxO: std_logic;
signal pet_bus: tp_contro_Obs_e;

signal dir_proc: st_dir;
signal dire_exp: st_dir;
signal t_pet_m: tp_cntl_memoria_s;

begin 
-- interconexión
cami_e <= (etiq_acc => s_control.ET_acc, 
			dirB => dir_cache,
			etiq_esc => s_control.ET_esc,
			est_acc => s_control.EST_acc,
			est_esc => s_control.EST_esc,
			est_DE => s_control.EST_DE,
			dat_acc => s_control.DAT_acc,
			dat_esc => s_control.DAT_esc,
			dat_DE => mx_DAT);

-- seleccion de la direccion entre pet. procesador u observacion
mux_O: mux_dir port map (a => peticion.dir, b => obs_bus.dir, sel => muxO, s => dir_cache);

-- desacoplar acceso a datos
dir_proc <= peticion.dir;

-- conexion con datos del bus: captura del bloque (muxE)
mx: mux_dat port map (a => peticion.DE, b => mdato, sel => s_control.muxE, s => mx_DAT); 
-- camino de datos: ET, EST, DAT
camino: camino_datos port map (reloj => reloj, cami_e => cami_e, dir_proc => dir_proc, cami_s => cami_s);

-- interconexión
s_estado <= (AF => cami_s.cam_AF,
			EST => cami_s.cam_EST);
pet <= (acc => peticion.acc, 
		esc => peticion.esc,
		ini => peticion.ini);

pet_bus <= (acc => obs_bus.pet, esc => obs_bus.les, iden => obs_bus.iden);
contro: controlador_multi port map(reloj => reloj, pcero => pcero, arb_peticion => arb_peticion,
							arb_concesion => arb_concesion, pet => pet, pet_bus => pet_bus, 
							s_estado => s_estado, s_control => s_control, mxO => muxO, resp => resp, resp_O => resp_O,
							resp_m => resp_m, pet_m => t_pet_m,
							identificador => identificador); 

pet_m <= t_pet_m;		
-- seleccion de la direccion de la peticion: pet. proc, bloque expulsado
dire_exp <= cami_s.cam_exp_ETIQ & peticion.dir(dir_bloque_bits-etiq_bits-1 downto dir_bloque_bits-etiq_bits-indice_bits);
mux_exp: mux_dir port map (a => peticion.dir, b => dire_exp, sel => t_pet_m.m_exp, s => dir_acceso_mem);

-- interconexión
respuesta <= (DL => cami_s.cam_DL,
			val => resp.finalizada);

pet_listo <= resp.listo;

end;


