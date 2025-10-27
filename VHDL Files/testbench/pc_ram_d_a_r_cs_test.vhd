LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

library work;
use work.my_constants.all;

entity ram_tb is 
	PORT(
		I_clk : in STD_LOGIC;
    I_we : in STD_LOGIC;
    I_en : in STD_LOGIC;
    I_addr : in STD_LOGIC_VECTOR (31 downto 0);
    I_data : in STD_LOGIC_VECTOR (31 downto 0);
    O_data : out STD_LOGIC_VECTOR (31 downto 0)
	);
end ram_tb;

architecture SYNTH_ram_tb of ram_tb is
  type store_t is array (0 to 31) of std_logic_vector(31 downto 0);
  -- AAAAAAAAAAAAAAAAAAAAAAAAAAAAA
  signal ram: store_t := (
  	"00000000000000000001010000110111",
  	"00000000000000000001010010110111",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011",
  	"00000000000000000000000000000011"
  );
begin

  process (I_clk)
  begin
    if rising_edge(I_clk) then
      if (I_we = '1') then
        ram(to_integer(unsigned(I_addr(4 downto 0)))) <= I_data;
      else
        O_data <= ram(to_integer(unsigned(I_addr(4 downto 0))));
      end if;
    end if;
  end process;

end SYNTH_ram_tb;

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

library work;
use work.my_constants.all;

ENTITY d_a_r_cs_tb IS
	-- nothing here
END d_a_r_cs_tb;

ARCHITECTURE SYNTH_d_a_r_cs_tb OF d_a_r_cs_tb IS

	-- Component declarations
	component ram_tb
	Port ( 
		I_clk : in  STD_LOGIC;
    I_we : in  STD_LOGIC;
    I_en : in STD_LOGIC;
    I_addr : in  STD_LOGIC_VECTOR (31 downto 0);
    I_data : in  STD_LOGIC_VECTOR (31 downto 0);
    O_data : out  STD_LOGIC_VECTOR (31 downto 0)
  );
	end component;

	COMPONENT program_counter
	PORT(
    I_clk : IN  std_logic;
    I_nPC : IN  std_logic_vector(31 downto 0);
    I_nPCop : IN  std_logic_vector(1 downto 0);
    O_PC : OUT std_logic_vector(31 downto 0)
  );
	END COMPONENT;

	COMPONENT control_simple
	PORT(
		I_clk : in std_logic;
		I_reset : in std_logic;
		O_state : out std_logic_vector(4 downto 0)
	);
	END COMPONENT;

	COMPONENT decoder
	PORT(
		I_clk : in std_logic; --! clock bit
    I_en : in std_logic; --! enable bit
    I_inst : in std_logic_vector(31 downto 0); --! the current instruction
    O_alu_op : out std_logic_vector(5 downto 0);
    O_imm : out std_logic_vector(31 downto 0);
    O_we : out std_logic; --! write enable bit, USE IF YOU ARE WRITING TO A REGISTER
    O_rs1 : out std_logic_vector(4 downto 0);
    O_rs2 : out std_logic_vector(4 downto 0);
    O_rd : out std_logic_vector(4 downto 0)
	);
	END COMPONENT;

	COMPONENT alu
	PORT(
		I_clk : in std_logic;	--! clock bit
		I_en : in std_logic; --! enable bit
		I_data1 : in std_logic_vector(31 downto 0); --! rs1 data
		I_data2 : in std_logic_vector(31 downto 0); --! rs2 data
		I_dataDwe : in std_logic; --! rd write enable bit
		I_aluop : in std_logic_vector(5 downto 0); --! alu op code
		I_PC : in std_logic_vector(31 downto 0); --! Program counter
		I_dataIMM : in std_logic_vector(31 downto 0); --! immediate
		O_dataResult : out std_logic_vector(31 downto 0); --! result of ALU calculation
		O_dataWriteToReg : out std_logic; --! we writing to a fookin register?
		O_takeBranch : out std_logic --! do I need to explain this one?
	);
	END COMPONENT;

	COMPONENT reg32_32
	PORT(
		I_clk : in std_logic; --! clock bit
		I_en : in std_logic; --! enable bit
		I_dataD : in std_logic_vector(31 downto 0);
		O_data1 : out std_logic_vector(31 downto 0);
		O_data2 : out std_logic_vector(31 downto 0);
		I_sel1 : in std_logic_vector(4 downto 0);
		I_sel2 : in std_logic_vector(4 downto 0);
		I_selD : in std_logic_vector(4 downto 0);
		I_we : in std_logic --! write-enable bit
	);
	END COMPONENT;

	-- Signals

	SIGNAL I_clk: std_logic := '0';
	SIGNAL reset : std_logic := '1';
	SIGNAL state : std_logic_vector(5 downto 0) := (others => '0');

	SIGNAL en_fetch : std_logic := '0';
	SIGNAL en_decode : std_logic := '0';
	SIGNAL en_regread : std_logic := '0';
	SIGNAL en_alu : std_logic := '0';
	SIGNAL en_memory : std_logic := '0';
	SIGNAL en_regwrite : std_logic := '0';

	signal ramWE : std_logic := '0';
	signal ramAddr: std_logic_vector(31 downto 0);
	signal ramRData: std_logic_vector(31 downto 0);
	signal ramWData: std_logic_vector(31 downto 0);

	signal nPC: std_logic_vector(31 downto 0);
	signal pcop: std_logic_vector(1 downto 0);
	signal in_pc: std_logic_vector(31 downto 0);

	SIGNAL instruction : std_logic_vector(31 downto 0) := (others => '0');
	SIGNAL data1 : std_logic_vector(31 downto 0) := (others => '0');
	SIGNAL data2 : std_logic_vector(31 downto 0) := (others => '0');
	SIGNAL dataDwe : std_logic := '0';
	SIGNAL aluop : std_logic_vector(5 downto 0) := (others => '0');
	SIGNAL PC : std_logic_vector(31 downto 0) := (others => '0');
	SIGNAL imm : std_logic_vector(31 downto 0) := (others => '0');
	SIGNAL sel1 : std_logic_vector(4 downto 0) := (others => '0');
	SIGNAL sel2 : std_logic_vector(4 downto 0) := (others => '0');
	SIGNAL selD : std_logic_vector(4 downto 0) := (others => '0');
	SIGNAL dataregWrite: std_logic := '0';
	SIGNAL dataResult : std_logic_vector(31 downto 0) := (others => '0');
	SIGNAL dataWriteReg : std_logic := '0';
	SIGNAL takeBranch : std_logic := '0';

	-- Clock period definitions
	CONSTANT I_clk_period : time := 2 ns;

