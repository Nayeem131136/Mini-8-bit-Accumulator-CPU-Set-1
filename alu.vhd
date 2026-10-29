library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    Port ( a      : in  STD_LOGIC_VECTOR (7 downto 0);
           b      : in  STD_LOGIC_VECTOR (7 downto 0);
           op     : in  STD_LOGIC_VECTOR (2 downto 0);
           result : out STD_LOGIC_VECTOR (7 downto 0));
end alu;

architecture Behavioral of alu is
begin
    process (a, b, op)
    begin
        case op is
            when "000"  => result <= b;
            when "001"  =>
                result <= std_logic_vector(unsigned(a) + unsigned(b));
            when "010"  =>
                result <= std_logic_vector(unsigned(a) - unsigned(b));
            when "011"  => result <= a and b;
            when "100"  => result <= a or b;
            when others => result <= a;
        end case;
    end process;
end Behavioral;
