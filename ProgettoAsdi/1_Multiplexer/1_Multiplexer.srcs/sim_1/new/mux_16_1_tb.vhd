----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.01.2024 11:15:43
-- Design Name: 
-- Module Name: mux_16_1_tb - tb
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

entity mux_16_1_tb is
end mux_16_1_tb;

architecture tb of mux_16_1_tb is

    --Dichiarazione del componente per l'Unity Under Test (UUT)
    component mux_16_1 
        port(
            B: in std_logic_vector(15 downto 0);
            S: in std_logic_vector(3 downto 0);
            Y: out std_logic
        );
    end component;
    
    --Ingressi
    signal B: std_logic_vector(15 downto 0) := (others => 'U');
    signal S : std_logic_vector(3 downto 0) := (others => 'U');
    
    --Uscita
    signal Y: std_logic;

begin
    
    --Instanziamo l'Unity Under Test
    uut: mux_16_1 port map(
            B => B,
            S => S,
            Y => Y
        );
        
    stim_proc: process
    begin
        --stato di reset per 100 ns
        wait for 100 ns;
        
        -- Applicazione degli input test
      B <= "0001001000110100"; 
      S <= "0000"; -- Selezionare la linea di ingresso 0
      wait for 100 ns;
      assert Y = '0' report "Test fallito per la linea di ingresso 0" severity error;
      
      S <= "0001"; -- Selezionare la linea di ingresso 1
      wait for 100 ns;
      assert Y = '0' report "Test fallito per la linea di ingresso 1" severity error;
      
    -- Vettore di test per la linea di ingresso 2
    B <= "0000000000000100"; -- Solo la linea di ingresso 2 è alta
    S <= "0010";
    wait for 100 ns;
    assert Y = '1' report "Test fallito per la linea di ingresso 2" severity error;
    
    -- Vettore di test per la linea di ingresso 7
    B <= "1000000010000000"; -- Le linee di ingresso 7 e 15 sono alte
    S <= "0111";
    wait for 100 ns;
    assert Y = '1' report "Test fallito per la linea di ingresso 7" severity error;
    
    -- Vettore di test per la linea di ingresso 8
    B <= "0000000100000000"; -- Solo la linea di ingresso 8 è alta
    S <= "1000";
    wait for 100 ns;
    assert Y = '1' report "Test fallito per la linea di ingresso 8" severity error;
    
    -- Vettore di test per la linea di ingresso 14
    B <= "0100000000000000"; -- Solo la linea di ingresso 14 è alta
    S <= "1110";
    wait for 100 ns;
    assert Y = '1' report "Test fallito per la linea di ingresso 14" severity error;
    
    -- Vettore di test per tutti gli zeri
    B <= (others => '0'); -- Tutti gli ingressi sono bassi
    S <= "1010";
    wait for 100 ns;
    assert Y = '0' report "Test fallito per tutti gli zeri" severity error;
    
    -- Vettore di test per tutti gli uni
    B <= (others => '1'); -- Tutti gli ingressi sono alti
    S <= "0101";
    wait for 100 ns;
    assert Y = '1' report "Test fallito per tutti gli uni" severity error;
    
    wait;
end process;

end tb;
