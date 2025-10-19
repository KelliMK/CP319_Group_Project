library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SLL_CIRC is 
	port(
		clk : in std_logic;
		rs1 : in std_logic_vector(31 downto 0);
        rs2 : in std_logic_vector(31 downto 0);
		rd : out std_logic_vector(31 downto 0)
	);
end entity SLL_CIRC;

architecture SYNTH_SLL of SLL_CIRC is 
	SIGNAL shift_by : unsigned(4 downto 0);

begin
	process(all)
	begin
		shift_by <= unsigned(rs2(4 downto 0));
		rd <= std_logic_vector(SHIFT_LEFT(unsigned(rs1), to_integer(shift_by)));
	end process;
end SYNTH_SLL;