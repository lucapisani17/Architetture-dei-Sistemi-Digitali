----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2024 11:43:42
-- Design Name: 
-- Module Name: unita_controllo - Behavioral
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


entity unita_controllo is
    port(
        clock: in std_logic;
        reset: in std_logic;
        load_first_part: in std_logic; --bottone per caricare i primi 8 bit in input
        load_second_part: in std_logic; --bottone per caricare i secondi 8 bit in input
        load_sel: in std_logic; --bottone per carica i selettori
        value8_in: in std_logic_vector(7 downto 0); 
        selIn_M: in std_logic_vector(3 downto 0);
        selIn_D: in std_logic_vector(1 downto 0);
        value16_out: out std_logic_vector(15 downto 0);
        selOut_M: out std_logic_vector(3 downto 0);
        selOut_D: out std_logic_vector(1 downto 0)
    );
end unita_controllo;

architecture Behavioral of unita_controllo is

    signal reg_value: std_logic_vector(15 downto 0) := (others => '0');
    signal reg_selM: std_logic_vector(3 downto 0) := (others => '0');
    signal reg_selD: std_logic_vector(1 downto 0) := (others => '0');
    
begin
    
    value16_out <= reg_value;
    selOut_M <= reg_selM(3 downto 0);
    selOut_D <= reg_selD(1 downto 0);
    
    proc: process(clock)
    
    begin
        
        if(rising_edge(clock)) then
            if( reset = '1') then
                reg_value <= (others => '0');
            else
                if( load_first_part = '1') then
                    reg_value(7 downto 0) <= value8_in; --prendo il valore dagli switch e lo carico
                elsif( load_second_part = '1') then
                    reg_value(15 downto 8) <= value8_in;
                elsif( load_sel = '1') then
                    reg_selM(3 downto 0) <= selIn_M;
                    reg_selD(1 downto 0) <= selIn_D;
                end if;
            end if;
        end if;
        
    end process;
                    
end Behavioral;
