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
	COMPONENT control_simple
	PORT(
		I_clk : in std_logic;
		I_reset : in std_logic;
		O_state : std_logic_vector(3 downto 0)
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
	SIGNAL state : std_logic_vector(3 downto 0) := (others => '0');

	SIGNAL en_decode : std_logic := '0';
	SIGNAL en_regread : std_logic := '0';
	SIGNAL en_regwrite : std_logic := '0';
	SIGNAL en_alu : std_logic := '0';

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
	en_decode <= state(0);
	en_regread <= state(1);
	en_alu <= state(2);
	en_regwrite <= state(3);

	-- Stimulus Process
	stim_proc: process
	begin
		
		-- hold reset for 10 clock cycles 
		wait for I_clk_period*10;

		-- reset control unit
		reset <= '1';

		-- load Hx1000 into register 8
		instruction <= "00000000000000000001010000110111";
		reset <= '0'; -- enable/start control unit
		wait until en_regwrite = '1'; --! wait until the pipeline is done writing

		-- load Hx2000 into register 9
		instruction <= "00000000000000000010010010110111";
		wait until en_regwrite = '1'; --! wait until the pipeline is done writing

		-- load Hx4000 into register 18
		instruction <= "00000000000000000100100100110111";
		wait until en_regwrite = '1'; --! wait until the pipeline is done writing

		instruction <= TEST_SLT;
		wait until en_regwrite = '1'; --! wait until the pipeline is done writing
    assert(dataResult = "00000000000000000000000000000001") report ("Test 1 failed.") severity note;

		assert false report "Check memory values" severity note;

	end process;
end SYNTH_d_a_r_cs_tb;

