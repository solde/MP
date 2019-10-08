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
	
	signal mx_a_res:	st_dat;
	signal mx_ini_a_res:	st_dat;
	signal mx_ini_b_res: st_dat;
	signal reg_a_res:	st_dat;
	signal reg_b_res:	st_dat;
	signal sub_res: st_dat;
	signal men_res : std_logic;

begin
	
	mx_a: mux2 port map (d0 => reg_b_res, d1 => sub_res, SEL => men_res, s=>mx_a_res);
	mx_ini_a: mux2 port map(d0 => mx_a_res, d1 => a, SEL => ini, s=>mx_ini_a_res);
	reg_a: RD_N_pe port map (reloj => reloj, pcero=> pcero, pe=>pe_a, e=>mx_ini_a_res, s=>reg_a_res );
	mx_ini_b: mux2 port map(d0 => reg_a_res, d1 => b, SEL => ini, s=>mx_ini_b_res);
	reg_b: RD_N_pe port map (reloj => reloj, pcero=> pcero, pe=>pe_b, e=>mx_ini_b_res, s=>reg_b_res );
	men: menqu port map (L1=> reg_a_res, L2 => reg_b_res, meu=> men_res);
	sub: sumador port map (a=>reg_a_res, b=>reg_b_res, s=>sub_res);
	cero: igual_cero port map (L1=>reg_b_res, ig=>ig);
	
	meu<=men_res;--a
	s<=reg_a_res;
	


end estruc;
