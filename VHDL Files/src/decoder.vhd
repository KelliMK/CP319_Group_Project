-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decoder is
  port(
  	clk : in std_logic;
  	inst_in : in std_logic_vector(31 downto 0);
  	rs1 : in bit_vector(4 downto 0);
  	rs2 : in bit_vector(4 downto 0);
  	rd : out bit_vector(4 downto 0)
  );
end decoder;

architecture behaviour of decoder is
begin
  process (rs1, rs2)
  begin
  	case rs1 is 
  	  --! immediate operations
  	  when "00100" => 
  	  	rd <= "00001"; --! placeholder code
  	    --! immediate operations logic goes here
  	  
  	  --! auipc operation
  	  when "00101" => 
  	  	rd <= "00010"; --! placeholder code
  	  	--! auipc logic goes here
  	  
  	  --! mathematical/logical operations
  	  when "01100" => 
  	    rd <= "00011"; --! placeholder code
  	    --! logic goes here

  	  --! lui operation
  	  when "01101" => 
  	  	rd <= "00100"; --! placeholder code
  	  	--! logic goes here

  	  --! branching operations
  	  when "11000" =>
  	  	rd <= "00101"; --! placeholder code
  	  	--! logic goes here

  	  when others =>
  	  	rd <= "00000";

  	end case;
    end process;
	
end architecture behaviour;