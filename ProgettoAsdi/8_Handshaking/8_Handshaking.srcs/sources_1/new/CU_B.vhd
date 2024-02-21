library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU_B is
    port(
        clk: in std_logic;
        reset: in std_logic;
        strobe: in std_logic;
        count: in std_logic_vector(2 downto 0);
        en_count: out std_logic;
        en_write: out std_logic;
        ack: out std_logic
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
        en_write <= '0';
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
                en_write <= '1';
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
            if reset='1' then
                curr_state <= waiting;
            else
                curr_state <= next_state;
            end if;
        end if;
    end process;

end Behavioral;
