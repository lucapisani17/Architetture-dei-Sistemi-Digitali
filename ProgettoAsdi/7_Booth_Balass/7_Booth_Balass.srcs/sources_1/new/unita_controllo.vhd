library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity unita_controllo is
    port(
        qi,qi_meno1: in std_logic;
        clock, reset, start: in std_logic;
        count: in std_logic_vector(2 downto 0);
        loadA, loadM, loadQ: out std_logic;
        resetRegs: out std_logic;
        shift: out std_logic;
        sub: out std_logic;
        count_in: out std_logic;
        stop_cu: out std_logic
    );
end unita_controllo;

architecture Behavioral of unita_controllo is

    type state is (idle,beginMul,input1,input2,scan,rshift,lastshf,increment,test,finish);
    signal current_state, next_state: state;

begin

    reg_stato: process(clock)
        begin
            if(clock'event and clock='1') then
                if(reset='1') then
                    current_state <= idle;
                else
                    current_state <= next_state;
                end if;
            end if;
        end process;
        
    comb: process(current_state,start,count)
        begin
            loadA <= '0';
            loadM <= '0';
            loadQ <= '0';
            shift <= '0';
            sub <= '0';
            count_in <= '0';
            stop_cu <= '0';
            resetRegs <= '0';
            
            CASE current_state is
                WHEN idle =>
                    if(start='1') then
                        next_state <= beginMul;
                    else
                        next_state <= idle;
                    end if;
                WHEN beginMul =>
                    resetRegs <= '1';
                    next_state <= input1;
                WHEN input1 =>
                    loadM <= '1';
                    loadQ <= '1';
                    next_state <= input2;
                WHEN input2 =>
                    loadM <= '1';
                    loadQ <= '1';
                    next_state <= scan;
                
                WHEN scan =>
                    if(qi=qi_meno1) then
                        next_state <= rshift;
                    else
                        if(qi='0' and qi_meno1='1') then
                            sub <= '0';
                            loadA<='1';
                        elsif (qi='1' and qi_meno1='0') then
                            sub <= '1';
                            loadA<='1';
                        end if;
                        next_state <= rshift;
                    end if;
                WHEN rshift =>
                    shift <= '1';
                    next_state <= increment;
                WHEN increment =>
                    count_in<='1';
                    next_state <= test;
                WHEN test =>
                    if(count="111") then
                        next_state<=lastshf;
                    else
                        next_state <= scan;
                    end if;
                WHEN lastshf =>
                    shift <='1';
                    next_state <= finish;
                WHEN finish =>
                    
                    stop_cu <= '1';
                    next_state <= idle;
                                         
            end CASE;
            
        end process;


end Behavioral;
