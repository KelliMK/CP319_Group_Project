library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ADD_CIRC is 
port(
    input_reg : in std_logic_vector(31 downto 0);
    a_reg : in std_logic_vector(31 downto 0);
    b_reg : in std_logic_vector(31 downto 0);
    out_reg : out std_logic_vector(31 downto 0)
);
end entity ADD_CIRC; 

architecture SYNTH_ADD of ADD_CIRC is 

	SIGNAL a_num : signed(31 downto 0);
	SIGNAL b_num : signed(31 downto 0);
	SIGNAL out_num : signed(31 downto 0);

begin

	out_num <= a_num + b_num;

end SYNTH_ADD;

