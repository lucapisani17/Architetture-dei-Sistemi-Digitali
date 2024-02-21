library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU_input is
    port(
        clk: in std_logic;
        reset: in std_logic;
        load: in std_logic;
        load_sec: out std_logic;
        load_min: out std_logic;
        load_ore: out std_logic
    );
end CU_input;

architecture Behavioral of CU_input is

type stato is (idle, carica_secondi, ok_secondi, carica_minuti, ok_minuti, carica_ore, ok_ore);
signal stato_corrente: stato := idle; 

begin

    proc: process(clk)
    begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                stato_corrente <= idle;
                load_sec <= '0';
                load_min <= '0';
                load_ore <= '0';
            else
                case stato_corrente is
                    when idle =>
                        load_sec <= '0';
                        load_min <= '0';
                        load_ore <= '0';
                        if(load = '1') then
                            stato_corrente <= carica_secondi;
                        else
                            stato_corrente <= idle;
                        end if;
                    when carica_secondi => 
                        load_sec <= '1';
                        stato_corrente <= ok_secondi;
                    when ok_secondi => 
                        load_sec <= '0';
                        if(load = '1') then
                            stato_corrente <= carica_minuti;
                        else
                            stato_corrente <= ok_secondi;
                        end if;
                    when carica_minuti =>
                        load_min <= '1';
                        stato_corrente <= ok_minuti;
                    when ok_minuti =>
                        load_min <= '0';
                        if(load = '1') then
                            stato_corrente <= carica_ore;
                        else
                            stato_corrente <= ok_minuti;
                        end if;
                    when carica_ore =>
                        load_ore <= '1';
                        stato_corrente <= ok_ore;
                    when ok_ore => 
                        load_ore <= '0';
                        if(load = '1') then
                            stato_corrente <= carica_secondi;
                        else
                            stato_corrente <= ok_ore;
                        end if;
                end case;
            end if;
        end if;
    end process;

end Behavioral;
