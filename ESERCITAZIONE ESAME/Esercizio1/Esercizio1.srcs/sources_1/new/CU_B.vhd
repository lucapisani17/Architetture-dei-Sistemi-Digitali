library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;


entity CU_B is
    port (
        signal clk: in std_logic;
        signal rst: in std_logic;
        signal strobe: in std_logic;
        signal count: in std_logic_vector(2 downto 0);
        
        signal datain_C: in std_logic_vector(7 downto 0);
        signal datain_X: in std_logic_vector(3 downto 0);
        
        signal ACK: out std_logic;
        signal dataout: out std_logic_vector(7 downto 0);
        
        signal writeMEM1: out std_logic;
        signal writeMEM2: out std_logic;
        
        signal counter_enable: out std_logic
    );
    
end CU_B;

architecture BEHAVIORAL of CU_B is
type stato is (WAITSTATE, INVIOACK, IDLE);
signal stato_corrente: stato := WAITSTATE;
signal stato_prossimo: stato;

begin

stato_uscita: process(stato_corrente, strobe, rst, datain_C, datain_X)
variable temp_count : integer range 0 to 8 := 0;

begin

counter_enable<='0';
ACK<='0';
writeMEM1<='0';
writeMEM1<='0';
--dataout<=(OTHERS<='0);

case stato_corrente is
        when WAITSTATE =>
        if(strobe='0') then
            stato_prossimo<=WAITSTATE;
        else 
            stato_prossimo<=INVIOACK;
        end if;
        
        when INVIOACK =>
        counter_enable<='1';
        ack<='1';
       --conta i bit alti in c[i]
        for i in datain_C'range loop
                if datain_C(i) = '1' then
                    temp_count := temp_count + 1;
                end if;
        end loop;
       
       --confronto il numero di bit alti con il valore convertito della seconda stringa
        if (temp_count = conv_integer(datain_X)) then
            writeMEM1<='1';
            if (count="111") then
            stato_prossimo<=IDLE;
            else 
            stato_prossimo<=WAITSTATE;
            end if; 
        else
            writeMEM2<='1';
            if (count="111") then
            stato_prossimo<=IDLE;
            else 
            stato_prossimo<=WAITSTATE;
            end if; 
        end if;

              
        
        when IDLE =>
        ack<='0';
        counter_enable<='0';
        writeMEM1<='0';
        writeMEM2<='0';
       

  end case;
  end process;
            
end behavioral;

