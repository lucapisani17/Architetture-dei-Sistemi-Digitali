library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cuB is
  Port (
    signal clk: in std_logic;
    signal rst: in std_logic;
    signal trigger: in std_logic;
    signal en_write: out std_logic;
    signal accumula: out std_logic;
    signal conteggiooutput: out std_logic_vector(2 downto 0);
    signal count: in std_logic_vector(2 downto 0);
    
    signal ack:out std_logic;
    signal strobe: in std_logic
   );
end cuB;

architecture behavioral of CUB is
type stato is (idle, waiting, invio_ack);
signal curr_state: stato := waiting;
signal next_state: stato := waiting;

begin

    stato_uscita: process(curr_state, strobe,trigger)
    variable conteggio: integer :=0;
    begin
        
        ack <= '0';
        en_write<= '0';
        accumula<= '0';
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
                accumula<='1';
                ack <= '1';
                
                conteggio:=conteggio+1; 
                if conteggio=4 then
                    en_write<='1'; --carico nel riconoscitore
                    
                    if(trigger = '1') then
                    conteggiooutput<=count;
                    next_state <= idle;
                    else
                    next_state <= waiting;
                    end if;
                    
                else
                next_state<=waiting;
                end if;
        end case;
        
    end process;
    
    mem: process(clk)
    begin
        if rising_edge(clk) then
            if rst='1' then
                curr_state <= waiting;
            else
                curr_state <= next_state;
            end if;
        end if;
    end process;



end Behavioral;