--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;

use work.param_disenyo_pkg.all;
use work.controlador_Obs_pkg.all;
use work.controlador_pkg.all;
use work.retardos_controlador_pkg.all;
use work.acciones_pkg.all;
use work.procedimientos_observador_pkg.all;
--! @image html observador.png 

entity observador is
port (reloj, pcero: in std_logic;
		pet: in tp_contro_Obs_e;
		s_estado: in tp_contro_cam_estado;
		observacion: out std_logic;
		s_control: out tp_contro_cam_cntl;
		resp: out tp_contro_Obs_s);
end;
  
architecture compor of observador is

--type tipoestado_O is (DESO, CMPETO, EEST);
signal estado, prxestado: tipoestado_O;

signal derechos_acceso: std_logic;

begin
-- determinacion de los derechos de acceso al bloque
derechos_acceso <= '1' when (s_estado.AF and s_estado.EST) = '1' else '0';

-- registro de estado
reg_estado: process (reloj, pcero)
variable v_estado: tipoestado_O;
begin
	if pcero = puesta_cero then
		v_estado := DESO;
	elsif rising_edge(reloj) then
		v_estado := prxestado;										
	end if;
	estado <= v_estado after retardo_estado;
end process;    
   
-- logica de proximo estado
prx_esta: process(estado, pet, derechos_acceso, pcero)
variable v_prxestado: tipoestado_O;
begin
-- 
-- asignacion de variables a las señales, indicando el retardo, mismo retardo que el agente procesador
	v_prxestado := estado; 
	if (pcero = not puesta_cero) then
		case estado is
			when DESO => -- Estat inicial
				if hay_peticion_escritura_bus(pet) then
					v_prxestado := CMPETO;
				end if;
			when CMPETO =>
				if es_acierto(derechos_acceso) then
					v_prxestado := EEST;
				else
					v_prxestado:= DESO;
				end if;
			when EEST =>
				v_prxestado:= DESO;
			when others =>
				v_prxestado := DESO;
		end case;
	else
		v_prxestado := DESO;
	end if;
	prxestado <= v_prxestado after retardo_logica_prx_estado;
end process;
   
-- logica de salida
logi_sal: process(estado, pet, derechos_acceso, pcero)
variable v_s_control: tp_contro_cam_cntl;
variable v_resp: tp_contro_Obs_s;
variable v_observacion: std_logic;
begin
--
-- asignacion de variables a las señales, indicando el retardo, mismo retardo que el agente procesador
if(pcero = not puesta_cero) then
	por_defecto (v_s_control, v_resp, v_observacion);
	case estado is
		when DESO => 
			if hay_peticion_escritura_bus(pet) then
				observando(v_observacion);
				lectura_etiq_estado(v_s_control);
				interfaces_en_CURSO(v_resp);
			else
				interfaces_DES(v_resp);
			end if;
		when CMPETO =>
			interfaces_en_CURSO(v_resp);
			if es_acierto(derechos_acceso) then
				observando(v_observacion);
				actualizar_estado(v_s_control, contenedor_valido);
			end if;
		when EEST =>
			interfaces_en_CURSO(v_resp);
	end case;
end if;
s_control <= v_s_control after retardo_logica_salida;
resp <= v_resp after retardo_logica_salida;
observacion <= v_observacion after retardo_logica_salida;
end process;

	
end;
