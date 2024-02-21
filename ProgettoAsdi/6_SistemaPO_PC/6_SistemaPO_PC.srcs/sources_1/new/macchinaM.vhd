library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity macchinaM is
    port(
        data_in : in  STD_LOGIC_VECTOR (7 downto 0); -- Stringa di 8 bit in ingresso
        data_out : out  STD_LOGIC_VECTOR (3 downto 0) -- Stringa di 4 bit in uscita
    );
end macchinaM;

architecture Dataflow of macchinaM is

begin
        -- Effettua il negato bit a bit della stringa di input
        -- e applica uno shift right di 4 posizioni
        data_out <= not data_in(7 downto 4);

end Dataflow;
