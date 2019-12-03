--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.param_disenyo_pkg.all;
use work.controlador_Obs_pkg.all;
use work.controlador_pkg.all;
use work.retardos_controlador_pkg.all;
use work.acciones_pkg.all;
use work.procedimientos_observador_pkg.all;
--! @image html observador_iden.png 

entity observador is
port (reloj, pcero: in std_logic;
		pet: in tp_contro_Obs_e;
		s_estado: in tp_contro_cam_estado;
		observacion: out std_logic;
		s_control: out tp_contro_cam_cntl;
		resp: out tp_contro_Obs_s;
		identificador: in natural);
end;
  
architecture compor of observador is

--type tipoestado_O is (DESO, CMPETO, EEST);
signal estado, prxestado: tipoestado_O;

signal derechos_acceso: std_logic;

signal propia: std_logic;

begin
-- identificacion del CC
propia <= '1' when pet.iden = std_logic_vector(to_unsigned(identificador, pet.iden'length)) else '0';

-- determinacion de los derechos de acceso al bloque
derechos_acceso <= '1' when (s_estado.AF and s_estado.EST) = '1' else '0';

-- registro de estado
reg_estado: process (reloj, pcero)
variable v_estado: tipoestado_O;
begin
	if pcero = '1' then
		v_estado := DESO;
	elsif rising_edge(reloj) then
		v_estado := prxestado;										
	end if;
-- asignacion de la variable a la señal, indicando el retardo
	estado <= v_estado after retardo_estado;
end process;    
   
-- logica de proximo estado


   
-- logica de salida


	
end;
