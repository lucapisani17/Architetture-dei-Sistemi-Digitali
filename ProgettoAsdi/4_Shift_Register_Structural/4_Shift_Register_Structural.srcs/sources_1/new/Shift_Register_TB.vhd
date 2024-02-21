library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shift_Register_TB is
end Shift_Register_TB;

architecture Behavioral of Shift_Register_TB is

    COMPONENT shift_register
        GENERIC(
            N : integer := 4
        );
        PORT(
            clk     : IN  std_logic;
            reset   : IN  std_logic;
            load    : IN  std_logic;
            input   : IN  std_logic_vector(N-1 downto 0);
            sel     : IN  std_logic_vector(1 downto 0);
            output  : OUT std_logic_vector(N-1 downto 0)
        );
    END COMPONENT;

    -- Inputs
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '0';
    signal load    : std_logic := '0';
    signal data_in : std_logic_vector(3 downto 0) := (others => '0');
    signal sel     : std_logic_vector(1 downto 0) := "00";

    -- Output
    signal data_out: std_logic_vector(3 downto 0);
    
    constant CLK_period : time := 10 ns;

BEGIN

    uut: shift_register
        GENERIC MAP (
            N => 4
        )
        PORT MAP (
            clk     => clk,
            reset   => reset,
            load    => load,
            input   => data_in,
            sel     => sel,
            output  => data_out
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
        wait for CLK_period;
        reset <= '0';

        -- Load dati
        load <= '1';
        data_in <= "1010";
        wait for CLK_period;
        load <= '0';

        -- Shift Left di 1
        sel <= "00";
        wait for CLK_period;

        -- Shift Right di 1
        sel <= "01";
        wait for CLK_period;

        -- Shift Left di 2
        sel <= "10";
        wait for CLK_period;

        -- Shift Right di 2
        sel <= "11";
        wait for CLK_period;

        wait;
    end process;

END Behavioral;
