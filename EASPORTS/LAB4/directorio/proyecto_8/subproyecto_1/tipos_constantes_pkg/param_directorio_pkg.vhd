--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;

use work.param_disenyo_pkg.all;
use work.multis_pkg.all;

package param_directorio_pkg is

subtype st_elem_dir is std_logic_vector(Nproc-1 downto 0);

-- directorio
type dir_mem is array(0 to tam_ELogico - 1) of st_elem_dir; 

end package param_directorio_pkg;

