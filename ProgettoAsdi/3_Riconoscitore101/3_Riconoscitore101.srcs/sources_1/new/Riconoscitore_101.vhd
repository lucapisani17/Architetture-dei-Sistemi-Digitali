----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2024 15:09:25
-- Design Name: 
-- Module Name: Riconoscitore_101 - Behavioral
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

entity Riconoscitore_101 is
    port(
        i: in std_logic;
        RST: in std_logic;
        CLK: in std_logic;
        M: in std_logic;
        i_read: in std_logic;
        M_read: in std_logic;
        Y: out std_logic;
        state: out std_logic_vector(3 downto 0)
    );
end Riconoscitore_101;

architecture Behavioral of Riconoscitore_101 is

type stato is (S0, S1, S2, S3, S4, S5, S6, S7, S8);

signal stato_corrente: stato := S0;
signal stato_prossimo: stato;
signal Ytemp: std_logic;

begin

    stato_uscita: process(i, stato_corrente)
    begin
    
    case stato_corrente is
        when S0 =>
            if(M='0') then
                stato_prossimo <= S4;
                Ytemp <= '0';
            else
                stato_prossimo <= S1;
                Ytemp <= '0';
            end if;
        
        when S1 =>
            if(i='1') then
                stato_prossimo <= S2;
                Ytemp <= '0';
            else
                stato_prossimo <= S1;
                Ytemp <= '0';
            end if;
        
        when S2 =>
            if(i='1') then
                stato_prossimo <= S2;
                Ytemp <= '0';
            else
                stato_prossimo <= S3;
                Ytemp <= '0';
            end if;
            
        when S3 =>
            if(i='1') then
                stato_prossimo <= S1;
                Ytemp <= '1';
            else
                stato_prossimo <= S1;
                Ytemp <= '0';
            end if;
            
        when S4 =>
            if(i='1') then
                stato_prossimo <= S5;
                Ytemp <= '0';
            else
                stato_prossimo <= S6;
                Ytemp <= '0';
            end if;
        
        when S5 =>
            if(i='1') then
                stato_prossimo <= S8;
                Ytemp <= '0';
            else
                stato_prossimo <= S7;
                Ytemp <= '0';
            end if;
        
        when S6 =>
            Ytemp <= '0';
            stato_prossimo <= S8;
        
        when S7 =>
            if(i='1') then
                stato_prossimo <= S4;
                Ytemp <= '1';
            else
                stato_prossimo <= S4;
                Ytemp <= '0';
            end if;
        
        when S8 =>
            Ytemp <= '0';
            stato_prossimo <= S4;
            
        end case;
        
    end process;
    
    -- Processo sequenziale per la memoria e l'uscita sincronizzata con il clock
    mem: process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                stato_corrente <= S0;
                Y <= '0';
            else
                if(stato_corrente = S0 and m_read='1') then
                    stato_corrente <= stato_prossimo;
                    Y <= Ytemp;
                elsif(stato_corrente /= S0 and i_read='1') then
                    stato_corrente <= stato_prossimo;
                    Y <= Ytemp;
                end if;
            end if;
        end if;
    end process;
    
    with stato_corrente select
        state <= x"0" when S0,
                 x"1" when S1,
                 x"2" when S2,
                 x"3" when S3,
                 x"4" when S4,
                 x"5" when S5,
                 x"6" when S6,
                 x"7" when S7,
                 x"8" when S8,
                 x"9" when others;
        
end Behavioral;
