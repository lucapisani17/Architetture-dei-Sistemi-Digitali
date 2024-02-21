library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodo_A is
    port(
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        ack: in std_logic;
        strobe: out std_logic;
        data_out: out std_logic_vector(7 downto 0)
    );
end nodo_A;

architecture Structural of nodo_A is

signal en_count_temp: std_logic;
signal count_temp: std_logic_vector(2 downto 0);
signal rst_count_temp: std_logic;
signal read_temp: std_logic;

begin

    unita_controllo: entity work.CU_A port map(
        clk => clk,
        reset => reset,
        start => start,
        ack => ack,
        en_count => en_count_temp,
        rst_count => rst_count_temp,
        count => count_temp,
        strobe => strobe,
        read => read_temp
    );
    
    contatore: entity work.counter_mod8 port map(
        clk => clk,
        reset => rst_count_temp,
        enable => en_count_temp,
        count => count_temp
    );
    
    ROM: entity work.rom port map(
        clk => clk,
        read => read_temp,
        addr => count_temp,
        data_out => data_out
    );

end Structural;
