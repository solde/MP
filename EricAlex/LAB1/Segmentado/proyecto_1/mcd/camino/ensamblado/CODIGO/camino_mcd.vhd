--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;		
use ieee.std_logic_1164.all;		
use ieee.numeric_std.all;
use work.param_disenyo_pkg.all;
use work.componentes_pkg.all;
--! @image html camino_1.png 

entity camino_mcd is
   port (reloj, pcero, pe_a, pe_b: std_logic;
	ini: std_logic;
	a, b: in st_dat;
	s: out st_dat;
	ig, meu: out std_logic);
end camino_mcd;

architecture estruc of camino_mcd is

signal resu_resta, sal_reg_a, sal_reg_b, sal_mxa, sal_mx_ini_a, sal_mx_ini_b: st_dat;
signal sal_menor: std_logic;
begin

-- mx_a
mx_a: mux2 port map(d0 => sal_reg_b, d1 => resu_resta, sel => sal_menor, s => sal_mxa);
-- Mx_ini
mx_ini_a: mux2 port map(d0 => sal_mxa, d1 =>a, sel => ini, s=>sal_mx_ini_a);
mx_ini_b: mux2 port map(d0 => sal_reg_a, d1 =>b, sel => ini, s=>sal_mx_ini_b);


-- Registros
reg_a: RD_N_pe port map(reloj => reloj, pcero => pcero, pe=>pe_a, e => sal_mx_ini_a, s=>sal_reg_a);
reg_b: RD_N_pe port map(reloj => reloj, pcero => pcero, pe=>pe_b, e => sal_mx_ini_b, s=>sal_reg_b);

-- Comparador a < b
menor: menqu port map (L1 => sal_reg_a, L2 => sal_reg_b, meu =>sal_menor);

-- Restador
resta: sumador port map (a => sal_reg_a, b => sal_reg_b, s => resu_resta);

-- Salidas
s <= sal_reg_a;
meu <= sal_menor;
ig_cero: igual_cero port map (L1 => sal_reg_b, ig => ig);

end estruc;
