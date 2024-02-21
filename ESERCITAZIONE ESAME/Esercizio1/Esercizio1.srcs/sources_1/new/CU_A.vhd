library IEEE;
use IEEE.STD_LOGIC_1164.ALL;




entity CU_A is
    port (
        signal start: in std_logic;
        signal clk: in std_logic;
        signal rst: in std_logic;
        signal ACK: in std_logic;
        signal count: in std_logic_vector(2 downto 0);
        
        signal counter_enable: out std_logic;
        signal strobe: out std_logic;
        signal rst_counter: out std_logic
    );
    
end CU_A;

architecture BEHAVIORAL of CU_A is

type stato is (IDLE, TRASMETTI, RICEVUTO);
signal stato_corrente: stato := IDLE;
signal stato_prossimo: stato;

begin

stato_uscita: process(stato_corrente, start, ack, rst)
begin

counter_enable<='0';
strobe<='0';

case stato_corrente is
        when IDLE =>
        rst_counter<='0';
        if(start='1') then
            stato_prossimo<=TRASMETTI;
        else 
            stato_prossimo<=IDLE;
        end if;
        
        when TRASMETTI =>
        strobe<='1';
        if (ack='0') then
            stato_prossimo<=TRASMETTI;
        else
            stato_prossimo<=RICEVUTO;
        end if;
        
        when RICEVUTO =>
        strobe<='0';
        counter_enable<='1';
        if (ack = '1') then
            stato_prossimo<=RICEVUTO;
        else
            if (count = "111" )then
                stato_prossimo<=IDLE;
            else
                stato_prossimo<=TRASMETTI;
        end if;
  end if;
  end case;
  end process;
  
  mem: process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                stato_corrente <= IDLE;
            else
                stato_corrente <= stato_prossimo;
            end if;
        end if;
    end process;
            
end behavioral;