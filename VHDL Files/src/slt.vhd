library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SLT is
Port (
    rs1 : in  STD_LOGIC_VECTOR(31 downto 0);
    rs2 : in  STD_LOGIC_VECTOR(31 downto 0);
    rd : out STD_LOGIC
);
end SLT;

architecture behavioural of SLT is
begin

process(rs1, rs2)
    variable A : signed(31 downto 0);
    variable B : signed(31 downto 0);
begin
    A := signed(rs1);
    B := signed(rs2);

    if A < B then
        rd <= '1';
    else
        rd <= '0';
    end if;
end process;

end behavioural;