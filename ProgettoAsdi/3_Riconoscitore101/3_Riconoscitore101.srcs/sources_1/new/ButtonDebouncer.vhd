----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2024 17:31:12
-- Design Name: 
-- Module Name: ButtonDebouncer - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity ButtonDebouncer is
    generic(
        CLK_period: integer := 10; -- periodo del clock della board (in nanosecondi)
        btn_noise_time: integer := 10000000 -- durata stimata dell'oscillazione del bottone
                                            -- il valore di default � 10 millisecondi
    );
    port(
        RST: in std_logic;
        CLK: in std_logic;
        BTN: in std_logic;
        CLEARED_BTN: out std_logic -- segnale di output ripulito
    );
end ButtonDebouncer;

architecture Behavioral of ButtonDebouncer is

    type stato is (NOT_PRESSED, CHK_PRESSED, PRESSED, CHK_NOT_PRESSED);
    signal BTN_state: stato := NOT_PRESSED;
    
    constant max_count : integer := btn_noise_time/CLK_period; -- 10000000/10= conto 1000000 colpi di clock

begin

    deb: process(CLK)
        
        variable count: integer := 0;
        
        begin
        
            if rising_edge(CLK) then
                
                if(RST = '1') then
                    BTN_state <= NOT_PRESSED;
                    CLEARED_BTN <= '0';
                else
                    case BTN_state is
                        when NOT_PRESSED =>
                            if(BTN = '1') then
                                BTN_state <= CHK_PRESSED;
                            else
                                BTN_state <= NOT_PRESSED;
                            end if;
                            
                        when CHK_PRESSED =>
                            if(count = max_count-1) then --conta i cicli di clock fino a max_count-1 (ovvero 10ms)
                                if(BTN = '1') then --se arrivo a count max ed � ancora alto vuol dire che non era un bounce, devo alzare CLEARED_BTN
                                    count := 0;
                                    CLEARED_BTN <= '1';
                                    BTN_state <= PRESSED;
                                else
                                    count := 0;
                                    BTN_state <= NOT_PRESSED;
                                end if;
                            else
                                count := count+1;
                                BTN_state <= CHK_PRESSED;
                            end if;
                       
                       when PRESSED => --Abbasso subito CLEARED_BIN per avere un singolo impulso
                            CLEARED_BTN <= '0';
                            if(BTN = '0') then
                                BTN_state <= CHK_NOT_PRESSED;
                            else
                                BTN_state <= PRESSED;
                            end if;
                       
                       when CHK_NOT_PRESSED =>
                            if(count = max_count-1) then
                                if(BTN = '0') then --se arrivo a count max ed � ancora basso vuol dire che non era un bounce e il bottone � stato rilasciato
                                    count := 0;
                                    BTN_state <= NOT_PRESSED;
                                else
                                    count := 0;
                                    BTN_state <= PRESSED;
                                end if;
                            else
                                count := count+1;
                                BTN_state <= CHK_NOT_PRESSED;
                            end if;
                        
                       when others =>
                            BTN_state <= NOT_PRESSED;
                       end case;
                   end if;
                end if;
            end process;                    

end Behavioral;
