library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AND_OP is
  port(
    rs1 : in  std_logic_vector(31 downto 0);
    rs2 : in  std_logic_vector(31 downto 0);
    rd  : out std_logic_vector(31 downto 0)
  );
end entity AND_OP;

architecture behavioural of AND_OP is
begin

  rd <= rs1 and rs2;
  
end architecture behavioural;