----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.01.2024 15:16:39
-- Design Name: 
-- Module Name: rete_interconnessione_tb - tb
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

entity rete_interconnessione_tb is
end rete_interconnessione_tb;

architecture tb of rete_interconnessione_tb is

    component rete_interconnessione
        port(
            A : in STD_LOGIC_VECTOR(15 downto 0);
            S : in STD_LOGIC_VECTOR(3 downto 0);
            L : in STD_LOGIC_VECTOR(1 downto 0);
            Y : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    signal A : STD_LOGIC_VECTOR(15 downto 0) := (others => 'U');
    signal S : STD_LOGIC_VECTOR(3 downto 0) := (others => 'U');
    signal L : STD_LOGIC_VECTOR(1 downto 0) := (others => 'U');
    signal Y : STD_LOGIC_VECTOR(3 downto 0);

begin

    uut: rete_interconnessione port map(
            A => A,
            S => S,
            L => L,
            Y => Y
        );
        
    stim_proc: process
    begin
        wait for 100 ns;

        -- Test 1: Tutti gli ingressi a zero
        A <= "0000000000000000";
        S <= "0000";
        L <= "00";
        wait for 100 ns;
        assert Y = "0000" report "Test 1 fallito (tutti zeri)" severity error;
        
        -- Test 2: Ingresso e selezione specifici
        A <= "1100110011001100";
        S <= "1010"; -- Seleziona bit 10 di A
        L <= "01";   -- Seleziona Y(1) nel demux
        wait for 100 ns;
        assert Y = "0010" report "Test 2 fallito (selezione specifica)" severity error;

        -- Test 3: Cambia selezione nel mux
        A <= "1100110011001100";
        S <= "0111"; -- Seleziona bit 7 di A
        wait for 100 ns;
        assert Y = "0010" report "Test 3 fallito (cambio selezione mux)" severity error;

        -- Test 4: Cambia selezione nel demux
        A <= "1100110011001100";
        L <= "10";   -- Seleziona Y(2) nel demux
        wait for 100 ns;
        assert Y = "0100" report "Test 4 fallito (cambio selezione demux)" severity error;

        -- Test 5: Diversi ingressi per A
        A <= "1010101010101010";
        S <= "0101"; -- Seleziona bit 5 di A
        L <= "11";   -- Seleziona Y(3) nel demux
        wait for 100 ns;
        assert Y = "1000" report "Test 5 fallito (diversi ingressi per A)" severity error;

        wait;
    end process;

end tb;
