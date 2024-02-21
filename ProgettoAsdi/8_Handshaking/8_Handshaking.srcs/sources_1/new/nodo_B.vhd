library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodo_B is
    port(
        clk: in std_logic;
        reset: in std_logic;
        strobe: in std_logic;
        data_in: in std_logic_vector(7 downto 0);
        ack: out std_logic
    );
end nodo_B;

architecture Structural of nodo_B is

signal en_count_temp: std_logic;
signal en_write_temp: std_logic;
signal count_temp: std_logic_vector(2 downto 0);
signal data_Y: std_logic_vector(7 downto 0);
signal res_Z: std_logic_vector(7 downto 0);
signal cout_temp: std_logic;
signal input_temp: std_logic_vector(8 downto 0);
signal out_temp: std_logic_vector(8 downto 0);

begin

    unita_controllo: entity work.CU_B port map(
        clk => clk,
        reset => reset,
        strobe => strobe,
        count => count_temp,
        en_count => en_count_temp,
        en_write => en_write_temp,
        ack => ack
    );
    
    ROM: entity work.rom port map(
        clk => clk,
        read => '1',
        addr => count_temp,
        data_out => data_Y
    );
    
    contatore: entity work.counter_mod8 port map(
        clk => clk,
        reset => reset,
        enable => en_count_temp,
        count => count_temp
    );
    
    adder: entity work.adder_sub port map(
        X => data_in,
        Y => data_Y,
        cin => '0',
        Z => res_Z,
        cout => cout_temp
    );
    
    MEM: entity work.mem port map(
        clk => clk,
        reset => reset,
        input => cout_temp & res_Z,
        write_addr => count_temp,
        read_addr => count_temp,
        write_en => en_write_temp,
        output => out_temp
    );
    
    


end Structural;
