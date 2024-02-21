library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
    generic(
        N: integer := 8 -- Numero di bit del registro
    );
    port(
        clk: in std_logic;    
        reset: in std_logic;
        load: in std_logic;
        data_in: in std_logic_vector(N-1 downto 0);
        sel: in std_logic_vector(1 downto 0); -- Segnale di selezione per lo shift
        data_out: out std_logic_vector(N-1 downto 0)
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
            else
                if load='1' then
                    temp_data <= data_in;
                else
                    case sel is
                        when "00" => -- Shift a sinistra di una posizione
                            temp_data <= temp_data(N-2 downto 0) & '0';
                        when "01" => -- Shift a destra di una posizione
                            temp_data <= '0' & temp_data(N-1 downto 1);
                        when "10" => -- Shift a sinistra di due posizioni
                            temp_data <= temp_data(N-3 downto 0) & "00";
                        when "11" => -- Shift a destra di due posizioni
                            temp_data <= "00" & temp_data(N-1 downto 2);
                        when others =>
                            temp_data <= temp_data; -- Nessun cambiamento
                    end case;
                end if;
            end if;
        end if;
    end process;

    data_out <= temp_data;
    
end Behavioral;
