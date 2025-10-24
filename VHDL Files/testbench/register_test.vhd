LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY reg32_32_tb is
	--! nothing here dawg
end reg32_32_tb;

architecture SYNTH_TB_REG32 of reg32_32_tb is 

	--! DUT
	component reg32_32 
	port(
		I_clk : in std_logic; --! clock bit
		I_en : in std_logic; --! enable bit
		I_dataD : in std_logic_vector(31 downto 0);	--! instruction in
		O_data1 : out std_logic_vector(31 downto 0);
		O_data2 : out std_logic_vector(31 downto 0);
		I_sel1 : in std_logic_vector(4 downto 0);
		I_sel2 : in std_logic_vector(4 downto 0);
		I_selD : in std_logic_vector(4 downto 0);
		I_we : in std_logic --! write-enable bit
	);
	end component;

	--! Inputs
	signal I_clk : std_logic := '0';
	signal I_en : std_logic := '0';
	signal I_dataD : std_logic_vector(31 downto 0) := (others => '0');
	signal I_sel1 : std_logic_vector(4 downto 0) := (others => '0');
	signal I_sel2 : std_logic_vector(4 downto 0) := (others => '0');
	signal I_selD : std_logic_vector(4 downto 0) := (others => '0');
	signal I_we : std_logic := '0';

	--! Outputs
	signal O_data1 : std_logic_vector(31 downto 0) := (others => '0');
	signal O_data2 : std_logic_vector(31 downto 0) := (others => '0');

	--! clock period
	constant I_clk_period : time := 2 ns;
BEGIN

	-- Instantiate the Unit Under Test (UUT)
  uut: reg32_32 PORT MAP (
    I_clk => I_clk,
    I_en => I_en,
    I_dataD => I_dataD,
    O_data1 => O_data1,
    O_data2 => O_data2,
    I_sel1 => I_sel1,
    I_sel2 => I_sel2,
    I_selD => I_selD,
    I_we => I_we
  );

	-- Clock process definitions
	I_clk_process: process
	begin
  	I_clk <= '0';
  	wait for I_clk_period/2;
  	I_clk <= '1';
  	wait for I_clk_period/2;
 	end process;

 	-- Stimulus process
 	stim_proc: process
 	begin
  	-- hold reset state for 10 ns.
  	wait for 10 ns;	

  	I_en <= '1';

  	-- Test 1: write BEEFBABE to r8
	  I_sel1 <= "01000";
  	I_sel2 <= "01001";
	  I_selD <= "01000";
  	I_dataD <= X"BEEFBABE";
	  I_we <= '1';
    wait for 4 ns;
    assert (O_data1=X"BEEFBABE") report ("Failed Test 1") severity note;

  	-- Test 2: write 22222222 to reg 9
	  I_sel1 <= "01000";
  	I_sel2 <= "01001";
	  I_selD <= "01001";
	  I_dataD <= X"22222222";
	  I_we <= '1';
    wait for 4 ns;
    assert (O_data2=X"22222222") report ("Failed Test 2") severity note;

	  -- Test 3: write 33333333 to reg 9
	  I_sel1 <= "01000";
  	I_sel2 <= "01001";
	  I_selD <= "01001";
	  I_dataD <= X"33333333";
	  I_we <= '1';
    wait for 4 ns;
    assert (O_data2=X"33333333") report ("Failed Test 3") severity note;

  	-- Test 4: test write enable bit
  	I_we <= '0';
  	I_sel1 <= "01000";
  	I_sel2 <= "01001";
	  I_selD <= "01001";
  	I_dataD <= X"AAAAAAAA";
    wait for 4 ns;
    assert (O_data2=X"33333333") report ("Failed Test 4") severity note;

  	-- Test 5: check regs 18 and 19 are all 0s
  	I_we <= '1';
  	I_sel1 <= "10010";
  	I_sel2 <= "10011";
    wait for 4 ns;
    assert (O_data1=X"00000000") report ("Failed Test 5 reg 18") severity note;
    assert (O_data2=X"00000000") report ("Failed Test 5 reg 19") severity note;

    -- Test 6: write to same register from both 
  	I_sel1 <= "01000";
  	I_sel2 <= "01000";
	  I_selD <= "01000";
  	I_dataD <= X"44444444";
  	I_we <= '1';
    wait for 4 ns;
    assert (O_data1=X"44444444") report ("Failed Test 6") severity note;
    
    assert false report ("Tests Finished") severity note;

    wait;
 	end process;

end SYNTH_TB_REG32;