----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.02.2024 10:40:13
-- Design Name: 
-- Module Name: COMPARATORE - Behavioral
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
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity COMPARATORE is
  Port (
    signal clk: in std_logic;
    signal rst: in std_logic;
    signal start: in std_logic;
    
    signal stringaA: in std_logic_vector(7 downto 0);
    signal stringaB: in std_logic_vector(7 downto 0);
    count : out integer range 0 to 8
   );
end COMPARATORE;

architecture Behavioral of COMPARATORE is

type stato is (idle, compara, maggiore, minore, uguale);
signal curr_state: stato := idle;
signal next_state: stato := idle;
signal match_count : integer range 0 to 8 := 0;
begin

stato_uscita: process(curr_state, start)

    begin
    case curr_state is
        when idle => 
        if (start='1') then
            next_state<=compara;
        else
            next_state<=idle;
        end if;
        
        when compara => 
        if(conv_integer(stringaA)>conv_integer(stringaB)) then
            next_state<=maggiore;
        elsif (conv_integer(stringaA)<conv_integer(stringaB)) then
            next_state<=minore;
        else next_state<=uguale;
        end if;
        
        when maggiore=>
        match_count<=0;
        for i in stringaA'range loop
            if stringaA(i) = stringaB(i) then
                match_count <= match_count + 1; -- Increment match count if bits are equal
            end if;
        end loop;
        count <= match_count; -- Output the match count
        
        when minore=>
        match_count<=0;
        for i in stringaA'range loop
            if stringaA(i) = stringaB(i) then
                match_count <= match_count + 1; -- Increment match count if bits are equal
            end if;
        end loop;
        count <= match_count; -- Output the match count
        
        when uguale=>
        match_count<=0;
        for i in stringaA'range loop
            if stringaA(i) = stringaB(i) then
                match_count <= match_count + 1; -- Increment match count if bits are equal
            end if;
        end loop;
        count <= match_count; -- Output the match count
        
        end case;
        end process;
        
        
        mem: process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                curr_state <= IDLE;
            else
                curr_state <= next_state;
            end if;
        end if;
    end process;

end Behavioral;
