library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity acc_z_reg is
    Port ( clk    : in  STD_LOGIC;
           reset  : in  STD_LOGIC;
           acc_we : in  STD_LOGIC;
           z_we   : in  STD_LOGIC;
           d      : in  STD_LOGIC_VECTOR (7 downto 0);
           acc    : out STD_LOGIC_VECTOR (7 downto 0);
           z      : out STD_LOGIC);
end acc_z_reg;

architecture Behavioral of acc_z_reg is
    signal acc_i : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal z_i   : STD_LOGIC := '1';
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                acc_i <= (others => '0');
                z_i   <= '1';
            else
                if acc_we = '1' then
                    acc_i <= d;
                end if;
                if z_we = '1' then
                    if d = "00000000" then
                        z_i <= '1';
                    else
                        z_i <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process;
    acc <= acc_i;
    z   <= z_i;
end Behavioral;
