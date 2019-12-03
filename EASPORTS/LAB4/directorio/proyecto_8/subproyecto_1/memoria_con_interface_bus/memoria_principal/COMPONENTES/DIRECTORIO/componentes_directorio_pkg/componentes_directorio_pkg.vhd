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

package componentes_directorio_pkg is

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

component lec_mod_esc is
	port (LD_dir: in st_elem_dir;
		deco: in std_logic_vector(Nproc-1 downto 0);
		les: in std_logic;
		ED_dir: out st_elem_dir);
end component;

component acceso_dir is
	port (reloj: in  std_logic;
		dir: in  st_dir;
		MPET: in  std_logic;
		s_dir: out st_dir;
		s_pet: out std_logic);
end component;

component directorio_mem is
	port (reloj	: in  std_logic;
		MPET: in std_logic;
		ED	: in  st_elem_dir;
		dir	: in  st_dir;
		pe	: in  std_logic;
		LD	: out st_elem_dir);
end component;

end package componentes_directorio_pkg;
