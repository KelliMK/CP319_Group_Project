library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

package my_constants is 

--! Operation Codes
constant OP_ADD : std_logic_vector(5 downto 0) := "011100"; -- ADD
constant OP_ADDI : std_logic_vector(5 downto 0) := "010000"; -- ADDI
constant OP_AND : std_logic_vector(5 downto 0) := "100101"; -- AND
constant OP_ANDI : std_logic_vector(5 downto 0) := "010101"; -- ANDI
constant OP_AUIPC : std_logic_vector(5 downto 0) := "000010"; -- AUIPC
constant OP_BEQ : std_logic_vector(5 downto 0) := "000100"; -- BEQ
constant OP_BGE : std_logic_vector(5 downto 0) := "000111"; -- BGE
constant OP_BLT : std_logic_vector(5 downto 0) := "000110"; -- BLT
constant OP_BNE : std_logic_vector(5 downto 0) := "000101"; -- BNE
constant OP_LUI : std_logic_vector(5 downto 0) := "000001"; -- LUI
constant OP_LW : std_logic_vector(5 downto 0) := "001101"; -- LW
constant OP_OR : std_logic_vector(5 downto 0) := "100100"; -- OR
constant OP_ORI : std_logic_vector(5 downto 0) := "010100"; -- ORI
constant OP_SLL : std_logic_vector(5 downto 0) := "011110"; -- SLL
constant OP_SLT : std_logic_vector(5 downto 0) := "011111"; -- SLT
constant OP_SLTI : std_logic_vector(5 downto 0) := "010001"; -- SLTI
constant OP_SLTU : std_logic_vector(5 downto 0) := "100000"; -- SLTU
constant OP_SRA : std_logic_vector(5 downto 0) := "100011"; -- SRA
constant OP_SRL : std_logic_vector(5 downto 0) := "100010"; -- SRL
constant OP_SUB : std_logic_vector(5 downto 0) := "011101"; -- SUB
constant OP_SW : std_logic_vector(5 downto 0) := "011000"; -- SW
constant OP_XOR : std_logic_vector(5 downto 0) := "100001"; -- XOR
constant OP_XORI : std_logic_vector(5 downto 0) := "010011"; -- XORI

-- Program Counter opcodes
constant PC_OP_NOP: std_logic_vector(1 downto 0):= "00"; -- Halt and spin
constant PC_OP_INC: std_logic_vector(1 downto 0):= "01"; -- Regular Operation
constant PC_OP_ASSIGN: std_logic_vector(1 downto 0):= "10"; -- Assign new value to PC
constant PC_OP_RESET: std_logic_vector(1 downto 0):= "11"; -- reset PC back to Hx00000000

--! Operation Tests
--! for new tests, here's the template "XXXXX XX XXXXX XXXXX XXX XXXXX XXXXX 11"

-- adds register 8 and 9 and stores result in register 18
constant TEST_ADD : std_logic_vector(31 downto 0) := "00000000100001001000100100110011"; 

-- Adds three to the value in reg 18
constant TEST_ADDI : std_logic_vector(31 downto 0) := "00000000001110010000100100010011";

-- ANDs regs 8 and 9 and stores the result in reg 18
constant TEST_AND : std_logic_vector(31 downto 0) := "00000000100101000111100100110011";

-- ANDs reg 8 and -1 (signed) into reg 18
constant TEST_ANDI : std_logic_vector(31 downto 0) := "11111111111101000111100100010011";

-- Adds 4096 to the PC and stores the result in reg 19
constant TEST_AUIPC : std_logic_vector(31 downto 0) := "00000000000000000001100110010111";

-- Takes the branch (1000 + pc) if reg 8 == reg 9 
constant TEST_BEQ : std_logic_vector(31 downto 0) := "00000000100101000000010001100011";

-- Takes the branch (1000 + pc) if reg 8 >= reg 9
constant TEST_BGE : std_logic_vector(31 downto 0) := "00000000100101000101010001100011";

-- Takes the branch (1000 + pc) if reg 8 < reg 9 
constant TEST_BLT : std_logic_vector(31 downto 0) := "00000000100101000100010001100011";

-- Takes the branch (1000 + pc) if reg 8 != reg 9 
constant TEST_BNE : std_logic_vector(31 downto 0) := "00000000100101000001010001100011";

-- Saves 4096 to register 20
-- For other tests: "ZZZZZZZZZZZZZZZZZZZZ XXXXX 0110111"
-- - Z is the unsigned immediate to place in the rd
-- - X is the rd
constant TEST_LUI : std_logic_vector(31 downto 0) := "00000000000000000001101000110111";

-- Loads from memory address 0x0000 in reg 21
-- for other registers "ZZZZZZZZZZZZ YYYYY 010 XXXXX 0000011"
-- - X is destination register 
-- - Y is register to load memory location from 
-- - Z is memory location offset (sign extended)
constant TEST_LW21 : std_logic_vector(31 downto 0) := "00000000000000000010101010000011";

constant TEST_LW08 : std_logic_vector(31 downto 0) := "00000000000000000010010000000011";
constant TEST_LW09 : std_logic_vector(31 downto 0) := "00000000000000000010010010000011";

-- ORs regs 8 and 9 and stores the output in reg 18
constant TEST_OR : std_logic_vector(31 downto 0) := "00000000100101000110100100110011";

-- ORs reg 8 with "00000000000000000000011111111111" and stores result in reg 9
constant TEST_ORI : std_logic_vector(31 downto 0) := "01111111111101000110010010010011";

-- Shifts reg 9 by the bottom five bits of reg 8 and stores it in reg 18
constant TEST_SLL : std_logic_vector(31 downto 0) := "00000000100001001001100100110011";

-- Places 1 in reg 19 if reg 8 is less than reg 9
constant TEST_SLT : std_logic_vector(31 downto 0) := "00000000100101000010100110110011";

-- Places 1 in reg 20 if reg 8 is less than Dx14
constant TEST_SLTI : std_logic_vector(31 downto 0) := "00000000111001000010101000010011";

-- Places value in reg 8 into reg 21 if reg 8 is less than reg 9, unsigned
constant TEST_SLTU : std_logic_vector(31 downto 0) := "00000000100101000011101010110011";

-- Shifts reg 9 by the bottom five bits of reg 8 and stores it in reg 18
constant TEST_SRA : std_logic_vector(31 downto 0) := "01000000100101000101100100110011";

-- Shifts reg 9 by the bottom five bits of reg 8 and stores it in reg 18
constant TEST_SRL : std_logic_vector(31 downto 0) := "00000000100001001101100100110011";

-- subtracts reg 9 from reg 8 and stores it in reg 18
constant TEST_SUB : std_logic_vector(31 downto 0) := "01000000100101000000100100110011";

-- Store word
constant TEST_SW : std_logic_vector(31 downto 0) := "00000000100101000010000000100011";

-- XOR reg 8 and 9 and store it in reg 18
constant TEST_XOR : std_logic_vector(31 downto 0) := "00000000100101000100100100110011";

-- XOR reg 9 and "00000000000000000000011111111111" and store in reg 19
constant TEST_XORI : std_logic_vector(31 downto 0) := "01111111111110010100100110010011";

end my_constants;

package body my_constants is 

end my_constants;