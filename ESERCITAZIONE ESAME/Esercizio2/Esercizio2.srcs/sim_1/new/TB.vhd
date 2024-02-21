library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SISTEMA_HANDSHAKE_tb is
end SISTEMA_HANDSHAKE_tb;

architecture Behavioral of SISTEMA_HANDSHAKE_tb is

    signal start_tb: std_logic := '0';
    signal clk_tb: std_logic := '0';
    signal rst_tb: std_logic := '0';

begin

    -- Instantiate the unit under test (UUT)
    UUT: entity work.SISTEMA_HANDSHAKE
        port map (
            start => start_tb,
            clk => clk_tb,
            rst => rst_tb
        );

    -- Clock process
    process
    begin
        clk_tb <= '0';
        wait for 5 ns;
        clk_tb <= '1';
        wait for 5 ns;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset
        rst_tb <= '1';
        wait for 10 ns;
        rst_tb <= '0';
        
        -- Wait some time before starting
        wait for 20 ns;
        
        -- Start signal goes high
        start_tb <= '1';
        wait for 10 ns;
        
        -- Add more stimuli as needed
        
        wait;
    end process;

end Behavioral;
