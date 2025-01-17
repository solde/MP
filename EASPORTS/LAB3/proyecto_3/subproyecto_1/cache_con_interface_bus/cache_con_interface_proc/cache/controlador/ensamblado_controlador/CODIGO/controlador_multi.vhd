--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;

use work.param_disenyo_pkg.all;
use work.controlador_Obs_pkg.all;
use work.controlador_pkg.all;
use work.componentes_controlador_cache_multi_pkg.all;
--! @image html control_desacoplar.png 

entity controlador_multi is
port (reloj, pcero: in std_logic;
		arb_peticion: out std_logic;
		arb_concesion: in std_logic;
		pet: in tp_contro_e;
		pet_bus: in tp_contro_Obs_e;
		s_estado: in tp_contro_cam_estado;
		s_control: out tp_contro_cam_cntl;
		mxO: out std_logic;
		resp: out tp_contro_s;
		resp_O: out tp_contro_Obs_s;
		resp_m: in tp_cntl_memoria_e;
		pet_m: out tp_cntl_memoria_s);
end;

architecture estruc of controlador_multi is
signal cntl: std_logic;
signal s_control_P, s_control_O: tp_contro_cam_cntl;
signal t_resp_O: tp_contro_Obs_s;

signal observacion:std_logic;

signal trans_bus: std_logic;
begin



contro_proc: controlador port map (reloj => reloj, pcero => pcero, arb_pet => arb_peticion, arb_conc => arb_concesion,
					 trans_bus => trans_bus, pet => pet, s_estado => s_estado, s_control => s_control_P,
					resp => resp, resp_m => resp_m, pet_m => pet_m);

contro_obser: observador port map (reloj => reloj, pcero => pcero, pet => pet_bus, s_estado => s_estado, trans_bus => trans_bus,
					observacion => observacion, s_control => s_control_O, resp => t_resp_O);

resp_O <= t_resp_O;
mxO <= observacion and (not trans_bus);

-- control muxC
cntl <= observacion and (not trans_bus);

-- muxC
--s_control <= s_control_P when cntl = '0' else s_control_O;
s_control.DAT_acc <= s_control_P.DAT_acc;
s_control.DAT_esc <= s_control_P.DAT_esc;
--Multiplexados
s_control.EST_acc <= s_control_P.EST_acc when cntl = '0' else s_control_O.EST_acc;
s_control.EST_esc <= s_control_P.EST_esc when cntl = '0' else s_control_O.EST_esc;
s_control.EST_DE  <= s_control_P.EST_DE  when cntl = '0' else s_control_O.EST_DE;
s_control.ET_acc  <= s_control_P.ET_acc  when cntl = '0' else s_control_O.ET_acc;
s_control.ET_esc  <= s_control_P.ET_esc  when cntl = '0' else s_control_O.ET_esc;
s_control.muxE    <= s_control_P.muxE    when cntl = '0' else s_control_O.muxE;
end;

