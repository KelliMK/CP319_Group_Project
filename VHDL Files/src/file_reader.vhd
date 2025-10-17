-- File Reader 
-- original boilerplate code found at
-- https://www.edaplayground.com/x/cqd

library ieee;
use ieee.std_logic_1164.all;

entity file_reader is
-- blank 
end file_reader;

architecture file_read_arch of file_reader is
	signal instruction : bit_vector(31 downto 0);
begin
	Stimulus: process
		use STD.TEXTIO.all;
		file F: text open READ_MODE is "machine_code.txt";
		variable L: line;
		variable inst_value: bit_vector(31 downto 0);
	begin
		while not ENDFILE(F) loop
			READLINE (F, L);
			READ (L, inst_value);
			wait for 1 ns;
			instruction <= inst_value;
		end loop;
		wait for 10 ns;
		wait;
	end process Stimulus;
end architecture file_read_arch;