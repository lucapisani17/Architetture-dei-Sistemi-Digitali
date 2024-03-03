

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
  clk: in std_logic;
  rst: in std_logic;
  start: in std_logic;
  Xinput: in std_logic_vector(7 downto 0); -- valore confronto, un valore rappresentabile su 8 bit
  op2input: in std_logic_vector(7 downto 0);
  Xoutput: out std_logic_vector(7 downto 0);
  op2ouput: out std_logic_vector(7 downto 0);
    
  signal req: out std_logic;
  signal ack: in std_logic;
  signal done:in std_logic;
  
  signal stop: in std_logic
   );
end cuB;

architecture Behavioral of cuB is
type stato is (idle, request, invio, ricevuto);
signal curr_state: stato := idle;
signal next_state: stato := idle;
begin

stato_uscita: process(curr_state, start, ack, done)
    begin
--    Xoutput<="00000000";
--    op2ouput<="00000000";
    req<='0';
    
    case curr_state is
        when idle =>
            if (start = '1') then
                next_state <= request;
            else
                next_state <= idle;
            end if;

        when request =>
            req<='1';
            if ack = '0' then
                next_state <= request;
            else 
                Xoutput<=Xinput;
                op2ouput<=op2input;
                next_state <= invio;
             end if;
        
        when invio =>
            req<='0';
            if done = '1' then
                next_state <= ricevuto;
            else
                next_state <= invio;
            end if;
            
        when ricevuto => 
            if stop ='1' then
                next_state<=idle;
            else 
                next_state<=request;
            end if;

    end case;
end process;
mem: process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                curr_state <= idle;
            else
                curr_state <= next_state;
            end if;
        end if;
    end process;
end behavioral;