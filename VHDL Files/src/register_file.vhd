--! basic RISCV 32-bit register file

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! brief 32-bit RISC-V register file
entity simple_register is 
  port(

  	--! inputs
    rst, clk, ena : IN std_logic;
    reg_in : IN std_logic_vector(31 downto 0);
    reg_out : OUT std_logic_vector(31 downto 0)
  );
end simple_register;

architecture reg_synth of simple_register is

begin
  process (rst, clk)
  begin
    if (rst = '1') then
      reg_out <= X"00000000";
    elsif (clk = '1') then
      if (ena = '1') then
        reg_out <= reg_in;
      end if;
    end if;
  end process;
end architecture reg_synth;