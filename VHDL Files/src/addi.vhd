library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity ADDI is
port( 
  rs1 : in std_logic_vector(31 downto 0);
  imm : in std_logic_vector(31 downto 0);
  rd : out std_logic_vector(31 downto 0);
);
end entity ADDI;

architecture behavioural of ADDI is
  signal a : signed(31 downto 0);
  signal immediate : signed(31 downto 0);
  signal out_sig : signed(31 downto 0);
begin
  
  a <= signed(rs1);
  immediate <= signed(imm);
  out_sig <= a + immediate;
  rd <= std_logic_vector(out_sig);

 
end architecture behavioural;