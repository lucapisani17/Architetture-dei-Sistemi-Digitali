library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cont_mod8 is
    port(
        clock, reset: in std_logic;
        count_in: in std_logic; --segnali di abilitazione per il contatore
        count: out std_logic_vector(2 downto 0) --uscita 3 bit che rappresenta il valore del contatore
    );
end cont_mod8;

architecture Behavioral of cont_mod8 is

    signal c: std_logic_vector(2 downto 0) := (others => '0'); -- Il segnale interno 'c' mantiene il valore corrente del conteggio, inizializzato a 0
    
begin
        CM8: process(clock)
        begin
            if(clock'event and clock='1') then -- Controlla il fronte di salita del clock
                
                if(reset='1') then -- Controlla se il segnale di reset è attivo
                    c <= (others => '0'); -- Resetta il valore del contatore a 0
                else
                    if(count_in = '1') then -- Se il segnale di abilitazione è attivo
                        c <= std_logic_vector(unsigned(c) + 1); -- Incrementa il valore del contatore
                        -- La conversione da 'std_logic_vector' a 'unsigned' è necessaria per eseguire operazioni aritmetiche
                    end if;
                end if;
            end if;
        end process;
        
        -- Assegnazione dell'uscita: Il segnale interno 'c' è continuamente assegnato all'uscita 'count'.
        count <= c;

end Behavioral;
