--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.param_disenyo_pkg.all;
use work.retardos_memorias_pkg.all;

use work.interface_observador_pkg.all;
use work.interface_cache_bus_pkg.all;
use work.multis_pkg.all;
use work.bus_multi_pkg.all;
use work.param_directorio_pkg.all;
--! @image html contro_memo_resp_dir_A_2.png 

entity controlador_memo is
	port (obs_e: in  tp_observacion;
		LD_direc: in st_elem_dir;
		iden_deco: out std_logic_vector(Nproc-1 downto 0);
		hay_pet: out st_bloque_dat;
		obs_s: out  tp_bus_observacion;
		respt_cnt_mem: out tp_bus_control_resp;
		les, pe_dir: out std_logic);
end controlador_memo;

architecture compor of controlador_memo is
signal uno, deco: std_logic_vector(Nproc-1 downto 0);
signal despla: integer range 0 to 2*(Nproc) -1;
signal t_obs_s: tp_bus_observacion;

signal t_LD_direc: st_elem_dir;

begin
uno <= (Nproc-1 downto 1 => '0', 0 => '1');
despla <= to_integer(unsigned(obs_e.iden));
deco <= std_logic_vector(shift_left(unsigned(uno), despla));

hay_pet <= (hay_pet'range => obs_e.pet);

-- observacion y respuesta control


end;

