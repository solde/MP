--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;

use work.interface_cache_bus_pkg.all;

use work.interface_observador_pkg.all;
use work.bus_multi_pkg.all;

package componentes_interfaces_bus_pkg is

-- registros utilizados en las intefaces 
-- control
component RC_resp is			
  port (reloj, pcero: in std_logic;	
         e: in tp_respuesta_control;
         s: out tp_respuesta_control);
end component;

component RC_pet is						
  port (reloj, pcero: in std_logic;	
         e: in tp_peticion_control;
         s: out tp_peticion_control);
end component;

-- informacion
component RD_pet_info is	
  port (reloj, pcero: in std_logic;	
         e: in tp_peticion_info;
         s: out tp_peticion_info);
end component;

component RD_resp_info is		
  port (reloj, pcero: in std_logic;
         e: in tp_respuesta_info;
         s: out tp_respuesta_info);
end component;

-- interfaces memoria-bus: informacion y control
component interface_mem_bus_control is 
	port (reloj, pcero	: in  std_logic;
		mpet_cntl_bus: in  tp_peticion_control;
		mpet_cntl_s: out  tp_peticion_control;
		obs_e: in tp_bus_observacion;
		obs_s: out tp_bus_observacion;
		mresp_cntl_e: in tp_bus_control_resp;
		mresp_cntl_bus: out tp_bus_control_resp); 
end component;

component interface_mem_bus_info is
	port (reloj, pcero	: in  std_logic;
		mpet_info_bus: in  tp_peticion_info;
		mpet_info_s: out  tp_peticion_info;
		mresp_info_e: in tp_bus_info_resp;
		mresp_info_bus: out tp_bus_info_resp); 
end component;

end package componentes_interfaces_bus_pkg;
