library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity ANDI is
  port(
    rs1 : in  std_logic_vector(31 downto 0);
    imm : in  std_logic_vector(31 downto 0);
    rd  : out std_logic_vector(31 downto 0)
  );
end entity ANDI;

architecture behavioural of ANDI is
begin

  rd <= rs1 and imm;
  
end architecture behavioural;