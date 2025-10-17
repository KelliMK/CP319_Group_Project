library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SRA_test is
end SRA_test;

architecture behavioral of SRA_test is

component SRA_circ is
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
	 inst : SRA_circ -- use component name
     port map ( 
       a_reg => a_sig, 
       b_reg => b_sig,
       out_reg => out_sig
     );
  process
  begin
  -- Normal shift
  a_sig <= X"80000000";
  b_sig <= X"00000001";
  wait for 100 ms;
  assert(out_sig=X"C0000000") report "Failed test 0" severity error;
  
  -- Alls 1s stay all 1s
  a_sig <= X"FFFFFFFF";
  b_sig <= X"00000004";
  wait for 100 ms;
  assert(out_sig=X"FFFFFFFF") report "Failed test 1" severity error;
  
  -- All 0s stay all 0s
  a_sig <= X"00000000";
  b_sig <= X"FFFF0005";
  wait for 100 ms;
  assert(out_sig=X"00000000") report "Failed test 2" severity error;
  
  -- Only the lowest 5 bits are considered
  a_sig <= X"80000000";
  b_sig <= X"FFFF0001";
  wait for 100 ms;
  assert(out_sig=X"C0000000") report "Failed test 3" severity error;
	
  end process;
end behavioral;