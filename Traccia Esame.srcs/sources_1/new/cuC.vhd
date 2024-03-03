

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.ALL;


entity cuC is
  Port (
  signal clk: in std_logic;
  signal rst: in std_logic;
  
  signal enable: out std_logic;
  signal write: out std_logic;
  
  signal result_from_add: in std_logic_vector(7 downto 0);
  signal data_to_save: out std_logic_vector(7 downto 0);
  signal cop: in std_logic_vector(1 downto 0);
  signal cin: out std_logic;
  signal X: in std_logic_vector(7 downto 0);
    
  signal reqA: in std_logic;
  signal ackA: out std_logic;
  signal doneA:out std_logic;
  
  signal reqB: in std_logic;
  signal ackB: out std_logic;
  signal doneB:out std_logic;
  
  signal stop: out std_logic
   );
end cuC;

architecture Behavioral of cuC is
type stato is (waiting, invioack, elaboro, salva, interrompi, idle);
signal curr_state: stato := waiting;
signal next_state: stato := waiting;
signal appoggio: std_logic;

begin


 stato_uscita: process(curr_state, reqA, reqB )
    begin
write<='0';
cin<='0';
ackA<='0';
doneA<='0';
ackB<='0';
doneB<='0';
stop<='0';
--data_to_save<="00000000";
enable<='0';
    case curr_state is
        when waiting =>
            write<='0';
            data_to_save<="00000000";
            cin<='0';
            enable<='0';
            ackA<='0';
            doneA<='0';
            ackB<='0';
            doneB<='0';
            stop<='0';
            if (reqA ='1' AND reqB = '1') then
                next_state<=invioack;
            else 
                next_state<= waiting;
            end if;
            
        when invioack =>
            write<='0';
            doneA<='0';
            data_to_save<="00000000";
            enable<='0';
            doneB<='0';
            stop<='0';
            write<='0';
            ackA<='1';
            ackB<='1';
            if (cop="00") then
                cin<='0';
            elsif (cop="11") then
                cin<='1';
            end if;
            next_state<=elaboro;
            
        when elaboro => 
            write<='0';
            write<='0';
            enable<='0';
            cin<='0';
            ackA<='0';
            doneA<='0';
            ackB<='0';
            doneB<='0';
            stop<='0';
            if (conv_integer(result_from_add)<X OR conv_integer(result_from_add)=X) then
                data_to_save<=result_from_add;
                
                next_state<=salva;
            else 
                data_to_save<="11111111";
               
                next_state<= interrompi;
            end if;
            
        when salva =>
            write<='1';
            cin<='0';
            ackA<='0';
            ackB<='0';
            stop<='0';
            doneA<='1';
            doneB<='1';
            
            enable<='1';
            appoggio<='1';
            next_state<=waiting;
        
        when interrompi => 
            write<='1';
            stop<='1';
            enable<='0';
            cin<='0';
            ackA<='0';
            ackB<='0';
            stop<='0';
            doneA<='1';
            doneB<='1';
            next_state<=idle;
            
        when idle=>
            write<='0';
            next_state<=idle;
            
        end case;
 end process;
           
 mem: process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                curr_state <= waiting;
            else
                curr_state <= next_state;
            end if;
        end if;
    end process;           

end behavioral;