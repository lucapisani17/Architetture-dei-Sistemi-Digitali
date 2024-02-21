library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BitAccumulator is
    port (
        clk          : in  std_logic;
        reset        : in  std_logic;
        input_bit    : in  std_logic;
        output_4bit  : out std_logic_vector(3 downto 0);
        accumula: in std_logic;
        output_valid : out std_logic
    );
end entity BitAccumulator;

architecture Behavioral of BitAccumulator is
    signal bits_received : std_logic_vector(3 downto 0); -- Memorizza i bit ricevuti
    signal string_index  : natural := 0;                -- Indice della posizione corrente nella stringa
begin
    process(clk, reset)
    begin
        if reset = '1' then
            -- Azzera tutti i segnali quando il segnale di reset è attivo
            bits_received <= (others => '0');
            string_index  <= 0;
            output_valid  <= '0';
        elsif rising_edge(clk) then
            if accumula='1' then
            -- Memorizza il bit ricevuto nella stringa
                if string_index = 4 then
                    output_4bit <= bits_received;
                    output_valid <= '1';
                    -- Azzera l'indice della stringa per la prossima ricezione
                    string_index <= 0;
                else
                    bits_received(string_index) <= input_bit;
                    string_index <= string_index + 1;
                end if;
            else
                string_index <=string_index;
        end if;
        end if;
    end process;

end architecture Behavioral;
