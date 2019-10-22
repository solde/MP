--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;
use work.param_disenyo_pkg.all;
use work.retardos_componentes_pkg.all;
use work.estado_pkg.all;
use work.proc_func_control_pkg.all;

entity control is
port (reloj, pcero: in std_logic;
	op_dis: in std_logic;
	consumo: in std_logic;
	igualcero, menor: in std_logic;
	ini, pe_a, pe_b: out std_logic;
	finalizada, desocupada: out std_logic);
end;
  
architecture funcional of control is

signal estado, prxestado: tipoestado;
begin

-- registro de estado
reg_estado: process (reloj, pcero)
variable v_estado: tipoestado;
begin
	if pcero = puesta_cero then
		v_estado := ESP;
	elsif rising_edge(reloj) then
		v_estado := prxestado;										
	end if;
	estado <= v_estado after retardo_estado;
end process;    
   
-- logica de proximo estado
prx_esta: process(estado, op_dis, igualcero, consumo, menor, pcero)
variable v_prxestado: tipoestado;
begin

	if estado = ESP and op_dis = '1' then v_prxestado := CALC;
	elsif estado = CALC and igualcero = '1' then v_prxestado := HECHO;
	elsif estado = HECHO and consumo = '1' then v_prxestado := ESP;
	else v_prxestado := estado; 
	end if;


	prxestado <= v_prxestado after retardo_logica_estado;
end process;

-- logica de control y salida
logi_sal: process(estado, op_dis, igualcero, consumo, menor, pcero)
variable v_ini, v_pe_a, v_pe_b: std_logic;
variable v_finalizada, v_desocupada: std_logic;
begin
	
	if estado = ESP and op_dis = '0' then v_desocupada := '1'; else v_desocupada := '0'; end if;
	if estado = ESP and op_dis = '1' then v_ini := '1'; else v_ini := '0'; end if;
	if estado = CALC and igualcero ='1' then v_finalizada := '1'; else v_finalizada := '0'; end if;
	if igualcero='0' then v_pe_a := '1'; v_pe_b := '1'; else v_pe_a := '0'; v_pe_b := '0';end if;
	
ini <= v_ini after retardo_logica_salida;
pe_a <= v_pe_a after retardo_logica_salida;
pe_b <= v_pe_b after retardo_logica_salida;
finalizada <= v_finalizada after retardo_logica_salida;
desocupada <= v_desocupada after retardo_logica_salida;

end process;

end;
