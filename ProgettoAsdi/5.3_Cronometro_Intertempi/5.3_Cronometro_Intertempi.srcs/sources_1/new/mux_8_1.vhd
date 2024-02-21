library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_8_1 is
    Port ( data : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC_VECTOR (2 downto 0);
           output : out STD_LOGIC
           );
end mux_8_1;

architecture Dataflow of mux_8_1 is

begin
    
    with sel select
        output <= data(0) when  "000",
                  data(7) when  "001",
                  data(6) when  "010",
                  data(5) when  "011",
                  data(4) when  "100",
                  data(3) when  "101",
                  data(2) when  "110",
                  data(1) when  "111",
                  '-'     when  others;
                  
end Dataflow;