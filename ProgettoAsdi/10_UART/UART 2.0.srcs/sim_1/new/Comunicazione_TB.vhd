library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comunicazione_Seriale_TB is
end Comunicazione_Seriale_TB;

architecture Behavioral of Comunicazione_Seriale_TB is

    COMPONENT Comunicazione_Seriale
        PORT(
            clk     : IN  std_logic;
            reset   : IN  std_logic;
            start   : IN  std_logic
        );
    END COMPONENT;
     -- Inputs
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '0';
    signal start    : std_logic := '0';
   
    constant CLK_period : time := 5 ps;
   

BEGIN

    uut: Comunicazione_Seriale
        PORT MAP (
            clk     => clk,
            reset   => reset,
            start   => start
        );

    -- Clock process definitions
    CLK_process : process
    begin
        while true loop
            clk <= '0';
            wait for CLK_period/2;
            clk <= '1';
            wait for CLK_period/2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset
        reset <= '1';
        wait for CLK_PERIOD;
        reset <= '0';

        -- Start
        wait for 5*CLK_PERIOD;
        start <= '1';
        wait for 5*CLK_PERIOD;
        wait;

    end process;

END Behavioral;
