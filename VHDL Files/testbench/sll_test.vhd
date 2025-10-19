library ieee;
use ieee.std_logic_1164.all;

entity tb_SLL_CIRC is
end tb_SLL_CIRC;

architecture testbench of tb_SLL_CIRC is

    component SLL_CIRC
        port (clk : in std_logic;
              rs1 : in std_logic_vector (31 downto 0);
              rs2 : in std_logic_vector (31 downto 0);
              rd  : out std_logic_vector (31 downto 0));
    end component;

    signal clk : std_logic;
    signal rs1 : std_logic_vector (31 downto 0);
    signal rs2 : std_logic_vector (31 downto 0);
    signal rd  : std_logic_vector (31 downto 0);

begin

    dut : SLL_CIRC
    port map (clk => clk,
              rs1 => rs1,
              rs2 => rs2,
              rd  => rd);

    stimuli : process
    begin
    	rs1 <= "00000000000000001001100110011001";
		rs2 <= "00000000000000000000000000010000";
        wait for 1 ns;
        assert(rd="10011001100110010000000000000000") report ("Test Failed.") severity error;
        rs1 <= "00000000000000000000000000000000";
        rs2 <= "00000000000000000000000000000000";
        
        assert false report ("Test Finished") severity note;
        wait;
        
    end process;

end testbench;