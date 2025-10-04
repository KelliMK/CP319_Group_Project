-- instruction memory entity
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- --ENTITIES--
ENTITY INSTRUCTION_MEMORY IS
  PORT(
  	-- memory address size
  	MEM_SIZE : IN STD_LOGIC_VECTOR(9 downto 0);

  	-- inputs
  	CLK : IN STD_LOGIC;
  	ADDR : IN STD_LOGIC;

  	-- output
  	REGOUT_IM : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
  );

