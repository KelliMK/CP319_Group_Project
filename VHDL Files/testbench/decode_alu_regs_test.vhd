LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

library work;
use work.constants.all;

ENTITY decode_alu_reg_tb IS
	-- nothing here
END decode_alu_reg_tb;

ARCHITECTURE SYNTH_decode_alu_reg_tb OF decode_alu_reg_tb IS

	-- Component declarations
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
	SIGNAL en : std_logic := '0';
	SIGNAL instruction : std_logic_vector(15 downto 0) := (others => '0');
	SIGNAL data1 : std_logic_vector(15 downto 0) := (others => '0');
	SIGNAL data2 : std_logic_vector(15 downto 0) := (others => '0');
	SIGNAL dataDwe : std_logic := '0';
	SIGNAL aluop : std_logic_vector(4 downto 0) := (others => '0');
	SIGNAL PC : std_logic_vector(15 downto 0) := (others => '0');
	SIGNAL dataIMM : std_logic_vector(15 downto 0) := (others => '0');
	SIGNAL sel1 : std_logic_vector(2 downto 0) := (others => '0');
	SIGNAL sel2 : std_logic_vector(2 downto 0) := (others => '0');
	SIGNAL selD : std_logic_vector(2 downto 0) := (others => '0');
	SIGNAL dataregWrite: std_logic := '0';
	SIGNAL dataResult : std_logic_vector(15 downto 0) := (others => '0');
	SIGNAL dataWriteReg : std_logic := '0';
	SIGNAL shouldBranch : std_logic := '0';

	-- Clock period definitions
	CONSTANT I_clk_period : time := 2 ns;

BEGIN

	-- make the units under test

	uut_decoder: decoder PORT MAP (
		I_clk => I_clk,
		I_en => en,
		I_dataInst => instruction,
		O_sel1 => sel1,
		O_sel2 => sel2,
		O_selD => selD,
		O_imm => imm,
		O_we => dataDwe,
		O_alu_op => aul_op
	);

	uut_alu: alu PORT MAP (
		I_clk => I_clk,
	  I_en => en,
	  I_data1 => data1,
	  I_data2 => data2,
	  I_dataDwe => dataDwe,
	  I_alu_op => alu_op,
	  I_PC => PC,
	  I_imm => imm,
	  O_dataResult => dataResult,
	  O_dataWriteReg => dataWriteReg,
	  O_takeBranch => takeBranch
	);

	uut_reg32 : reg32_32 PORT MAP ( 
		I_clk => I_clk,
	  I_en => '1',
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

	-- Stimulus Process
	stim_proc: process
	begin
		
		-- hold reset for 10 clock cycles 
		wait for I_clk_period*10;

		-- set enable bit high high
		en <= '1';

		-- we use the constants so we don't have to wait an extra cycle
		instruction <= TEST_LW08;
		wait for 6 ns;

		instruction <= TEST_LW09;
		wait for 6 ns;

		instruction <= TEST_SLT;
		wait for 6 ns;

		assert false report "Check memory values" severity note;

	end process;
end SYNTH_decode_alu_reg_tb;

