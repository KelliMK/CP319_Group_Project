library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SUB_CIRC is 
port(
--     input_reg : in std_logic_vector(31 downto 0);
    a_reg : in std_logic_vector(31 downto 0);
    b_reg : in std_logic_vector(31 downto 0);
    out_reg : out std_logic_vector(31 downto 0)
);
end entity SUB_CIRC; 

architecture SYNTH_SUB of SUB_CIRC is 

	SIGNAL a_num : signed(31 downto 0);
	SIGNAL b_num : signed(31 downto 0);
	SIGNAL out_num : signed(31 downto 0);

begin

	a_num <= signed(a_reg);
    b_num <= signed(b_reg);

	out_num <= a_num - b_num;
    
    out_reg <= std_logic_vector(out_num);

end SYNTH_SUB;

