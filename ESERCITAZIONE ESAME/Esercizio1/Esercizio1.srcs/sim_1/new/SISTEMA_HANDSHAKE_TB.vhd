library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SISTEMA_HANDSHAKE_TB is
end SISTEMA_HANDSHAKE_TB;

architecture testbench of SISTEMA_HANDSHAKE_TB is
    -- Dichiarazione dei segnali di ingresso
    signal clk_tb   : std_logic := '0';
    signal rst_tb   : std_logic := '0';
    signal start_tb : std_logic := '0';

    -- Dichiarazione dei segnali interni
    signal ack_tb         : std_logic;
    signal strobe_tb      : std_logic;
    signal dataC_tb       : std_logic_vector(7 downto 0);
    signal dataX_tb       : std_logic_vector(3 downto 0);

begin
    -- Collegamento dell'unità sotto test
    dut: entity work.SISTEMA_HANDSHAKE
        port map(
            clk   => clk_tb,
            rst   => rst_tb,
            start => start_tb
        );

    -- Processo di clock
    clk_process: process
    begin
        while now < 100 ns loop
            clk_tb <= not clk_tb;  -- Generazione del segnale di clock
            wait for 10 ns;         -- Attesa di 10 ns per il periodo di clock
        end loop;
        wait;  -- Attesa infinita
    end process;

    -- Processo di stimolazione
    stim_process: process
    begin
        -- Attendi 20 ns per il reset
        wait for 20 ns;
        rst_tb <= '1';

        -- Attendi 10 ns e abbassa il segnale di reset
        wait for 10 ns;
        rst_tb <= '0';

        -- Attendi 10 ns e porta il segnale di start a '1'
        wait for 10 ns;
        start_tb <= '1';

       
        wait;
    end process;

end testbench;
