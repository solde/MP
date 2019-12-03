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
use work.bus_multi_pkg.all;
use work.param_directorio_pkg.all;
--! @image html memo_contro_iden_resp_dir_A_2.png 

entity ensamblado_memoria is
	port (reloj: in  std_logic;
		ED: in  st_elem_dat;
		dir: in  st_dir;
		MPET, MLES: in  std_logic;
		iden : in iden_proc;
		obs_s: out  tp_bus_observacion;
		respt_cnt_mem: out tp_bus_control_resp;
		mresp_LD: out tp_bus_info_resp);
end ensamblado_memoria;

architecture estruc of ensamblado_memoria is
signal PEM: std_logic;
signal reg_MPET: std_logic;

signal obs_bus, t_obs_bus: tp_observacion;
signal iden_deco: std_logic_vector(Nproc-1 downto 0);
signal mresp_cntl_e: tp_bus_control_resp;
signal LD: st_elem_dat;
signal hay_pet: st_bloque_dat;

signal ED_dir, t_LD_dir, LD_dir, DE_dir: st_elem_dir;
signal les, pe_dir: std_logic;
signal LD_direc: st_elem_dir;
begin



end;


