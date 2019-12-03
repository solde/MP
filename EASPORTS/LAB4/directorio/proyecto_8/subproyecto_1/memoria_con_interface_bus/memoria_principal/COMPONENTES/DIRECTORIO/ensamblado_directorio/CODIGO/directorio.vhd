--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;

use work.param_disenyo_pkg.all;
use work.multis_pkg.all;
use work.param_directorio_pkg.all;
use work.componentes_directorio_pkg.all;
--! @image html ensam_directorio_A.png 

entity directorio is
	port (reloj: in  std_logic;
		dir: in  st_dir;
		MPET: in  std_logic;
		pe_dir : in std_logic;
		les: in  std_logic;
		iden_deco: in std_logic_vector(Nproc-1 downto 0));
end directorio;

architecture estruc of directorio is
signal ED_dir, t_LD_dir, LD_dir: st_elem_dir;
signal s_MPET: std_logic;
signal s_dir: st_dir;
begin

-- acceso al directorio
acc_dir: acceso_dir port map (reloj => reloj, dir => dir, MPET => MPET, s_dir => s_dir, s_pet => s_MPET);

-- directorio
dir_mem: directorio_mem port map (reloj => reloj, MPET => s_MPET, ED => ED_dir, dir => s_dir, pe => pe_dir, LD => t_LD_dir);

-- lectura
lec_dir: for i in 0 to Nproc-1 generate
LD_dir(i) <= '1' when (t_LD_dir(i) = '1') else '0'; 
end generate;

--modificacion_escritura
mod_dir: lec_mod_esc port map (LD_dir => LD_dir, deco => iden_deco, les => les, ED_dir => ED_dir);

end;


