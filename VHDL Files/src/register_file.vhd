--! basic RISCV register file

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! brief 32-bit RISC-V register file
entity register_file is 
  port(

  	--! inputs
  	clk	: in std_logic; --! clock input bit
  	rd_write : in std_logic; --! write enable bit
  	rd_addr : in std_logic_vector(4 downto 0); --! destination register address
  	rs1_addr : in std_logic_vector(4 downto 0);	--! register 1 address
  	rs2_addr : in std_logic_vector(4 downto 0); --! register 2 address
  	rd_data : in std_logic_vector(31 downto 0); --! destination register

  	--! outputs
  	rs1_data : out std_logic_vector(31 downto 0); --! register 1 value
  	rs2_data : out std_logic_vector(31 downto 0) --! register 2 value
  ); 
end entity register_file;

architecture behaviour of register_file is 
  
  --! Register array type
  type regfile_array is array(0 to 31) of std_logic_vector(31 downto 0);

begin

  regfile: process(clk)
    variable registers : regfile_array := (others => (others => '0'));
  begin
  	if rising_edge(clk) then
  	  if rd_write = '1' and rd_addr /= b"00000" then	--! if write enable is on and rd_addr is all 0s
  	  	registers(to_integer(unsigned(rd_addr))) := rd_data;
  	  end if;

  	  rs1_data <= registers(to_integer(unsigned(rs1_addr)));
  	  rs2_data <= registers(to_integer(unsigned(rs2_addr)));
  	end if;
  end process regfile;
end architecture behaviour;