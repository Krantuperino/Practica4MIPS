----------------------------------------------------------------------
-- Fichero: RegsMIPS.vhd
-- Descripción: Banco completo de registros del microprocesador MIPS
-- Fecha última modificación:

-- Autores: 
-- Asignatura: E.C. 1º grado
-- Grupo de Prácticas:
-- Grupo de Teoría:
-- Práctica: 2
-- Ejercicio: 1
----------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity RegsMIPS is
	port (
		Clk : in std_logic; -- Reloj
		NRst : in std_logic; -- Reset asíncrono a nivel bajo
		A1 : in std_logic_vector(4 downto 0); -- Dirección para el puerto Rd1
		Rd1 : out std_logic_vector(31 downto 0); -- Dato del puerto Rd1
		A2 : in std_logic_vector(4 downto 0); -- Dirección para el puerto Rd2
		Rd2 : out std_logic_vector(31 downto 0); -- Dato del puerto Rd2
		A3 : in std_logic_vector(4 downto 0); -- Dirección para el puerto Wd3
		Wd3 : in std_logic_vector(31 downto 0); -- Dato de entrada Wd3
		We3 : in std_logic -- Habilitación del banco de registros
	); 
end RegsMIPS;

architecture Practica of RegsMIPS is

	-- Tipo para almacenar los registros
	type regs_t is array (0 to 31) of std_logic_vector(31 downto 0);

	-- Esta es la señal que contiene los registros. El acceso es de la
	-- siguiente manera: regs(i) acceso al registro i, donde i es
	-- un entero. Para convertir del tipo std_logic_vector a entero se
	-- hace de la siguiente manera: conv_integer(slv), donde
	-- slv es un elemento de tipo std_logic_vector

	signal regs : regs_t;

begin  -- PRACTICA

	------------------------------------------------------
	-- Escritura del registro Wd
	------------------------------------------------------
	-- Escribe el contenido de Wd3 en el registro indicado
	-- por A3 cuando hay flanco de subida de reloj y
	-- la señal de habilitación de escritura We3 está activa.
	-- Tiene reset asíncrono. Si está habilitado el reset, 
	-- todos los registros se inicializan a valor 0
  process (Clk, NRst)
    begin
      if NRst = '0' then
        for i in 0 to 31 loop 
          regs(i) <= (others=>'0');
        end loop;
      end if;       
             
      if We3 = '1' then
        if rising_edge(Clk) then
        -- Escribe el contenido de Wd3 en el registro indicado por A3   
          if (conv_integer(A3)/= 0) then
             regs(conv_integer(A3))<= Wd3;
          end if;
        end if; 
      end if;
  end process;       
  
	------------------------------------------------------
	-- Lectura del registro Rd1
	------------------------------------------------------
	-- Lee en Rd1 el registro indicado por A1. 
	-- La lectura del registro R0 siempre devuelve 0.

  Rd1 <= regs(conv_integer(A1)); 

	------------------------------------------------------
	-- Lectura del registro Rd2
	------------------------------------------------------
	-- Lee en Rd2 el registro indicado por A2. 
	-- La lectura del registro R0 siempre devuelve 0.

  Rd2 <= regs(conv_integer(A2)); 

end Practica;