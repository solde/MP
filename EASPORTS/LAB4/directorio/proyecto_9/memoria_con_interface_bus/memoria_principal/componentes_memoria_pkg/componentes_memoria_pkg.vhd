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
use work.param_directorio_pkg.all;

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

component RD_direc is							
  port (reloj: in std_logic;		
         e: in st_dir;
         s: out st_dir);
end component;

component memoria_mem is
	port (reloj	: in  std_logic;
		MPET: in std_logic;
		ED		: in  st_elem_dat;
		dir	: in  st_dir;
		pe		: in  std_logic;
		LD		: out st_elem_dat);
end component;

component directorio is
	port (reloj: in  std_logic;
		dir: in  st_dir;
		MPET: in  std_logic;
		pe_dir : in std_logic;
		les, mexp: in  std_logic;
		LD_direc: out st_elem_dir;
		iden_deco: in std_logic_vector(Nproc-1 downto 0));
end component;

component controlador_memo is
	port (obs_e: in  tp_observacion;
		LD_direc: in st_elem_dir;
		MEXP_e: in std_logic;
		MEXP_s: out std_logic;
		iden_deco: out std_logic_vector(Nproc-1 downto 0);
		hay_pet: out st_bloque_dat;
		obs_s: out  tp_bus_observacion;
		respt_cnt_mem: out tp_bus_control_resp;
		les, pe_dir: out std_logic);
end component;

component ensamblado_memoria is
	port (reloj: in  std_logic;
		ED: in  st_elem_dat;
		dir: in  st_dir;
		MPET, MLES, MEXP: in  std_logic;
		iden : in iden_proc;
		obs_s: out  tp_bus_observacion;
		respt_cnt_mem: out tp_bus_control_resp;
		mresp_LD: out tp_bus_info_resp);
end component;

end package componentes_memoria_pkg;
