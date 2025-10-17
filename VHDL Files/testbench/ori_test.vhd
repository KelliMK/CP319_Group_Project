library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ORI_test is
end ORI_test;

architecture behavioral of ORI_test is

component ORI_circ is
port(
--   input_reg : in std_logic_vector(31 downto 0);
    a_reg : in std_logic_vector(31 downto 0);
    imm : in std_logic_vector(11 downto 0);
    out_reg : out std_logic_vector(31 downto 0)
);
end component;

signal a_sig   : std_logic_vector(31 downto 0);
signal imm_sig : std_logic_vector(11 downto 0);
signal out_sig : std_logic_vector(31 downto 0);


begin
	 inst : ORI_circ -- use component name
     port map ( 
       a_reg => a_sig, 
       imm => imm_sig,
       out_reg => out_sig
     );
  process
  begin
  a_sig <= X"12345678";
  imm_sig <= X"0F0";
  wait for 100 ms;
  assert(out_sig=X"123456F8") report "Failed test 0" severity error;
  
  -- Negative immediate
  a_sig <= X"12345678";
  imm_sig <= X"F34";
  wait for 100 ms;
  assert(out_sig=X"FFFFFF7C") report "Failed test 1" severity error;
  
  a_sig <= X"00000000";
  imm_sig <= X"800";
  wait for 100 ms;
  assert(out_sig=X"FFFFF800") report "Failed test 2" severity error;

  a_sig <= X"FFFFFFFF";
  imm_sig <= X"FFF";
  wait for 100 ms;
  assert(out_sig=X"FFFFFFFF") report "Failed test 3" severity error;

  a_sig <= X"AAAAAAAA";
  imm_sig <= X"D55";
  wait for 100 ms;
  assert(out_sig=X"FFFFFFFF") report "Failed test 4" severity error;
	
  end process;
end behavioral;