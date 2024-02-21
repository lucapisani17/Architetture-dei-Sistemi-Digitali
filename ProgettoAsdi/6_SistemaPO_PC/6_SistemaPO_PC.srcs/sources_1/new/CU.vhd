----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2024 10:46:06
-- Design Name: 
-- Module Name: CU - Behavioral
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

entity CU is
    port(
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        count: in std_logic_vector(2 downto 0);
        
        en_cont: out std_logic;
        rst_cont: out std_logic;
        read: out std_logic;
        write: out std_logic
    );
end CU;

architecture Behavioral of CU is

type stato is (IDLE,READ_STATE,WRITE_STATE,COUNT_STATE);

signal stato_corrente: stato:=IDLE;
signal stato_prossimo: stato:=IDLE;


begin

funzione_Stato_uscita: process(stato_corrente, start)
begin

read <= '0';
write <= '0';
en_cont <= '0';

case stato_corrente is
    when IDLE=>
        if start = '0' then
            stato_prossimo<=IDLE;
        else
            stato_prossimo<=READ_STATE;
        end if;
        
    when READ_STATE=>
        read<='1';
        stato_prossimo<=WRITE_STATE;
        
    when WRITE_STATE=>
        write<='1';
        stato_prossimo<=COUNT_STATE;
        
    when COUNT_STATE=>
        en_cont<='1';
        if (count="111") then
            stato_prossimo<=IDLE;
        else 
            stato_prossimo<=READ_STATE;
        end if; 
        
    end case;
end process;

mem: process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                rst_cont <= '0';
                stato_corrente <= IDLE;
            else
                stato_corrente <= stato_prossimo;
            end if;
        end if;
    end process;



end Behavioral;
