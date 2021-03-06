----------------------------------------------------------------------
-- Fichero: MemDataPlantilla.vhd
-- Descripción: Plantilla para la memoria de datos para el MIPS
-- Fecha última modificación: 2018-06-04

-- Autores: Alberto Sánchez (2012-2018), Ángel de Castro (2010)
-- Asignatura: EC. 1º grado
-- Grupo de Prácticas:
-- Grupo de Teoría:
-- Práctica: 4
-- Ejercicio: 1
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UnidadControl is
	port(
		OpCode     : in std_logic_vector(5 downto 0);
		Funct      : in std_logic_vector(5 downto 0);
		MemToReg   : out std_logic;
		MemWrite   : out std_logic;
		Branch     : out std_logic;
		ALUControl : out std_logic_vector(2 downto 0);
		ALUSrc	   : out std_logic;
		RegDest    : out std_logic;
		RegWrite   : out std_logic;
		ExtCero    : out std_logic;
		Jump       : out std_logic
	);
end UnidadControl;

architecture Control of UnidadControl is

begin

	MemToReg <= '1' when OpCode = "100011" else
				      '0';

	MemWrite <= '1' when OpCode = "101011" else
				      '0';

	Branch 	 <= '1' when OpCode = "000100" else
				      '0';

	ALUSrc	 <= '0' when OpCode = "000000" else
				     '0' when OpCode = "000100" else
				     '1';

	RegDest  <= '1' when OpCode = "000000" else
				      '0';

	RegWrite <= '0' when Opcode = "101011" else
				'0' when Opcode = "000100" else
				'0' when Opcode = "000010" else
				'1';

	ExtCero  <= '1' when OpCode = "001100" else --andi
				'1' when OpCode = "001101" else -- ori
				'0';

	Jump     <= '1' when OpCode = "000010" else
				'0';


	ALUControl <= "110" when OpCode = "000000" and Funct = "100010" else
				  "110" when OpCode = "000100" else
				  "000" when OpCode = "000000" and Funct = "100100" else
				  "000" when OpCode = "001100" else
				  "001" when OpCode = "000000" and Funct = "100101" else
				  "001" when OpCode = "001101" else
				  "101" when OpCode = "000000" and Funct = "100111" else
				  "111" when OpCode = "000000" and Funct = "101010" else
				  "111" when OpCode = "001010" else
				  "010";
end Control;
