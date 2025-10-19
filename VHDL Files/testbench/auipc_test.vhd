library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture BENCH of testbench is
component AUIPC_CIRC is
  port(
    pc_in : in std_logic_vector(31 downto 0);
    inst_in : in std_logic_vector(31 downto 0);
    reg_output : out std_logic_vector(31 downto 0)
  );
end component;

signal fuck1, fuck2, fuck3 : std_logic_vector(31 downto 0);
    
begin
  
  DUT: AUIPC_CIRC port map(fuck1, fuck2, fuck3);
  
  process
  begin
    fuck1 <= "00000000000000000101010101010101";
    fuck2 <= "00000000000000000100000000000000";
    wait for 1 ns;
    assert(fuck3="00000000000000001001010101010101") report "Failed test 1" severity error;
    
    fuck1 <= "01010101010101010101010101010101";
    fuck2 <= "00010101010101010101000000000000";
    wait for 1 ns;
    assert (fuck3="01101010101010101010010101010101") report "Failed test 2" severity error;
    
    fuck1 <= "00000000000000000000000000000000";
    fuck2 <= "00000000000000000000000000000000";
    
    assert false report "Tests done." severity note;
    wait;
  end process;
end BENCH;
