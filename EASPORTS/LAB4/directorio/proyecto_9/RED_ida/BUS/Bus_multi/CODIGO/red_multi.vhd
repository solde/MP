--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library IEEE;
use IEEE.std_logic_1164.all; 

use work.multis_pkg.all;
use work.interface_cache_bus_pkg.all;
use work.bus_multi_pkg.all;
use work.componentes_interfaces_bus_multi_pkg.all;
use work.retardos_bus_pkg.all;
--! @image html bus_multi.png 

entity red_multi is
port (arb_concesiones: in st_arb_concesiones;
	e_info: in tp_bus_info;
	e_cntl: in tp_bus_control;
	s_info: out tp_peticion_info;
	s_cntl: out tp_peticion_control);
end red_multi;

architecture comportamiento of red_multi is

signal t_bus_info, t_t_bus_info: tp_bus_info;
signal t_bus_control, t_t_bus_control: tp_bus_control;
begin

-- operacion "and" individual de las senyales y "or" de las senyales de informacion
and_conc_info: and_pet_info port map (conc => arb_concesiones(0), en => e_info(0), sal => t_bus_info(0));

or_bus_info: for i in 1  to Nproc-1 generate
begin
and_conc_inf_i: and_pet_info port map (conc => arb_concesiones(i), en => e_info(i), sal => t_t_bus_info(i));
	t_bus_info(i).acc <= t_t_bus_info(i).acc  or t_bus_info(i-1).acc after ret_bus;
	t_bus_info(i).dir <= t_t_bus_info(i).dir or t_bus_info(i-1).dir after ret_bus;
	t_bus_info(i).dato_E <= t_t_bus_info(i).dato_E or t_bus_info(i-1).dato_E after ret_bus;
end generate;
-- salida senyales de informacion
s_info <= t_bus_info(Nproc-1);

-- operacion "and" individual de las senyales y "or" de las senyales de control
and_conc_cntl: and_pet_control port map (conc => arb_concesiones(0), en => e_cntl(0), sal => t_bus_control(0)); 
or_bus_cntl: for i in 1  to Nproc-1 generate
begin
and_conc_cnt_i: and_pet_control port map (conc => arb_concesiones(i), en => e_cntl(i), sal => t_t_bus_control(i));
	t_bus_control(i).mpet <= t_t_bus_control(i).mpet or t_bus_control(i-1).mpet after ret_bus;
	t_bus_control(i).mles <= t_t_bus_control(i).mles or t_bus_control(i-1).mles after ret_bus;
	t_bus_control(i).mexp <= t_t_bus_control(i).mexp or t_bus_control(i-1).mexp after ret_bus;
	t_bus_control(i).iden <= t_t_bus_control(i).iden or t_bus_control(i-1).iden after ret_bus;
end generate;
-- salida senyales de control
s_cntl <= t_bus_control(Nproc-1);

end;
