library IEEE;
use IEEE.std_logic_1164.all;

entity tb_BLT_CIRC is
end tb_BLT_CIRC;

architecture testbench of tb_BLT_CIRC is

    component BLT_CIRC
        port (
          clk     : in std_logic;
          pc_in   : in std_logic_vector (31 downto 0);
          inst_in : in std_logic_vector (31 downto 0);
          rs1     : in std_logic_vector (31 downto 0);
          rs2     : in std_logic_vector (31 downto 0);
          pc_out  : out std_logic_vector (31 downto 0)
        );
    end component;

    signal clk     : std_logic;
    signal pc_in   : std_logic_vector (31 downto 0);
    signal inst_in : std_logic_vector (31 downto 0);
    signal rs1     : std_logic_vector (31 downto 0);
    signal rs2     : std_logic_vector (31 downto 0);
    signal pc_out  : std_logic_vector (31 downto 0);

begin

    dut : BLT_CIRC
    port map (
      clk     => clk,
      pc_in   => pc_in,
      inst_in => inst_in,
      rs1     => rs1,
      rs2     => rs2,
      pc_out  => pc_out
    );

    stimuli : process
    begin
      pc_in <= "00000000000000000000000000000000";
      inst_in <= "01000000001000001000000011100011"; --! offset is "00000000 00000000 00001100 00000000"
      --! equality test
      rs1 <= "00000000001000000000001110000000";
      rs2 <= "00000000001000000000001110000000";
      wait for 1 ns;
      assert(pc_out="00000000000000000000000000100000") report "Failed test 1" severity note;
    
      --! greater than test
      rs1 <= "01010101010101010101010101010101";
      rs2 <= "00010101010101010101000000000000";
      wait for 1 ns;
      assert(pc_out="00000000000000000000000000100000") report "Failed test 2" severity note;
        
      --! less than test
      rs1 <= "00000000001000000000000000000000";
      rs2 <= "01000000001000000000000000000000";
      wait for 1 ns;
      assert(pc_out="00000000000000000000110000000000") report "Failed test 3" severity note;
    
      rs1 <= "00000000000000000000000000000000";
      rs2 <= "00000000000000000000000000000000";
    
     assert false report "Tests done." severity note;
     wait;
    end process;

end testbench;