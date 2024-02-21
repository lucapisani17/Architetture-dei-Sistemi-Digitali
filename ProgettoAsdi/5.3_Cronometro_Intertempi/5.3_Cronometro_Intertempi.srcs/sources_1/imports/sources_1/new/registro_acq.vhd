library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registro_acq is
    generic(
        N: integer := 8 --dimensione del registro
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        load: in std_logic; --segnale di caricamento/scrittura
        data_in: in std_logic_vector(N-1 downto 0);
        data_out: out std_logic_vector(N-1 downto 0)
    );
end registro_acq;

architecture Behavioral of registro_acq is

    signal temp_data: std_logic_vector(N-1 downto 0);     

begin

    reg: process(clk) --process per aggiornare il registro
    begin
        if rising_edge(clk) then
            if(reset = '1') then
                temp_data <= (others => '0');
            elsif(load = '1') then
                temp_data <= data_in;
            end if;
        end if;
    end process;
    
    data_out <= temp_data;

end Behavioral;
