--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.multis_pkg.all;
use work.param_directorio_pkg.all;
--! @image html modificacion_A.png 

entity lec_mod_esc is
	port (LD_dir: in st_elem_dir;
		deco: in st_elem_dir; 
		les: in std_logic;
		ED_dir: out st_elem_dir);
end lec_mod_esc;

architecture compor of lec_mod_esc is
signal mod_lec_dir, mod_esc_dir: st_elem_dir;
begin


end;

