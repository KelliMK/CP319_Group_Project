library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LUI_CIRC is 
	port(
		clk : in std_logic;
		inst_in : in std_logic_vector(31 downto 0);
		rd : out std_logic_vector(31 downto 0)
	);
end entity LUI_CIRC;

architecture SYNTH_LUI of LUI_CIRC is 
	SIGNAL immediate : std_logic_vector(31 downto 0);

begin
	process(all)
	begin
		immediate(31 downto 12) <= inst_in(31 downto 12);
		immediate(11 downto 0) <= "000000000000";
		rd <= immediate;
	end process;
end SYNTH_LUI;
