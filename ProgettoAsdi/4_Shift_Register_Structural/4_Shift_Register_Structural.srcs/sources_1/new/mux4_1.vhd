library IEEE;
use IEEE.std_logic_1164.all;

-- Definizione dell'entity per il multiplexer 4:1.
-- Questo componente seleziona uno dei 4 ingressi (b0-b3) in base ai segnali di selezione (s0, s1).
entity mux_4_1 is
    port(
        A : in std_logic_vector(3 downto 0);
        S : in std_logic_vector(1 downto 0);
        Y : out std_logic
    );
end mux_4_1;

--Architettura structural utilizzando la composizione di 3 MUX 2:1

architecture structural of mux_4_1 is
    
    
    -- Definizione del componente interno mux_2_1.
    -- Questo componente è un multiplexer 2:1 che sarà usato per costruire il multiplexer 4:1.
    component mux_2_1
        port(
            A: in std_logic_vector(1 downto 0);
            S: in std_logic;
            Y : out std_logic
        );
    end component;
    
    -- Segnali interni per collegare i due livelli dei multiplexer 2:1
    signal U : std_logic_vector(1 downto 0); 

    begin
        MUX_0_2: FOR i IN 0 TO 2 GENERATE
            -- Primo stage di multiplexing: seleziona tra b0 e b1, o tra b2 e b3.
            M_0_1: IF i < 2 GENERATE
                M: mux_2_1 port map(
                    A => A(i*2+1 downto i*2),
                    S => S(0),
                    Y => U(i)
                );
           END GENERATE;
           
           M_2: IF i = 2 GENERATE
                M: mux_2_1 port map(
                    A => U,
                    S => S(1),
                    Y => Y
                );
          END GENERATE;
      END GENERATE;
end structural;