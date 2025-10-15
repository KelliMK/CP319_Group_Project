-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
-- empty
end testbench;

architecture tb of testbench is

-- DUT component
component decoder is
  port(
  	clk : in std_logic;
  	inst_in : in std_logic_vector(31 downto 0);
  	rs1 : in bit_vector(4 downto 0);
  	rs2 : in bit_vector(4 downto 0);
  	rd : out bit_vector(4 downto 0)
  );
end component;

signal piss1, piss2, piss3 : bit_vector(4 downto 0);
signal cck : std_logic;
signal inst : std_logic_vector(31 downto 0);

begin
  -- Connect DUT
  DUT: decoder port map(cck, inst, piss1, piss2, piss3);
  
  process
  begin
    piss1 <= "00100";
    wait for 1 ns;
    assert(piss3="00001") report "Failed test 1" severity error;
    
    piss1 <= "00101";
    wait for 1 ns;
    assert(piss3="00010") report "Failed test 2" severity error;
    
    piss1 <= "01100";
    wait for 1 ns;
    assert(piss3="00011") report "Failed test 3" severity error;
    
    piss1 <= "01101";
    wait for 1 ns;
    assert(piss3="00100") report "Failed test 4" severity error;
    
    piss1 <= "11000";
    wait for 1 ns;
    assert(piss3="00101") report "Failed test 5" severity error;
    
    piss1 <= "11111";
    wait for 1 ns;
    assert(piss3="00000") report "Failed test 6" severity error;
    
    -- Clear Inputs
    piss1 <= "00000";
    
    assert false report "Tests done." severity note;
    wait;
  end process;
end tb;