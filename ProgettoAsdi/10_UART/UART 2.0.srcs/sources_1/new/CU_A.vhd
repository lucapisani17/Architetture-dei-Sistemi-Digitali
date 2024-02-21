library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU_A is
    port(
        start: in std_logic;
        clk: in std_logic;
        reset: in std_logic;
        count: in std_logic_vector(2 downto 0);
        TBE: in std_logic;
        
        en_count: out std_logic;
        WR: out std_logic
    );
end CU_A;

architecture Behavioral of CU_A is

type stato is (IDLE, WRITE_UART, WAIT_TBE, INC_COUNT);
signal stato_corrente: stato := IDLE;
signal stato_successivo: stato;

begin

stato_uscita: process(stato_corrente, start, TBE)
begin
    
    en_count <= '0';
    WR <= '0';

    case stato_corrente is
        when IDLE =>
            en_count<='0';
            WR<='0'; 
            if(start = '1') then
                stato_successivo <= WRITE_UART;
            else
                stato_successivo <= IDLE;
            end if;
            
        when WRITE_UART =>
            WR <= '1';
            stato_successivo <= WAIT_TBE;
        
        when WAIT_TBE =>
            WR<='0'; 
            if(TBE = '0') then
                stato_successivo <= WAIT_TBE;
            else
                stato_successivo <= INC_COUNT;
            end if;
       
       when INC_COUNT =>
            en_count <= '1';
            WR<='0';
            if(count = "111") then
                stato_successivo <= IDLE;
            else
                stato_successivo <= WRITE_UART;
            end if;
            
        end case;
    end process;

    mem: process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                stato_corrente <= IDLE;
            else
                stato_corrente <= stato_successivo;
            end if;
        end if;
    end process;

end Behavioral;
