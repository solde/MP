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
		s_control: out tp_contro_cam_cntl;
		resp: out tp_contro_s;
		resp_m: in tp_cntl_memoria_e;
		pet_m: out tp_cntl_memoria_s);
end;
  
architecture compor of controlador is

--type tipoestado is (DES0, DES, CMPETIQ, INI, ESCINI, LEC, PML, PMEA, PMEF, ESPL, ESPEA, ESPEF, ESB, ESCP, HECHOL, HECHOE);
signal estado, prxestado: tipoestado;

signal derechos_acceso: std_logic;
      
begin
-- determinacion de los derechos de acceso al bloque
derechos_acceso <= '1' when (s_estado.AF and s_estado.EST) = '1' else '0';

-- Update registre estat
reg_estado: process (reloj, pcero)
variable v_estado: tipoestado;
begin
	if pcero = puesta_cero then
		v_estado := DES0;
	elsif rising_edge(reloj) then
		v_estado := prxestado;										
	end if;
	estado <= v_estado after retardo_estado;
end process;

-- Proximo estado
prox_estado: process (estado, pcero, pet, derechos_acceso, resp_m)
variable v_prxestado: tipoestado;
begin
v_prxestado := estado; 
	if (pcero = not puesta_cero) then
		case estado is
			when DES0 => -- Disponible (Inicial)
				if hay_peticion_ini_procesador(pet) then
					v_prxestado := INI;
				elsif hay_peticion_procesador(pet) then
					v_prxestado := CMPETIQ;
				end if;
			when INI => -- Ini
				v_prxestado := ESCINI;
			when ESCINI | ESCP => 
				v_prxestado := DES;
			when DES => -- Disponible
				if hay_peticion_procesador(pet) then
					v_prxestado := CMPETIQ;
				end if;
			when CMPETIQ => -- Comparacio etiquetes
				if es_acierto_lectura(pet, derechos_acceso) then
					v_prxestado := DES;
				elsif es_fallo_lectura(pet, derechos_acceso) then
					v_prxestado := ESPL;
				elsif es_acierto_escritura(pet, derechos_acceso) then
					v_prxestado := ESPEA;
				elsif es_fallo_escritura(pet, derechos_acceso) then
					v_prxestado := ESPEF;
				end if;
			when LEC => -- Lectura
				v_prxestado := DES;
			when ESPL => -- Espera lectura mem
				if hay_respuesta_memoria(resp_m) then
					v_prxestado := ESB;
				end if;
			when ESB => -- Escriptura a cache fallada lec
				v_prxestado := LEC;
			when ESPEF =>
				if hay_respuesta_memoria(resp_m) then
					v_prxestado := DES;
				end if;
			when ESPEA => 
				if hay_respuesta_memoria(resp_m) then
					v_prxestado := ESCP;
				end if;
			when others =>
					v_prxestado := DES0;
		end case;
	else
		v_prxestado := DES0;
	end if;
prxestado <= v_prxestado after retardo_logica_prx_estado;
end process;

-- Salidas de los estados
salida_estados: process (estado, pcero,pet,derechos_acceso,resp_m)
variable v_s_control: tp_contro_cam_cntl;
variable v_pet_m: tp_cntl_memoria_s;
variable v_resp: tp_contro_s;
begin
   -- Ponemos los valores por defecto
	por_defecto(v_s_control, v_pet_m,v_resp);
	if(pcero = not puesta_cero) then
		case estado is
			when INI =>
				interfaces_en_CURSO(v_resp);
				actualizar_etiqueta(v_s_control);
				actualizar_dato(v_s_control);
				actualizar_estado(v_s_control, contenedor_valido);
			when ESCINI =>
				interfaces_en_CURSO(v_resp);
			when DES | DES0 => 
				interfaces_DES(v_resp);
				lectura_etiq_estado(v_s_control);
				lectura_datos(v_s_control);
			when CMPETIQ => 
				
				if es_acierto_lectura(pet, derechos_acceso) then
					interfaces_HECHOL(v_resp);
				elsif es_fallo_lectura(pet, derechos_acceso) then
					interfaces_en_CURSO(v_resp);
					peticion_memoria_lectura(v_pet_m);
				elsif es_acierto_escritura(pet, derechos_acceso) then
					interfaces_en_CURSO(v_resp);
					peticion_memoria_escritura(v_pet_m);
				elsif es_fallo_escritura(pet, derechos_acceso) then
					interfaces_en_CURSO(v_resp);
					peticion_memoria_escritura(v_pet_m);
				end if;
			when ESB => -- Escribir bloque mem en cache
				interfaces_en_CURSO(v_resp);
				lectura_datos(v_s_control);
			when LEC => 
				interfaces_HECHOL(v_resp);
			when ESPL => 
				if hay_respuesta_memoria(resp_m) then
					actualizar_estado(v_s_control,contenedor_valido);
					actualizar_etiqueta(v_s_control);
					actu_datos_desde_bus(v_s_control);
					actualizar_dato(v_s_control);
				end if;
				interfaces_en_CURSO(v_resp);
			when  ESPEA => -- Esperas de escitura HIT
				if hay_respuesta_memoria(resp_m) then
					actualizar_dato(v_s_control);
				end if;
				interfaces_en_CURSO(v_resp);
			when ESPEF => -- Esperas escritura miss
				if hay_respuesta_memoria(resp_m) then
					interfaces_HECHOE(v_resp);
				else
					interfaces_en_CURSO(v_resp);
				end if;
			when ESCP => -- Escritura HIT a cache
				interfaces_HECHOE(v_resp);
			when others =>
			 -- No fem res
		end case;
	end if;
	
	-- Establecemos señales a partir de variables
	s_control <= v_s_control after retardo_logica_salida;
	pet_m <= v_pet_m after retardo_logica_salida;
	resp <= v_resp after retardo_logica_salida;
end process;

	
end;
