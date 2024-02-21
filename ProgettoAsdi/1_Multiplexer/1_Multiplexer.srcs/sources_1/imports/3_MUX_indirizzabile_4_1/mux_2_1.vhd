--MUX INDIRIZZABILE 2:1
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Entity
entity mux_2_1 is
    port(
        A : in std_logic_vector(1 downto 0); --2 ingressi
        S : in std_logic; --selezione
        Y : out std_logic --uscita
    );
end mux_2_1;

--Architettura livello Dataflow
--qui è come se stessi specificando la tabella di verità  della funzione y
architecture dataflow of mux_2_1 is

    begin
        Y <= ((A(0) AND (NOT S)) OR (A(1) AND S)); --assegnazione concorrente

end dataflow;






