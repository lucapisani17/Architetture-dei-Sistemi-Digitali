

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cuA is
  Port (
    signal clk: in std_logic;
    signal rst: in std_logic;
    signal en_count: out std_logic;
    signal read: out std_logic;
    start: in std_logic;
    count: in std_logic_vector(2 downto 0);
    
    signal strobe:out std_logic;
    signal ack: in std_logic;
    
    signal shift: out std_logic;
    signal load:out std_logic
   );
end cuA;

architecture Behavioral of cuA is
type stato is (IDLE, CARICA, SHIFTA, TRASMETTI, RICEVUTO);
signal stato_corrente: stato := IDLE;
signal stato_prossimo: stato;

begin

process(start, stato_corrente, ack)
variable conteggio: integer :=0;
begin
    en_count<='0';
    strobe<='0';
    read<='0';
    shift<='0';
    load<='0';

case stato_corrente is
        when IDLE =>
        --rst_counter<='0';
        if(start='1') then
            read<='1';        
            stato_prossimo<=CARICA;
        else 
            stato_prossimo<=IDLE;
        end if;
  
        when CARICA =>
               read<='0';
               load<='1';
               stato_prossimo<=SHIFTA;
               
        when SHIFTA =>
               shift<='1';
               conteggio:=conteggio+1;
               stato_prossimo<=TRASMETTI;
               
        when TRASMETTI =>
               strobe<='1';
               if (ack='0') then
                    stato_prossimo<=TRASMETTI;
               else
                    stato_prossimo<=RICEVUTO;
        end if;
 
        
        when RICEVUTO =>
            strobe<='0';
            if (ack = '1') then
            stato_prossimo<=RICEVUTO;
        else
            if (count="111")then
                   stato_prossimo<=IDLE;
            else

                if (conteggio = 4 )then
                    en_count<='1';
                    stato_prossimo<=IDLE;
                else
                    stato_prossimo<=SHIFTA;
            end if;
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

end Behavioral;
