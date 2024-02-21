library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unita_A is
    port(
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        
        TXD: out std_logic
    );
end Unita_A;

architecture Structural of Unita_A is

    signal en_count_temp: std_logic;
    signal count_temp: std_logic_vector(2 downto 0);
    signal WR_temp: std_logic;
    signal rom_out_temp: std_logic_vector(7 downto 0);
    signal TBE_temp: std_logic;

begin

    CU: entity work.CU_A 
        port map(
            reset => reset,
            clk => clk,
            start => start,
            TBE => TBE_temp,
            count => count_temp,
            en_count => en_count_temp,
            WR => WR_temp
        );
        
    cont: entity work.counter_mod8
        port map(
            clk => clk,
            reset => reset,
            enable => en_count_temp,
            count => count_temp
        );
    
    ROM: entity work.rom 
        port map(
            addr => count_temp,
            data_out => rom_out_temp
        );
    
    UART_A: entity work.Rs232RefComp
        port map(
            RXD => '0', --non ci sono dati in arrivo
            CLK => clk,
            DBIN => rom_out_temp,
            TBE => TBE_temp,
            RD => '1',
            WR => WR_temp,
            RST => reset,
            TXD => TXD
        );

end Structural;
