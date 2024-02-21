library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
    generic(
        modulo: integer := 8;
        n: integer := 3
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        load: in std_logic;
        input: in std_logic_vector(n-1 downto 0);
        y: out std_logic_vector(n-1 downto 0);
        countMax: out std_logic
    );
end counter;

architecture Behavioral of counter is

    signal temp_y: std_logic_vector(n-1 downto 0) := (others => '0');
    signal temp_count: std_logic := '0';

begin
    
    y <= temp_y;
    
    logica_conteggio: process(clk)
    begin
        if falling_edge(clk) then
            if (reset = '1') then
                temp_y <= (others => '0');
            elsif (load = '1') then
                temp_y <= input;
            elsif (enable = '1') then
                --vediamo il conteggio è arrivato al massimo valore (modulo-1)
                if (temp_y = std_logic_vector(TO_UNSIGNED(modulo-1,n))) then
                    temp_y <= (others => '0');
                else
                    temp_y <= std_logic_vector(unsigned(temp_y) + 1);
                end if;
            end if;
       end if;
     end process;
     
     proc_count_max: process(clk)
     begin
        if rising_edge(clk) then
            if (reset = '1') then
                temp_count <= '0';
            elsif (temp_y = std_logic_vector(TO_UNSIGNED(modulo-1,n))) then
                temp_count <= '1';
            else
                temp_count <= '0';
            end if;
        end if;
     end process;
     
     countMax <= temp_count;

end Behavioral;
