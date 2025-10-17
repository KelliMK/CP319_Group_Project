library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ORI_CIRC is 
port(
--     input_reg : in std_logic_vector(31 downto 0);
    a_reg : in std_logic_vector(31 downto 0);
    imm : in std_logic_vector(11 downto 0);
    out_reg : out std_logic_vector(31 downto 0)
);
end entity ORI_CIRC; 

architecture SYNTH_ORI of ORI_CIRC is 

	SIGNAL a_num : std_logic_vector(31 downto 0);
	SIGNAL imm_num : std_logic_vector(11 downto 0);
    SIGNAL sext_imm : std_logic_vector(31 downto 0);
    SIGNAL sign_bit : std_logic;
	SIGNAL out_num : std_logic_vector(31 downto 0);

begin

	a_num <= a_reg;
    imm_num <= imm;
    sign_bit <= imm_num(11); -- MSB
    sext_imm <= (31 downto 12 => sign_bit) & imm_num;

	out_num <= a_num or sext_imm;
    
    out_reg <= out_num;

end SYNTH_ORI;

