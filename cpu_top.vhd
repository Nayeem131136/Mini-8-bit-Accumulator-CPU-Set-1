library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_top is
    Port ( CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           Q     : out STD_LOGIC_VECTOR (7 downto 0);
           Z     : out STD_LOGIC;
           PC    : out STD_LOGIC_VECTOR (3 downto 0));
end cpu_top;

architecture Structural of cpu_top is
    signal pc_s    : STD_LOGIC_VECTOR (3 downto 0);
    signal instr   : STD_LOGIC_VECTOR (11 downto 0);
    signal alu_op  : STD_LOGIC_VECTOR (2 downto 0);
    signal acc_we  : STD_LOGIC;
    signal z_we    : STD_LOGIC;
    signal acc_s   : STD_LOGIC_VECTOR (7 downto 0);
    signal alu_res : STD_LOGIC_VECTOR (7 downto 0);
    signal z_s     : STD_LOGIC;
begin
    U_PC : entity work.program_counter
        port map (clk => CLK, reset => RESET, q => pc_s);

    U_ROM : entity work.program_rom
        port map (addr => pc_s, data => instr);

    U_CU : entity work.control_unit
        port map (opcode => instr(11 downto 8),
                  alu_op => alu_op,
                  acc_we => acc_we,
                  z_we   => z_we);

    U_ALU : entity work.alu
        port map (a      => acc_s,
                  b      => instr(7 downto 0),
                  op     => alu_op,
                  result => alu_res);

    U_REG : entity work.acc_z_reg
        port map (clk    => CLK,
                  reset  => RESET,
                  acc_we => acc_we,
                  z_we   => z_we,
                  d      => alu_res,
                  acc    => acc_s,
                  z      => z_s);

    Q  <= acc_s;
    Z  <= z_s;
    PC <= pc_s;
end Structural;
