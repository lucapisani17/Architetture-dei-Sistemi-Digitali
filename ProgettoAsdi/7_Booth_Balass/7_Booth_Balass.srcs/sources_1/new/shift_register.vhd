library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

---shift register che contiene inizialmente una stringa di 8 zeri (in A), il moltiplicatore X (in Q) e un bit 0 in Q[-1]
---al termine dell'operazione di moltiplicazione conterrà il risultato A+Q[7:0]

entity shift_register is
    
    port(
        A_in: in std_logic_vector(7 downto 0);
        Q_in: in std_logic_vector(7 downto 0);
        clock, reset, loadQ, loadA , shift: in std_logic; -- Segnali di clock, reset, caricamento e shift.
        parallel_out: out std_logic_vector(16 downto 0) -- Uscita parallela del valore corrente dello shift register.
    );
    
end shift_register;

architecture Behavioral of shift_register is

    signal temp: std_logic_vector(16 downto 0); -- Segnale interno che mantiene lo stato dello shift register

begin

    SR: process(clock)
        begin
            if(clock'event and clock='1') then -- Controlla il fronte di salita del segnale di clock.
                if(reset='1') then
                    temp <= (others => '0'); -- Reset: se il segnale di reset è attivo, azzera il registro.
                else
                    if(loadQ='1') then 
                        temp(8 downto 1) <= Q_in; -- Caricamento: se il segnale di load è attivo, carica il valore di parallel_in.
                    elsif(shift='1') then 
                        temp(15 downto 0) <= temp(16 downto 1); -- Shift: se il segnale di shift è attivo, sposta tutti i bit di una posizione.
                        temp(16) <= temp(15); -- Il nuovo bit più significativo è l'ingresso seriale.
                    elsif(loadA='1') then
                        temp(16 downto 9) <= A_in;
                    end if;
                end if;
            end if;
    end process;
    
    parallel_out <= temp; -- Assegna il valore corrente del segnale interno temp all'uscita parallela

end Behavioral;
