library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity or_test is
end or_test;

architecture behavioral of or_test is

component or_circ is
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
	 inst : or_circ -- use component name
     port map ( 
       a_reg => a_sig, 
       b_reg => b_sig,
       out_reg => out_sig
     );
  process
  begin
  a_sig <= X"00000000";
  b_sig <= X"FFFFFFFF";
  wait for 10 ms;
  assert(out_sig=X"FFFFFFFF") report "Failed test 0" severity error;
  
  a_sig <= X"00000000";
  b_sig <= X"0000000F";
  wait for 10 ms;
  assert(out_sig=X"0000000F") report "Failed test 1" severity error;
  
	end process;
end behavioral;