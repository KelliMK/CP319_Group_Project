library IEEE;
use IEEE.std_logic_1164.all;

entity tb_LUI_CIRC is
end tb_LUI_CIRC;

architecture testbench of tb_LUI_CIRC is

    component LUI_CIRC
        port (clk     : in std_logic;
              inst_in : in std_logic_vector (31 downto 0);
              rd      : out std_logic_vector (31 downto 0));
    end component;

    signal clk     : std_logic;
    signal inst_in : std_logic_vector (31 downto 0);
    signal rd      : std_logic_vector (31 downto 0);

begin

    dut : LUI_CIRC
    port map (clk     => clk,
              inst_in => inst_in,
              rd      => rd);

    stimuli : process
    begin
    	--! zeros test
        inst_in <= "00000000000000000000000000000000";
        wait for 1 ns;
        assert(rd="00000000000000000000000000000000") report "Failed Zeroes Test" severity note;
        
        inst_in <= "11111111111111111111111111111111";
        wait for 1 ns;
        assert(rd="11111111111111111111000000000000") report "Failed Ones Test" severity note;
        
        inst_in <= "01010101010101010101010101010101";
        wait for 1 ns;
        assert(rd="01010101010101010101000000000000") report "Failed Fives Test" severity note;
        
        inst_in <= "10101010101010101010101010101010";
        wait for 1 ns;
        assert(rd="10101010101010101010000000000000") report "Failed 'A's Test" severity note;
        
        inst_in <= "00000000000000000000000000000000";
        assert false report "Tests done." severity note;
        wait;
        
    end process;

end testbench;