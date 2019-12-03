--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.interface_cache_bus_pkg.all;
use work.componentes_interfaces_bus_pkg.all;

use work.interface_observador_pkg.all;
use work.componentes_interfaces_bus_multi_pkg.all;

use work.multis_pkg.all;
use work.bus_multi_pkg.all;
--! @image html interface_mem_red_control.png 

entity interface_mem_bus_control is
	port (reloj, pcero	: in  std_logic;
		mpet_cntl_bus: in  tp_peticion_control;
		mpet_cntl_s: out  tp_peticion_control;
		obs_e: in tp_bus_observacion;
		obs_s: out tp_bus_observacion;
		mresp_cntl_e: in tp_bus_control_resp;
		mresp_cntl_bus: out tp_bus_control_resp); 
end interface_mem_bus_control;

architecture estruc of interface_mem_bus_control is

begin
-- interface de peticion: control
reg_mpet_cntl: RC_pet port map(reloj => reloj, pcero => pcero, e => mpet_cntl_bus, s => mpet_cntl_s);

-- interface obs
red_obser: for i in 0 to Nproc-1 generate
	reg_mresp_obser: RD_observacion port map(reloj => reloj, pcero => pcero, e => obs_e(i), s => obs_s(i));
end generate;

-- interface de respuesta: control
red_vuel: for i in 0 to Nproc-1 generate
	reg_mresp_cntl: RC_resp port map(reloj => reloj, pcero => pcero, e => mresp_cntl_e(i), s => mresp_cntl_bus(i));
end generate;

end;

