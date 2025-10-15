library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decoder is
  port(
    clk : in std_logic;
    inst_in : in std_logic_vector(31 downto 0);
    inst_code_dummy : in bit_vector(4 downto 0);
    r1_bit : out std_logic; --! indicates if rs1 is used
    r2_bit : out std_logic; --! indicates if rs2 is used
    rs1 : out bit_vector(4 downto 0);
    rs2 : out bit_vector(4 downto 0);
    rd : out bit_vector(4 downto 0)
  );
end decoder;

architecture behaviour of decoder is
begin
  process (inst_code_dummy, rd)
  begin
    case inst_code_dummy is 

      --! lw operation (load word)
      when "00000" =>
        rd <= "00000"; --! placeholder code

      --! immediate operations
      when "00100" => 
        --! immediate operations logic goes here
        rd <= "00001"; --! placeholder code
      
      --! auipc operation
      when "00101" => 
        --! auipc logic goes here
        rd <= "00010"; --! placeholder code

      --! sw operation
      when "01000" =>
        --! sw logic goes here
        rd <= "00011";
      
      --! mathematical/logical operations
      when "01100" => 
        --! logic goes here
        rd <= "00100"; --! placeholder code

      --! lui operation
      when "01101" => 
        --! logic goes here
        rd <= "00101"; --! placeholder code

      --! branching operations
      when "11000" =>
        --! logic goes here
        rd <= "00110"; --! placeholder code

      when others =>
        rd <= "11111";

    end case;
    end process;
  
end architecture behaviour;