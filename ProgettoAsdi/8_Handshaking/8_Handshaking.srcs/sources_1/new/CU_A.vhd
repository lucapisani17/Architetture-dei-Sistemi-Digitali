library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU_A is
    port(
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        ack: in std_logic;
        count: in std_logic_vector(2 downto 0);
        en_count: out std_logic;
        rst_count: out std_logic;
        strobe: out std_logic;
        read: out std_logic
    );
end CU_A;

architecture Behavioral of CU_A is

type stato is (idle, preparazione_dato, trasmetti_dato, ricevuto);
signal curr_state: stato := idle;
signal next_state: stato := idle;

begin

    stato_uscita: process(curr_state, start, ack)
    begin
        
    rst_count <= '0';
    read <= '0';
    strobe <= '0';
    en_count <= '0';
    
    case curr_state is
        when idle => 
            if (start = '1') then
                rst_count <= '1';
                next_state <= preparazione_dato;
            else
                next_state <= idle;
            end if;
        when preparazione_dato =>
            read <= '1';
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
            if reset = '1' then
                curr_state <= idle;
            else
                curr_state <= next_state;
            end if;
        end if;
    end process;


end Behavioral;
