--! basic RISCV 32-bit register file

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! brief 32-bit RISC-V register file
entity program_counter is 
  port(
  	--! inputs
    rst, clk, ena : IN std_logic;
    pc_in : IN std_logic_vector(31 downto 0);
    pc_out : OUT std_logic_vector(31 downto 0)
  );
end program_counter;

architecture pc_arch of program_counter is

begin
  process (rst, clk)
  begin
    if (rst = '1') then
      pc_out <= X"00000000";
    elsif (clk = '1') then
      if (ena = '1') then
        pc_out <= pc_in;
      else
        pc_out <= std_logic_vector(to_unsigned(to_integer(unsigned(pc_out)) + 32, pc_out'length));
      end if;
    end if;
  end process;
end architecture pc_arch;