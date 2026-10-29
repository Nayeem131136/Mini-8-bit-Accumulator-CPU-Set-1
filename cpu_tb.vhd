library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cpu_tb is
end cpu_tb;

architecture Behavioral of cpu_tb is
    signal CLK   : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '1';
    signal Q     : STD_LOGIC_VECTOR (7 downto 0);
    signal Z     : STD_LOGIC;
    signal PC    : STD_LOGIC_VECTOR (3 downto 0);
    signal done  : boolean := false;

    type int_array is array (0 to 7) of integer;
    constant EXP_ACC : int_array := (0, 60, 75, 64, 64, 74, 0, 255);
    constant EXP_Z   : int_array := (1, 0, 0, 0, 0, 0, 1, 0);
    constant EXP_PC  : int_array := (0, 1, 2, 3, 4, 5, 6, 7);
begin
    UUT: entity work.cpu_top
        port map (CLK => CLK, RESET => RESET,
                  Q => Q, Z => Z, PC => PC);

    clk_proc: process
    begin
        while not done loop
            CLK <= '0'; wait for 5 ns;
            CLK <= '1'; wait for 5 ns;
        end loop;
        wait;
    end process;

    stim_proc: process
        variable ok : boolean := true;
    begin
        RESET <= '1';
        for c in 0 to 7 loop
            wait until rising_edge(CLK);
            wait for 1 ns;
            if c = 0 then RESET <= '0'; end if;
            if not (to_integer(unsigned(Q)) = EXP_ACC(c) and
                    ((Z = '1' and EXP_Z(c) = 1) or
                     (Z = '0' and EXP_Z(c) = 0)) and
                    to_integer(unsigned(PC)) = EXP_PC(c)) then
                ok := false;
                report "MISMATCH at cycle " & integer'image(c)
                    severity error;
            end if;
        end loop;
        if ok then
            report "PASS: all cycles match Appendix B"
                severity note;
        else
            report "FAIL: see mismatches above" severity failure;
        end if;
        done <= true;
        wait;
    end process;
end Behavioral;
