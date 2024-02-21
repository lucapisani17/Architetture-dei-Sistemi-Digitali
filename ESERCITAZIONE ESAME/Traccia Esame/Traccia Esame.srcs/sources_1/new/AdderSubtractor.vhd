----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2024 15:59:00
-- Design Name: 
-- Module Name: adder_sub - Structural
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

entity adder_sub is
    port(
        X, Y: in std_logic_vector(7 downto 0); -- Ingressi: due operandi a 8 bit.
        cin: in std_logic;
        Z: out std_logic_vector(7 downto 0); -- Uscita: risultato dell'addizione o sottrazione.
        cout: out std_logic -- Uscita: riporto in uscita per la sottrazione.
    );
end adder_sub;

architecture Structural of adder_sub is

    component ripple_carry is
        port(
            X, Y: in std_logic_vector(7 downto 0);
            c_in: in std_logic;
            c_out: out std_logic;
            Z: out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- Segnale interno usato per mantenere la versione complementata di Y.
    signal complementoy: std_logic_vector(7 downto 0);

begin
    
    -- Generazione del complemento di Y in base al valore di cin.
    -- Se cin = '0' (addizione), Y rimane invariato.
    -- Se cin = '1' (sottrazione), Y viene complementato.
    complemento_y: FOR i IN 0 TO 7 GENERATE
        complementoy(i) <= Y(i) xor cin; -- Operazione xor per complementare Y se necessario.
    END GENERATE;
    
    -- Istanza del componente ripple_carry
    RA: ripple_carry port map(X, complementoy, cin, cout, Z);

end Structural;
