library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LW_CIRC is 
	port(
		clk : in std_logic;
		inst_in : in std_logic_vector(31 downto 0);
		rs1 : in std_logic_vector(31 downto 0); --! pretending that this is the value from memory for now
		rd : out std_logic_vector(31 downto 0)
	);
end entity LW_CIRC;

architecture SYNTH_LW of LW_CIRC is 
	SIGNAL offset : signed(11 downto 0);

begin
	process(all)
	begin
		offset <= signed(inst_in(31 downto 20));
		rd <= RESIZE(signed(rs1), to_integer(offset));
	end process;
end SYNTH_LW;