----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.02.2024 12:17:02
-- Design Name: 
-- Module Name: CU_B - Behavioral
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

entity CU_B is
  Port (
    signal clk: in std_logic;
    signal rst: in std_logic;
    signal ack: out std_logic;
    signal strobe: in std_logic;
    signal count: in std_logic_vector(2 downto 0);
    signal en_count: out std_logic;
    signal datafromA: in std_logic_vector(3 downto 0)
   );
end CU_B;

architecture Behavioral of CU_B is

type stato is (idle, waiting, invio_ack);
signal curr_state: stato := waiting;
signal next_state: stato := waiting;

begin

    stato_uscita: process(curr_state, strobe)
    begin
        
        en_count <= '0';

        ack <= '0';
        
        case curr_state is
            
            when idle =>
                next_state <= idle;
            when waiting =>
                if strobe='1' then
                    next_state <= invio_ack;
                else
                    next_state <= waiting;
                end if;
            when invio_ack =>

                en_count <= '1';
                ack <= '1';
                if(count = "111") then
                    next_state <= idle;
                else
                    next_state <= waiting;
                end if;
        end case;
        
    end process;
    
    mem: process(clk)
    begin
        if rising_edge(clk) then
            if rst='1' then
                curr_state <= waiting;
            else
                curr_state <= next_state;
            end if;
        end if;
    end process;


end Behavioral;
