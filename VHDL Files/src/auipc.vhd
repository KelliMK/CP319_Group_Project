library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AUIPC_CIRC is 
port(
    pc_in : in std_logic_vector(31 downto 0);
    inst_in : in std_logic_vector(31 downto 0);
    reg_output : out std_logic_vector(31 downto 0)
);
end entity AUIPC_CIRC; 

architecture SYNTH_AUIPC of AUIPC_CIRC is 

	SIGNAL a_reg : std_logic_vector(31 downto 0) := (others => '0');
	SIGNAL a_num : unsigned(31 downto 0);
	SIGNAL b_reg : std_logic_vector(31 downto 0) := (others => '0');
	SIGNAL b_num : unsigned(31 downto 0);
	SIGNAL out_reg : std_logic_vector(31 downto 0) := (others => '0');
	SIGNAL out_num : unsigned(31 downto 0);

begin
	process(all)
    begin
	a_num <= "00000000000000000000000000000000";
    b_num <= "00000000000000000000000000000000";
    out_num <= "00000000000000000000000000000000";
    a_reg <= pc_in;
	a_num <= unsigned(a_reg(31 downto 0));
    
    b_reg(31 downto 12) <= inst_in(31 downto 12);
    b_num <= unsigned(b_reg(31 downto 0));

	out_num <= a_num + b_num;
	out_reg <= std_logic_vector(out_num);
    
    reg_output <= out_reg;
    end process;

end SYNTH_AUIPC;