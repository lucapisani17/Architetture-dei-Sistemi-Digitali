----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2024 11:27:38
-- Design Name: 
-- Module Name: rete_onBoard - Behavioral
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

entity rete_onBoard is
    port(
        clock: in std_logic;
        reset: in std_logic;
        load_first_part: in std_logic; --bottone per caricare i primi 8 bit in input
        load_second_part: in std_logic; --bottone per caricare i secondi 8 bit in input
        load_sel: in std_logic; --bottone per caricare i selettori
        switchData: in std_logic_vector(7 downto 0); 
        switch_selM: in std_logic_vector(3 downto 0);
        switch_selD: in std_logic_vector(1 downto 0);
        value_out: out std_logic_vector(3 downto 0)
    );
end rete_onBoard;

architecture Structural of rete_onBoard is

    component unita_controllo is
        port(
            clock: in std_logic;
            reset: in std_logic;
            load_first_part: in std_logic; --bottone per caricare i primi 8 bit in input
            load_second_part: in std_logic; --bottone per caricare i secondi 8 bit in input
            load_sel: in std_logic; --bottone per caricare i selettori
            value8_in: in std_logic_vector(7 downto 0); 
            selIn_M: in std_logic_vector(3 downto 0);
            selIn_D: in std_logic_vector(1 downto 0);
            value16_out: out std_logic_vector(15 downto 0);
            selOut_M: out std_logic_vector(3 downto 0);
            selOut_D: out std_logic_vector(1 downto 0)
        );
    end component;

    component rete_interconnessione is
        port(
            A: in std_logic_vector(15 downto 0); -- Vettore di ingresso di 16 bit
            S: in std_logic_vector(3 downto 0);  -- Vettore di selezione di 4 bit per il Mux
            L: in std_logic_vector(1 downto 0);  -- Vettore di selezione di 2 bit per il Demux
            Y: out std_logic_vector(3 downto 0)  -- Vettore di uscita di 4 bit dal Demux
        );
    end component;
    
    signal inputs : std_logic_vector(15 downto 0);
    signal selmux: std_logic_vector(3 downto 0);
    signal seldem: std_logic_vector(1 downto 0);
 
begin
    
    CU: unita_controllo port map(
        clock => clock,
        reset => reset,
        load_first_part => load_first_part,
        load_second_part => load_second_part,
        load_sel => load_sel,
        value8_in => switchData,
        selIn_M => switch_selM,
        selIn_D => switch_selD,
        value16_out => inputs,
        selOut_M => selmux,
        selOut_D => seldem
        );
    
    RI: rete_interconnessione port map(
            A => inputs,
            S => selmux,
            L => seldem,
            Y => value_out
        );


end Structural;
