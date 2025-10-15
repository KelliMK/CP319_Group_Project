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
    inst_code_dummy : in bit_vector(4 downto 0);
    r1_bit : out std_logic; -- indicates if rs1 is used
    r2_bit : out std_logic; -- indicates if rs2 is used
    rs1 : out bit_vector(4 downto 0);
    rs2 : out bit_vector(4 downto 0);
    rd : out bit_vector(4 downto 0)
  );
end component;

signal dummy_inst, piss1, piss2, piss3 : bit_vector(4 downto 0);
signal cck, r1_dummy, r2_dummy : std_logic;
signal inst : std_logic_vector(31 downto 0);

begin
  -- Connect DUT
  DUT: decoder port map(cck, inst, dummy_inst, r1_dummy, r2_dummy, piss1, piss2, piss3);
  
  process
  begin
    dummy_inst <= "00000";
    wait for 1 ns;
    assert(piss3="00000") report "Failed test 0" severity error;

    dummy_inst <= "00100";
    wait for 1 ns;
    assert(piss3="00001") report "Failed test 1" severity error;
    
    dummy_inst <= "00101";
    wait for 1 ns;
    assert(piss3="00010") report "Failed test 2" severity error;
    
    dummy_inst <= "01000";
    wait for 1 ns;
    assert(piss3="00011") report "Failed test 3" severity error;
    
    dummy_inst <= "01100";
    wait for 1 ns;
    assert(piss3="00100") report "Failed test 4" severity error;
    
    dummy_inst <= "01101";
    wait for 1 ns;
    assert(piss3="00101") report "Failed test 5" severity error;
    
    dummy_inst <= "11000";
    wait for 1 ns;
    assert(piss3="00110") report "Failed test 6" severity error;

    dummy_inst <= "11111";
    wait for 1 ns;
    assert(piss3="11111") report "Failed test others" severity error;
    
    -- Clear Input
    dummy_inst <= "00000";
    
    assert false report "Tests done." severity note;
    wait;
  end process;
end tb;
