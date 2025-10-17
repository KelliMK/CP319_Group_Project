library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity OR_CIRC is 
port(
--     input_reg : in std_logic_vector(31 downto 0);
    a_reg : in std_logic_vector(31 downto 0);
    b_reg : in std_logic_vector(31 downto 0);
    out_reg : out std_logic_vector(31 downto 0)
);
end entity OR_CIRC; 

architecture SYNTH_OR of OR_CIRC is 

	SIGNAL a_num : std_logic_vector(31 downto 0);
	SIGNAL b_num : std_logic_vector(31 downto 0);
	SIGNAL out_num : std_logic_vector(31 downto 0);

begin

	a_num <= a_reg;
    b_num <= b_reg;

	out_num <= a_num OR b_num;
    
    out_reg <= out_num;

end SYNTH_OR;

