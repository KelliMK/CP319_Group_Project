library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SRL_test is
end SRL_test;

architecture behavioral of SRL_test is

component SRL_circ is
port(
--   input_reg : in std_logic_vector(31 downto 0);
    a_reg : in std_logic_vector(31 downto 0);
    b_reg : in std_logic_vector(31 downto 0);
    out_reg : out std_logic_vector(31 downto 0)
);
end component;

signal a_sig, b_sig : std_logic_vector(31 downto 0);
signal out_sig : std_logic_vector(31 downto 0);


begin
	 inst : SRL_circ -- use component name
     port map ( 
       a_reg => a_sig, 
       b_reg => b_sig,
       out_reg => out_sig
     );
  process
  begin
  -- Normal shift
  a_sig <= X"F0000000";
  b_sig <= X"00000004";
  wait for 100 ms;
  assert(out_sig=X"0F000000") report "Failed test 0" severity error;
  
  -- Shift by 31
  a_sig <= X"80000000";
  b_sig <= X"0000001F";
  wait for 100 ms;
  assert(out_sig=X"00000001") report "Failed test 1" severity error;
  
  -- Shift 1 by 1
  a_sig <= X"00000001";
  b_sig <= X"00000001";
  wait for 100 ms;
  assert(out_sig=X"00000000") report "Failed test 2" severity error;
  
  -- Only the lowest 5 bits are considered
  a_sig <= X"AAAAAAAA";
  b_sig <= X"FFFFFF05";
  wait for 100 ms;
  assert(out_sig=X"05555555") report "Failed test 3" severity error;
	
  end process;
end behavioral;