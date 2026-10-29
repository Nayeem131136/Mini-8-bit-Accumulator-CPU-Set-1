library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port ( opcode : in  STD_LOGIC_VECTOR (3 downto 0);
           alu_op : out STD_LOGIC_VECTOR (2 downto 0);
           acc_we : out STD_LOGIC;
           z_we   : out STD_LOGIC);
end control_unit;

architecture Behavioral of control_unit is
begin
    process (opcode)
    begin
        alu_op <= "000";  acc_we <= '0';  z_we <= '0';
        case opcode is
            when "0001" =>
                alu_op <= "000"; acc_we <= '1'; z_we <= '1';
            when "0010" =>
                alu_op <= "001"; acc_we <= '1'; z_we <= '1';
            when "0011" =>
                alu_op <= "010"; acc_we <= '1'; z_we <= '1';
            when "0100" =>
                alu_op <= "011"; acc_we <= '1'; z_we <= '1';
            when "0101" =>
                alu_op <= "100"; acc_we <= '1'; z_we <= '1';
            when others => null;
        end case;
    end process;
end Behavioral;
