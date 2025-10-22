library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BEQ_CIRC is 
	port(
		clk : in std_logic;
		pc_in : in std_logic_vector(31 downto 0);
		inst_in : in std_logic_vector(31 downto 0);
		rs1 : in std_logic_vector(31 downto 0);
		rs2 : in std_logic_vector(31 downto 0); 
		pc_out : out std_logic_vector(31 downto 0);
	);
end entity BEQ_CIRC;

architecture SYNTH_BEQ of BEQ_CIRC is 
	SIGNAL offset : std_logic_vector(31 downto 0);
	SIGNAL reg_1_val : unsigned(31 downto 0);
	SIGNAL reg_2_val : unsigned(31 downto 0);
	SIGNAL counter_out : unsigned(31 downto 0);

begin
	process(all)
	begin
		reg_1_val <= unsigned(rs1);
		reg_2_val <= unsigned(rs2);
		offset(10 downto 5) <= inst_in(30 downto 25);
		offset(4 downto 1) <= inst_in(11 downto 8);
		offset(11) <= inst_in(7);
		offset(0 downto 0) <= "0";
		if (inst_in(31) = 1) then 
		--! above line keeps throwing 
		--! "WARNING: NUMERIC_STD."=": metavalue detected, returning FALSE" 
		--! despite exhibiting proper behavior
			offset(31 downto 12) <= "11111111111111111111";
		else
			offset(31 downto 12) <= "00000000000000000000";
		end if;

		if (reg_1_val=reg_2_val) then
			counter_out <= unsigned(pc_in) + unsigned(offset);
		else
			counter_out <= unsigned(pc_in) + "00000000000000000000000000100000";
		end if;

		pc_out <= std_logic_vector(counter_out);

	end process;
end SYNTH_BEQ;
