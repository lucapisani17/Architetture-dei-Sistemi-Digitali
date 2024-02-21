library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
    generic (
        N: integer := 4 -- Numero di bit del registro
    );
    port (
        clk: in std_logic;    
        reset: in std_logic;
        load: in std_logic;
        data_in: in std_logic_vector(N-1 downto 0);
        data_out: out std_logic
    );
end shift_register;

architecture Behavioral of shift_register is
    signal temp_data: std_logic_vector(N-1 downto 0);
begin
    proc: process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                temp_data <= (others => '0');
            elsif load = '1' then
                temp_data <= data_in & temp_data(N-2 downto 0);
            else
                temp_data <= temp_data(N-2 downto 0) & '0';
            end if;
        end if;
    end process;

    data_out <= temp_data(N-1);
end Behavioral;
