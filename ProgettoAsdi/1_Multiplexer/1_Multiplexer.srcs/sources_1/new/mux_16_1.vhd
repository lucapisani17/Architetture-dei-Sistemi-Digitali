----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.01.2024 11:00:33
-- Design Name: 
-- Module Name: mux_16_1 - Structural
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

entity mux_16_1 is
    port(
        B: in std_logic_vector(15 downto 0); --vettore di ingressi in input (dim=16)
        S: in std_logic_vector(3 downto 0); --vettore di ingressi di selezione (dim=4)
        Y: out std_logic --una uscita
    );
end mux_16_1;

--approccio per composizione
architecture Structural of mux_16_1 is

    component mux_4_1 is
        port(
            A: in std_logic_vector(3 downto 0); --4 ingressi dato
            S: in std_logic_vector(1 downto 0); --2 ingressi di selezione
            Y: out std_logic --1 uscita
        );
    end component;    
    
    signal U: std_logic_vector(3 downto 0); --vettore per memorizzare le uscite dei mux di primo livello

begin
    --Genero i mux_4_1
    Mux_0_4: FOR i IN 0 TO 4 GENERATE 
        --Multiplexer di primo livello
        M_0_3: IF i < 4 GENERATE --Genero i primi 4 mux_4_1
            M: mux_4_1 port map(
                A => B(i*4+3 downto i*4), --ingressi 3,2,1,0 - 7,6,5,4 - 11,10,9,8 - 15,14,13,12
                S => S(1 downto 0), --intervengono solo i primi 2 bit di selezione
                Y => U(i) --le uscite dei multiplexer di primo livello vengono memorizzate in U
            );
        END GENERATE;
        
        M_4: IF i = 4 GENERATE --Genero l'ultimo mux_4_1 (di secondo livello)
            M: mux_4_1 port map(
                A => U, --prende in ingresso le uscite dei multiplexer di primo livello
                S => S(3 downto 2), --ultimi 2 bit di selezione
                Y => Y --uscita del mux_16_1
            );
        END GENERATE;
    END GENERATE;

end Structural;
