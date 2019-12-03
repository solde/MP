--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 
library ieee;
use ieee.std_logic_1164.all;

use work.param_disenyo_pkg.all;
use work.multis_pkg.all;
use work.interface_observador_pkg.all;
use work.interface_cache_bus_pkg.all;
use work.bus_multi_pkg.all;

package componentes_memoria_pkg is

component RC_1 is						
	port (reloj: in std_logic;	
         e: in std_logic;
         s: out std_logic);
end component;

component RD_obser_cntl_mem is							
  port (reloj: in std_logic;		
         e: in tp_observacion;
         s: out tp_observacion);
end component;

component memoria_mem is
	port (reloj	: in  std_logic;
		MPET: in std_logic;
		ED		: in  st_elem_dat;
		dir	: in  st_dir;
		pe		: in  std_logic;
		LD		: out st_elem_dat);
end component;

component controlador_memo is
	port (obs_e: in  tp_observacion;
		iden_deco: out std_logic_vector(Nproc-1 downto 0);
		hay_pet: out st_bloque_dat;
		obs_s: out  tp_bus_observacion;
		respt_cnt_mem: out tp_bus_control_resp);
end component;

component ensamblado_memoria is
	port (reloj: in  std_logic;
		ED: in  st_elem_dat;
		dir: in  st_dir;
		MPET, MLES: in  std_logic;
		iden : in iden_proc;
		obs_s: out  tp_bus_observacion;
		respt_cnt_mem: out tp_bus_control_resp;
		mresp_LD: out tp_bus_info_resp);
end component;

end package componentes_memoria_pkg;
