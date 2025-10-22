LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity alu is 
port(
	I_clk : in std_logic;	--! clock bit
	I_en : in std_logic; --! enable bit
	I_data1 : in std_logic_vector(31 downto 0); --! rs1 data
	I_data2 : in std_logic_vector(31 downto 0); --! rs2 data
	I_dataDwe : in std_logic; --! rd write enable bit
	I_aluop : in std_logic_vector(5 downto 0); --! alu op code
	I_PC : in std_logic_vector(31 downto 0); --! Program counter
	I_dataIMM : in std_logic_vector(31 downto 0); --! immediate
	O_dataResult : out std_logic_vector(31 downto 0); --! result of ALU calculation
	O_dataWriteToReg : out std_logic; --! we writing to a fookin register?
	O_takeBranch : out std_logic --! do I need to explain this one?
);
end alu;

architecture SYNTH_alu of alu is
	--! add an extra bit for overflow operations, I guess
	signal s_result: std_logic_vector(32 downto 0) := (others => '0');
	signal s_takeBranch: std_logic := '0';
begin
	process(I_clk, I_en)
	begin
		if rising_edge(I_clk) and (I_en = '1') then
			O_dataWriteToReg <= I_dataDwe;
			case I_aluop(5 downto 0) is 
				--! I know I should have started at 0 but RV32I only has 52 
				--! instructions in its expanded instruction set, so it'll fit 
				when "000001" => --! LUI
					s_result(31 downto 0) <= I_dataIMM;
					s_result(32) <= '0';
					s_takeBranch <= '0';
				when "000010" => --! AUIPC
					s_result <= std_logic_vector(unsigned('0' & I_dataIMM) + unsigned('0' & I_PC));
					s_takeBranch <= '0';
				when "000100" => --! BEQ
					if (signed(I_data1) = signed(I_data2)) then
						s_result(31 downto 0) <= std_logic_vector(unsigned(I_PC) + unsigned(I_dataIMM));
						s_takeBranch <= '1';
					else
						s_takeBranch <= '0';
					end if;
				when "000101" => --! BNE
					if (signed(I_data1) /= signed(I_data2)) then
						s_result(31 downto 0) <= std_logic_vector(unsigned(I_PC) + unsigned(I_dataIMM));
						s_takeBranch <= '1';
					else
						s_takeBranch <= '0';
					end if;
				when "000110" => --! BLT (yum)
					if (signed(I_data1) < signed(I_data2)) then
						s_result(31 downto 0) <= std_logic_vector(unsigned(I_PC) + unsigned(I_dataIMM));
						s_takeBranch <= '1';
					else
						s_takeBranch <= '0';
					end if;
				when "000111" => --! BGE
					if (signed(I_data1) >= signed(I_data2)) then
						s_result(31 downto 0) <= std_logic_vector(unsigned(I_PC) + unsigned(I_dataIMM));
						s_takeBranch <= '1';
					else
						s_takeBranch <= '0';
					end if;
				when "001101" => --! LW
					s_takeBranch <= '0';
				when "010000" => --! ADDI
					s_result <= std_logic_vector(unsigned('0' & I_dataIMM) + unsigned('0' & I_PC));
					s_takeBranch <= '0';
				when "010001" => --! SLTI
					if (signed(I_data1) < signed(I_dataIMM)) then
						s_result <= "000000000000000000000000000000001";
					else
						s_result <= "000000000000000000000000000000000";
					end if;
					s_takeBranch <= '0';
				when "010011" => --! XORI
					s_result(31 downto 0) <= I_data1 XOR I_dataIMM;
					s_takeBranch <= '0';
				when "010100" => --! ORI
					s_result(31 downto 0) <= I_data1 OR I_dataIMM;
					s_takeBranch <= '0';
				when "010101" => --! ANDI
					s_result(31 downto 0) <= I_data1 AND I_dataIMM;
					s_takeBranch <= '0';
				when "011000" => --! SW
					s_takeBranch <= '0';
				when "011100" => --! ADD 
					s_result(32 downto 0) <= std_logic_vector(unsigned('0' & I_data1) + unsigned( '0' & I_data2));
					s_takeBranch <= '0';
				when "011101" => --! SUB
					s_result(31 downto 0) <= std_logic_vector(signed(I_data1) - signed(I_data2));
					s_takeBranch <= '0';
				when "011110" => --! SLL
					s_result(31 downto 0) <= std_logic_vector(SHIFT_LEFT(unsigned(I_data1), to_integer(unsigned(I_data2(4 downto 0))))); 
					--! insane
					s_takeBranch <= '0';
				when "011111" => --! SLT
					if (signed(I_data1) < signed(I_data2)) then
						s_result <= "000000000000000000000000000000001";
					else
						s_result <= "000000000000000000000000000000000";
					end if;
					s_takeBranch <= '0';
				when "100000" => --! SLTU
					if (unsigned(I_data1) < unsigned(I_data2)) then
						s_result <= "000000000000000000000000000000001";
					else
						s_result <= "000000000000000000000000000000000";
					end if;
					s_takeBranch <= '0';
				when "100001" => --! XOR
					s_result(31 downto 0) <= I_data1 XOR I_data2;
					s_takeBranch <= '0';
				when "100010" => --! SRL
					s_result <= std_logic_vector('0' & (signed(I_data1) SRL to_integer(unsigned(I_data2(4 downto 0)))));
					s_takeBranch <= '0';
				when "100011" => --! SRA
					s_result <= std_logic_vector('0' & (signed(I_data1) SRA to_integer(unsigned(I_data2(4 downto 0)))));
					s_takeBranch <= '0';
				when "100100" => --! OR
					s_result(31 downto 0) <= I_data1 OR I_data2; 
					s_takeBranch <= '0';
				when "100101" => --! AND
					s_result(31 downto 0) <= I_data1 AND I_data2;
					s_takeBranch <= '0';
				when others =>
					s_result(31 downto 0) <= X"FFFFFFFC";
			end case;
		end if;
	end process;

	O_dataResult <= s_result(31 downto 0);
	O_takeBranch <= s_takeBranch;
end SYNTH_alu;