--
-- Copyright (c) 2017 XXXX, UPC
-- All rights reserved.
-- 

library IEEE;
use IEEE.std_logic_1164.all;
--! @image html arbitraje.png 

entity RD_1 is							-- registro con inicializacion a cero asincrona
  port (reloj, pcero: in std_logic;		-- pes: senyal de inicializacion
         e: in std_logic;
         s: out std_logic);
end;

architecture comportamiento of RD_1 is
  begin
     process (reloj, pcero) begin
       if pcero = '1' then s <= '0';
       elsif rising_edge(reloj) then
              s <= e;
       end if;
     end process;
end;

library IEEE;
use IEEE.std_logic_1164.all;

use work.multis_pkg.all;

entity modulo is						
port (reloj, pini, u,c: in  std_logic;
		sal: out std_logic);
end modulo;
architecture estruc of modulo is
component RD_1 is							-- registro con inicializacion a cero asincrona
  port (reloj, pcero: in std_logic;		-- pes: senyal de inicializacion
         e: in std_logic;
         s: out std_logic);
end component;
signal salida, entreg: std_logic;
begin
entreg <= (not c) and (u or salida);
sal <= salida;
regmodulo: RD_1 port map (reloj => reloj, pcero => pini, e => entreg, s => salida);
end;

library IEEE;
use IEEE.std_logic_1164.all;

use work.multis_pkg.all;
use work.retardos_arbitro_pkg.all;

entity arbitraje is						
port (reloj, pcero: in std_logic;
	arb: st_arb_peticiones;	
	peticiones: in st_arb_peticiones;
	concesiones: out st_arb_concesiones);
end arbitraje;

architecture estruc of arbitraje is
component modulo is						
port (reloj, pini, u,c: in  std_logic;
		sal: out std_logic);
end component;

type t_mat_ors is array (0 to Nproc-1) of std_logic_vector(0 to Nproc -2);
type t_mat is array (0 to Nproc-1) of std_logic_vector(0 to Nproc -1);

signal ors_data: t_mat :=(others => (others=> '0'));
signal tempsalidas: std_logic_vector(0 to Nproc-1);
signal ors: t_mat_ors;
begin

mods_outer: for i in 0 to Nproc-1 generate
	signal tmpor: std_logic_vector(0 to Nproc-1);
	begin
	-- Modulos
	mods_salidas: for j in i+1 to Nproc-1 generate
	signal tmp: std_logic;
	begin
		mymod: modulo port map(reloj => reloj, pini => pcero, u => tempsalidas(i),c =>tempsalidas(j),sal=>tmp);
		ors_data(i)(j) <= tmp and peticiones(j);
		ors_data(j)(i) <= (not tmp) and peticiones(j);
	end generate;
	
	-- puertas or
	tmpor(0) <= ors_data(i)(0);
   or_gen: for k in 1 to Nproc-1 generate
       tmpor(k) <= tmpor(k-1) or ors_data(i)(k);
   end generate; 
	
	
	tempsalidas(i) <= peticiones(i) and not tmpor(Nproc-1);
	concesiones(i) <= tempsalidas(i)after ret_arb;
end generate;

--g_arb: for i in 0 to Nproc-1 generate
--begin
--end generate;

end;
