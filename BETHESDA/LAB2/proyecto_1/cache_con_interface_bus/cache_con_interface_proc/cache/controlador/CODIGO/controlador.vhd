--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;

use work.param_disenyo_pkg.all;
use work.controlador_pkg.all;
use work.retardos_controlador_pkg.all;
use work.acciones_pkg.all;
use work.procedimientos_controlador_pkg.all;
--! @image html controlador.png 

entity controlador is
port (reloj, pcero: in std_logic;
		pet: in tp_contro_e;
		s_estado: in tp_contro_cam_estado;
		s_control: out tp_contro_cam_cntl;--
		resp: out tp_contro_s;--
		resp_m: in tp_cntl_memoria_e;
		pet_m: out tp_cntl_memoria_s);--
end;
  
architecture compor of controlador is

--type tipoestado is (DES0, DES, CMPETIQ, INI, ESCINI, LEC, PML, PMEA, PMEF, ESPL, ESPEA, ESPEF, ESB, ESCP, HECHOL, HECHOE);
signal estado, prxestado: tipoestado;

signal derechos_acceso: std_logic;
      
begin
-- determinacion de los derechos de acceso al bloque
derechos_acceso <= '1' when (s_estado.AF and s_estado.EST) = '1' else '0';

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
--


-- logica de proximo estado
prx_esta: process(estado, op_dis, igualcero, consumo, pcero)
variable v_prxestado: tipoestado;
begin
	v_prxestado := estado; 
	if (pcero = not puesta_cero) then
		case estado is
			when DES0 =>
				if hay_peticion_ini_procesador(pet) then v_prxestado := INI;
				else if hay_peticion_procesador(pet) then v_prxestado := CMPETIQ;
				end if;
			when DES =>
				if(hay_peticion_procesador(pet)) then  v_prxestado := CMPETIQ;
				else v_prxestado := DES; 
				end if;
			when INI =>
				v_prxestado := ESCINI;
			when ESCINI => 
				v_prxestado := HECHOE;
			when CMPETIQ =>
				if es_acierto_lectura (pet, derechos_acceso) then v_prxestado := LEC;
				end if;
			when LEC =>
				v_prxestado := HECHOL;
			when HECHOE | HECHOL =>
				v_prxestado := DES;
			when others =>
				v_prxestado := DES0;
	--
		end case;
	else
       v_prxestado := DES0;
	end if; 
	prxestado <= v_prxestado after retardo_logica_estado;
end process;
--


-- logica de control y salida
logi_sal: process(estado, op_dis, igualcero, consumo, pcero)
variable v_mxa, v_pe: std_logic;
variable v_finalizada, v_desocupada: std_logic;
begin
	defecto(v_mxa, v_pe, v_finalizada, v_desocupada);
	if (pcero = not puesta_cero) then
		case estado is
			when CMPETIQ => 
				lectura_etiq_estado(v_s_control);
			when ESCINI =>
				actualizar_etiqueta ( v_s_control);
				actualizar_estado ( v_s_control, estado_conte);
				actualizar_dato ( v_s_control);
				
		end case;
	end if; 

mxa <= v_mxa after retardo_logica_salida;
pe <= v_pe after retardo_logica_salida;
finalizada <= v_finalizada after retardo_logica_salida;
desocupada <= v_desocupada after retardo_logica_salida;

end process;
 
 
end;
