--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;

use work.param_disenyo_pkg.all;
use work.componentes_memoria_pkg.all;
use work.multis_pkg.all;
use work.interface_observador_pkg.all;
use work.interface_cache_bus_pkg.all;
--! @image html memo_contro_iden.png 

entity ensamblado_memoria is
	port (reloj: in  std_logic;
		ED: in  st_elem_dat;
		dir: in  st_dir;
		MPET, MLES: in  std_logic;
		iden : in iden_proc;
		obs_s: out  tp_observacion;
		respt_cnt_mem: out tp_respuesta_control;
		LD: out st_elem_dat);
end ensamblado_memoria;

architecture estruc of ensamblado_memoria is
signal PEM: std_logic;
signal reg_MPET: std_logic;

signal obs_bus, t_obs_bus: tp_observacion;

begin

-- conexion de observacion (controlador memoria)
obs_bus.dir <= dir; 
obs_bus.pet <= MPET; 
obs_bus.les <= MLES; 
obs_bus.iden <= iden;  

-- registro asociado al controlador de memoria
reg_cntl_mem: RD_obser_cntl_mem port map(reloj => reloj, e => obs_bus, s => t_obs_bus); 

--controlador de memoria
cnt_mem: controlador_memo port map(obs_e => t_obs_bus, obs_s => obs_s, respt_cnt_mem => respt_cnt_mem); 

--memoria
mem: memoria_mem port map (reloj => reloj, MPET => MPET, ED => ED, dir => dir, pe => MLES, LD => LD);

end;


