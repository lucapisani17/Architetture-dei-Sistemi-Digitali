----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.01.2024 13:37:06
-- Design Name: 
-- Module Name: rete_interconnessione - Structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Definizione dell'entità rete_interconnessione
entity rete_interconnessione is
    Port( 
        A: in std_logic_vector(15 downto 0); -- Vettore di ingresso di 16 bit
        S: in std_logic_vector(3 downto 0);  -- Vettore di selezione di 4 bit per il Mux
        L: in std_logic_vector(1 downto 0);  -- Vettore di selezione di 2 bit per il Demux
        Y: out std_logic_vector(3 downto 0)  -- Vettore di uscita di 4 bit dal Demux
    );
end rete_interconnessione;

architecture Structural of rete_interconnessione is
    
    signal U: std_logic;  -- Segnale intermedio tra Mux e Demux

    -- Dichiarazione del componente mux_16_1
    component mux_16_1 is
        port(
            B: in std_logic_vector(15 downto 0); -- Ingresso di 16 bit per il Mux
            S: in std_logic_vector(3 downto 0);  -- Selezione di 4 bit per il Mux
            Y: out std_logic                     -- Uscita singola dal Mux
        );
    end component;
    
    -- Dichiarazione del componente demux_1_4
    component demux_1_4 is
        port(
            A: in std_logic;                    -- Ingresso singolo per il Demux
            S: in std_logic_vector(1 downto 0); -- Selezione di 2 bit per il Demux
            Y: out std_logic_vector(3 downto 0) -- Uscita di 4 bit dal Demux
        );
    end component;

begin
    -- Istanziamento del Mux
    Mux: mux_16_1 port map(
        B => A,  -- Collegamento ingresso A al Mux
        S => S,  -- Collegamento selezione S al Mux
        Y => U   -- Collegamento uscita Mux al segnale intermedio U
        );
    
    -- Istanziamento del Demux
    Demux: demux_1_4 port map(
        A => U,  -- Collegamento segnale intermedio U al Demux
        S => L,  -- Collegamento selezione L al Demux
        Y => Y   -- Collegamento uscita Demux al vettore di uscita Y
        );

end Structural;
