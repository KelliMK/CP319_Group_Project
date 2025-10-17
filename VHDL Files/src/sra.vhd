library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SRA_CIRC is 
port(
--     input_reg : in std_logic_vector(31 downto 0);
    a_reg : in std_logic_vector(31 downto 0);
    b_reg : in std_logic_vector(31 downto 0);
    out_reg : out std_logic_vector(31 downto 0)
);
end entity SRA_CIRC; 

architecture SYNTH_SRA of SRA_CIRC is 

	SIGNAL a_num : signed(31 downto 0);
	SIGNAL b_num : unsigned(4 downto 0);
	SIGNAL out_num : signed(31 downto 0);

begin

	a_num <= signed(a_reg);
    b_num <= unsigned(b_reg(4 downto 0));

	out_num <= a_num sra to_integer(b_num);
    
    out_reg <= std_logic_vector(out_num);

end SYNTH_SRA;

