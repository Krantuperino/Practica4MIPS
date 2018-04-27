----------------------------------------------------------------------
-- Fichero: MemProgPlantilla.vhd
-- Descripci�n: Plantilla para la memoria de programa para el MIPS
-- Fecha �ltima modificaci�n: 2018-04-06

-- Autores: Alberto S�nchez (2012-2018), �ngel de Castro (2010-2015) 
-- Asignatura: EC 1� grado
-- Grupo de Pr�cticas:
-- Grupo de Teor�a:
-- Pr�ctica: 4
-- Ejercicio: 3
----------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity MemProgPlantilla is
	port (
		MemProgAddr : in std_logic_vector(31 downto 0); -- Direcci�n para la memoria de programa
		MemProgData : out std_logic_vector(31 downto 0) -- C�digo de operaci�n
	);
end MemProgPlantilla;

architecture Simple of MemProgPlantilla is

begin

	LecturaMemProg: process(MemProgAddr)
	begin
		-- La memoria devuelve un valor para cada direcci�n.
		-- Estos valores son los c�digos de programa de cada instrucci�n,
		-- estando situado cada uno en su direcci�n.
		case MemProgAddr is
		-------------------------------------------------------------
		-- S�lo introducir cambios desde aqu�	

			-- Por cada instrucci�n en .text, agregar una l�nea del tipo:
			-- when DIRECCION => MemProgData <= INSTRUCCION;
			-- Por ejemplo, si la posici�n 0x00000000 debe guardarse la instrucci�n con c�digo m�quina 0x20010004, poner:
			--when X"00000000" => MemProgData <= X"20010004";
		-- Hasta aqu�	
		---------------------------------------------------------------------	
			when X"00000000" => MemProgData <= X"8c042078";
			when X"00000004" => MemProgData <= X"2084001e";
			when X"00000008" => MemProgData <= X"20080000";
			when X"0000000C" => MemProgData <= X"10880008";
			when X"00000010" => MemProgData <= X"8d052000";
			when X"00000014" => MemProgData <= X"8d062028";
			when X"00000018" => MemProgData <= X"00c63020";
			when X"0000001C" => MemProgData <= X"00c63020";
			when X"00000020" => MemProgData <= X"00c53820";
			when X"00000024" => MemProgData <= X"ad072050";
			when X"00000028" => MemProgData <= X"21080004";
			when X"0000002C" => MemProgData <= X"08000003";
			when X"00000030" => MemProgData <= X"0800000c";
			when others => MemProgData <= X"00000000"; -- Resto de memoria vac�a
		end case;
	end process LecturaMemProg;

end Simple;

