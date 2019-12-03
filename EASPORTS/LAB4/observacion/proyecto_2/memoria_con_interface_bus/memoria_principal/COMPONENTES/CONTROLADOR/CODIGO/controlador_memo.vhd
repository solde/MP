--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;

use work.param_disenyo_pkg.all;
use work.retardos_memorias_pkg.all;

use work.interface_observador_pkg.all;
use work.interface_cache_bus_pkg.all;

entity controlador_memo is
	port (obs_e: in  tp_observacion;
		obs_s: out  tp_observacion;
		respt_cnt_mem: out tp_respuesta_control);
end controlador_memo;

architecture compor of controlador_memo is
begin

obs_s <= obs_e after retcnt_mem;
respt_cnt_mem.m_val <= obs_e.pet after retcnt_mem;
respt_cnt_mem.iden <= obs_e.iden after retcnt_mem;

end;

