----------------------------------------------------------------------
-- Fichero: MicroMIPS.vhd
-- Descripci�n: Banco de pruebas para el microprocesador MIPS
--              con las memorias del programa vectores
-- Fecha �ltima modificaci�n: 2017-03-27

-- Autores: Alberto S�nchez (2012-2017) Miguel Company (2016)
-- Asignatura: EC 1� grado
-- Grupo de Pr�cticas:
-- Grupo de Teor�a:
-- Pr�ctica: 4
-- Ejercicio: 3
----------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity MicroMIPS is
    port(
        Clk : in std_logic; -- Reloj
        NRst : in std_logic; -- Reset activo a nivel bajo
        MemProgAddr : out std_logic_vector(31 downto 0); -- Direcci�n para la memoria de programa
        MemProgData : in std_logic_vector(31 downto 0); -- C�digo de operaci�n
        MemDataAddr : out std_logic_vector(31 downto 0); -- Direcci�n para la memoria de datos
        MemDataDataRead : in std_logic_vector(31 downto 0); -- Dato a leer en la memoria de datos
        MemDataDataWrite : out std_logic_vector(31 downto 0); -- Dato a guardar en la memoria de datos
        MemDataWE : out std_logic
  );
end MicroMIPS;

architecture micro of MicroMIPS is

  component UnidadControl
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
  end component;

  component ALUMIPS
  port(
    Op1 : in std_logic_vector (31 downto 0);
    Op2 : in std_logic_vector (31 downto 0);
    ALUControl : in std_logic_vector (2 downto 0);
    Res : out std_logic_vector (31 downto 0);
    Z : out std_logic
  );
  end component;

  component RegsMIPS
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
  end component;

  signal auxExtCero: std_logic_vector(31 downto 0);
  signal auxExtSigno: std_logic_vector(31 downto 0);
  signal auxExtALU: std_logic_vector(31 downto 0);

begin

  Ucontrol: UnidadControl
  port map(
    OpCode => OpCode,
    Funct => Funct,
    MemToReg => MemToReg,
    MemWrite => MemWrite,
    Branch => Branch,
    ALUControl => ALUControl,
    ALUSrc => ALUSrc,
    RegDest => RegDest,
    RegWrite => RegWrite,
    ExtCero => ExtCero,
    Jump => Jump
  );

  ALU: ALUMIPS
  port map(
    Op1 => Op1,
    Op2 => Op2,
    ALUControl => ControlALU,
    Res => Res,
    Z => Z
  );

  Regs: RegsMIPS
  port map(
    Clk => Clk,
    NRst => NRst,
    A1 => MemProgData(25 downto 21),
    Rd1 => Rd1,
    A2 => MemProgData(20 downto 16),
    Rd2 => Rd2,
    A3 => A3,
    Wd3 => Wd3,
    We3 => We3
  );

  with RegDest select
  A3 <= MemProgData(20 downto 16) when '0',
        MemProgData(15 downto 11) when others;

  auxExtCero <= 



end micro;
