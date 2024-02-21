----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.01.2024 13:37:06
-- Design Name: 
-- Module Name: demux_1_4 - Dataflow
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

--Definizione dell'entità demux_1_4
entity demux_1_4 is
    Port(
        A : in std_logic;              -- Ingresso singolo
        S : in std_logic_vector(1 downto 0);  -- Vettore di ingresso di 2 bit per la selezione
        Y : out std_logic_vector(3 downto 0)  -- Vettore di uscita di 4 bit
    );
end demux_1_4;

-- Architettura Dataflow del demux_1_4
architecture Dataflow of demux_1_4 is
begin
    -- Logica di demultiplexing utilizzando un'istruzione select condizionale
    with S select
        Y <= "000" & A when "00",    -- A inviato a Y(0) quando S è "00"
            "00" & A & "0" when "01",    -- A inviato a Y(1) quando S è "01"
            "0" & A & "00" when "10",    -- A inviato a Y(2) quando S è "10"
            A & "000" when "11",     -- A inviato a Y(3) quando S è "11"
            "----" when others;      -- Imposta Y su '-' se S non è uno dei valori sopra
end Dataflow;
