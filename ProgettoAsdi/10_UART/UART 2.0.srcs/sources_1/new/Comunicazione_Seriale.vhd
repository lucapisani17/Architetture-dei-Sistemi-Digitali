library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comunicazione_Seriale is
    port(
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic
    );
end Comunicazione_Seriale;

architecture Structural of Comunicazione_Seriale is

    signal link_UARTS: std_logic;

begin

    UA: entity work.Unita_A
        port map(
            clk => clk,
            reset => reset,
            start => start,
            TXD => link_UARTS
        );
        
    UB: entity work.Unita_B
        port map(
            clk => clk,
            reset => reset,
            RXD => link_UARTS
        );  

end Structural;
