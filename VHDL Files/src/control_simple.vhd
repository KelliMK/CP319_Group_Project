library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity control_simple is
	PORT (
		I_clk : in std_logic;
		I_reset : in std_logic;
		O_state : out std_logic_vector(3 downto 0)
	);
end control_simple;

architecture SYNTH_control of control_simple is
	signal s_state: std_logic_vector(3 downto 0) := "0001";
begin
	process(I_clk)
	begin
		if rising_edge(I_clk) then
			if I_reset = '1' then
				s_state <= "0001";
			else
				case s_state is 
					when "0001" =>
						s_state <= "0010";
					when "0010" =>
						s_state <= "0100";
					when "0100" =>
						s_state <= "1000";
					when "1000" =>
						s_state <= "0001";
					when others =>
						s_state <= "0001";
				end case;
			end if;
		end if;
	end process;
	O_state <= s_state;
	
end architecture SYNTH_control;