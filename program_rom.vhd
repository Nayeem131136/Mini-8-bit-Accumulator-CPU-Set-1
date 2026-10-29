library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity program_rom is
    Port ( addr : in  STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (11 downto 0));
end program_rom;

architecture Behavioral of program_rom is
    type rom_t is array (0 to 15) of STD_LOGIC_VECTOR (11 downto 0);
    constant ROM : rom_t := (
        0 => x"13C",
        1 => x"20F",
        2 => x"30B",
        3 => x"4F0",
        4 => x"50A",
        5 => x"34A",
        6 => x"301",
        others => x"000"
    );
begin
    data <= ROM(to_integer(unsigned(addr)));
end Behavioral;
