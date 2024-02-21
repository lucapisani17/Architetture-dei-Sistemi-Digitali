library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sistemaPO_PC is
    port(
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        output: out std_logic_vector(3 downto 0);
        stop: out std_logic
    );
end sistemaPO_PC;

architecture Structural of sistemaPO_PC is

signal en_cont_temp: std_logic;
signal rst_cont_temp: std_logic;
signal read_temp: std_logic;
signal write_temp: std_logic;
signal count_temp: std_logic_vector(2 downto 0);
signal in_m_temp: std_logic_vector(7 downto 0);
signal out_m_temp: std_logic_vector(3 downto 0);
signal stop_temp: std_logic;

begin

    unita_controllo: entity work.CU_sintesi port map(
        clk => clk,
        start => start,
        reset => reset,
        count => count_temp,
        en_cont => en_cont_temp,
        rst_cont => rst_cont_temp,
        read => read_temp,
        write => write_temp,
        stop => stop
    ); 
    
    contatore: entity work.counter_mod8 port map(
        clk => clk,
        reset => rst_cont_temp,
        enable => en_cont_temp,
        count => count_temp
    );
    
    ROM: entity work.rom port map(
        clk => clk,
        read => read_temp,
        addr => count_temp,
        data_out => in_m_temp
    );
    
    M: entity work.macchinaM port map(
        data_in => in_m_temp,
        data_out => out_m_temp
    );
    
    MEM: entity work.mem port map(
        clk => clk,
        input => out_m_temp,
        write_addr => count_temp,
        read_addr => count_temp,
        write_en => write_temp,
        output => output
    );

end Structural;
