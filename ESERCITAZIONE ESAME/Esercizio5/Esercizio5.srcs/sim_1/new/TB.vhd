library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SISTEMA_HANDSHAKE_TB is
end entity;

architecture testbench of SISTEMA_HANDSHAKE_TB is
    -- Dichiarazione dei segnali di input
    signal clk_tb : std_logic := '0';
    signal rst_tb : std_logic := '0';
    signal start_tb : std_logic := '0';

begin
    -- Istanzia il componente SISTEMA_HANDSHAKE
    dut : entity work.SISTEMA_HANDSHAKE
        port map (
            clk => clk_tb,
            rst => rst_tb,
            start => start_tb
        );

    -- Processo per generare il clock
    process
    begin
        while now < 1000 ns loop
            clk_tb <= not clk_tb; -- Inverte il segnale del clock
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Processo per stimolare gli input
    process
    begin
        rst_tb <= '1'; -- Attiva il segnale di reset
        wait for 10 ns;
        rst_tb <= '0'; -- Disattiva il segnale di reset
        wait for 20 ns;
        start_tb <= '1'; -- Attiva il segnale di start
--        wait for 10 ns;
--        start_tb <= '0'; -- Disattiva il segnale di start
        wait;
    end process;

end architecture testbench;
