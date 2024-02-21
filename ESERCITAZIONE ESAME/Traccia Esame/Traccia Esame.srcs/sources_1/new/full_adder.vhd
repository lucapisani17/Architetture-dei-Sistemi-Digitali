----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2024 15:44:53
-- Design Name: 
-- Module Name: full_adder - Dataflow
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

entity full_adder is
    port(
        a: in std_logic; -- Primo operando del Full Adder 
        b: in std_logic; -- Secondo operando del Full Adder 
        cin: in std_logic;  -- Carry-In, il riporto da un'eventuale addizione precedente
        cout: out std_logic; -- Carry-Out, il riporto risultante dall'addizione dei due operandi e del Carry-In
        s: out std_logic -- Sum bit, il risultato dell'addizione dei due operandi e del Carry-In
        
    );
end full_adder;

architecture dataflow of full_adder is

begin
    -- Assegna al port di uscita S il risultato dell'operazione XOR tra gli operandi e il Carry-In.
    -- Questo è il valore del bit di somma per l'addizione binaria.
    s <= (a xor b) xor cin;
    -- Assegna al port di uscita COUT il risultato dell'operazione OR tra:
    -- 1. L'AND degli operandi, che genera un carry se entrambi gli operandi sono 1.
    -- 2. L'AND tra il Carry-In e l'OR degli operandi, che genera un carry se uno degli operandi e il Carry-In sono 1.
    -- Questo è il valore del Carry-Out per l'addizione binaria.
    cout <= (a and b) or (cin and (a or b));

end dataflow;
