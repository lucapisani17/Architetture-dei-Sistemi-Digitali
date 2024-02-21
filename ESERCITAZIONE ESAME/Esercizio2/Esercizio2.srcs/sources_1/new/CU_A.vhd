----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.02.2024 12:17:02
-- Design Name: 
-- Module Name: CU_A - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CU_A is
  Port ( 
    signal clk: in std_logic;
    signal rst: in std_logic;
    signal ack: in std_logic;
    signal start: in std_logic;
    
    signal strobe: out std_logic;
    
    signal count: in std_logic_vector(2 downto 0);
    
    signal en_count: out std_logic
    
  );
end CU_A;

architecture Behavioral of CU_A is

type stato is (idle, preparazione_dato, trasmetti_dato, ricevuto);
signal curr_state: stato := idle;
signal next_state: stato := idle;

begin

    stato_uscita: process(curr_state, start, ack)
    begin
        
    strobe <= '0';
    en_count <= '0';
    
    case curr_state is
        when idle => 
            if (start = '1') then
                next_state <= preparazione_dato;
            else
                next_state <= idle;
            end if;
        when preparazione_dato =>
            next_state <= trasmetti_dato;
        when trasmetti_dato =>
            strobe <= '1';
            if (ack = '1') then
                next_state <= ricevuto;
            else
                next_state <= trasmetti_dato;
            end if;
        when ricevuto => 
            if (ack = '0') then
                en_count <= '1'; 
                if(count = "111") then
                    next_state <= idle; 
                else
                    next_state <= preparazione_dato;
                end if;
            else
                next_state <= ricevuto;
            end if;
    end case;
        
    end process;

    mem: process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                curr_state <= idle;
            else
                curr_state <= next_state;
            end if;
        end if;
    end process;


end Behavioral;
