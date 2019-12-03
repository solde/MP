--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;

use work.param_disenyo_pkg.all;
use work.componentes_memoria_pkg.all;
--! @image html acceso_A.png 

entity acceso_dir is
	port (reloj: in  std_logic;
		dir: in  st_dir;
		MPET: in  std_logic;
		s_dir: out st_dir;
		s_pet: out std_logic);
end acceso_dir;

architecture estruc of acceso_dir is
signal reg_dir: st_dir;
signal reg_MPET: std_logic;

begin



end;