BEGIN

	-- make the units under test

	uut_ram: ram_tb Port map (
  	I_clk => I_clk,
  	I_we => ramWE,
  	I_addr => ramAddr,
  	I_data => ramWData,
  	O_data => ramRData
	);

	uut_pcunit: program_counter Port map (
  	I_clk => I_clk,
  	I_nPC => in_pc,
  	I_nPCop => pcop,
  	O_PC => PC
	);

	uut_control: control_simple PORT MAP(
		I_clk => I_clk,
		I_reset => reset,
		O_state => state
	);

	uut_decoder: decoder PORT MAP (
		I_clk => I_clk,
		I_en => en_decode,
		I_inst => instruction,
		O_rs1 => sel1,
		O_rs2 => sel2,
		O_rd => selD,
		O_imm => imm,
		O_we => dataDwe,
		O_alu_op => aluop
	);

	uut_alu: alu PORT MAP (
		I_clk => I_clk,
	  I_en => en_alu,
	  I_data1 => data1,
	  I_data2 => data2,
	  I_dataDwe => dataDwe,
	  I_aluop => aluop,
	  I_PC => PC,
	  I_dataIMM => imm,
	  O_dataResult => dataResult,
	  O_dataWriteToReg => dataWriteReg,
	  O_takeBranch => takeBranch
	);

	uut_reg32 : reg32_32 PORT MAP ( 
		I_clk => I_clk,
	  I_en => en_regread OR en_regwrite,
	  I_dataD => dataResult,
	  O_data1 => data1,
	  O_data2 => data2,
	  I_sel1 => sel1,
	  I_sel2 => sel2,
	  I_selD => selD,
	  I_we => dataWriteReg
	);

	-- Clock process definitions
	I_clk_process :process
	begin
		I_clk <= '0';
		wait for I_clk_period/2;
		I_clk <= '1';
		wait for I_clk_period/2;
	end process;

	-- tie the control_simple state machine to the enable bits
  en_fetch <= state(0);
	en_decode <= state(1);
	en_regread <= state(2);
	en_alu <= state(3);
	en_memory <= state(4)
	en_regwrite <= state(5);

	pcop <= PC_OP_RESET when reset = '1' else	
	  PC_OP_ASSIGN when takeBranch = '1' and state(4) = '1' else 
	  PC_OP_INC when takeBranch = '0' and state(4) = '1' else 
		PC_OP_NOP;

	in_pc <= dataResult;

	ramAddr <= std_logic_vector(unsigned(PC) / 32);
	ramWData <= X"FFFFFFFC";
	ramWE <= '0';

	instruction <= ramRData;

	-- Stimulus Process
	stim_proc: process
	begin
		reset <= '1'; -- reset control unit
		wait for I_clk_period;
		reset <= '0';

		wait until PC = X"00000400"; -- 32 instructions loaded into RAM
		reset <= '1';
		wait;
	end process;
end SYNTH_d_a_r_cs_tb;

