library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unita_B is
    port(
        clk: in std_logic;
        reset: in std_logic;
        RXD: in std_logic
    );
end Unita_B;

architecture Structural of Unita_B is

    signal RD_temp: std_logic;
    signal rst_temp: std_logic;
    signal RDA_temp: std_logic;
    signal en_count_temp: std_logic;
    signal count_temp: std_logic_vector(2 downto 0);
    signal en_write_temp: std_logic;
    signal data_mem_temp: std_logic_vector(7 downto 0);

begin

    CU: entity work.CU_B
        port map(
            clk => clk,
            reset => reset,
            RDA => RDA_temp,
            en_count => en_count_temp,
            en_write => en_write_temp,
            sys_rst => rst_temp,
            RD => RD_temp
        );
        
    cont: entity work.counter_mod8
        port map(
            clk => clk,
            reset => reset,
            enable => en_count_temp,
            count => count_temp
        );
        
    MEM: entity work.mem 
        port map(
            clk => clk,
            input => data_mem_temp,
            write_addr => count_temp,
            write_en => en_write_temp
        );
    
    UART_B: entity work.Rs232RefComp
        port map(
            RXD => RXD,
            CLK => clk,
            DBIN => (others => '0'),
            RD => RD_temp,
            WR => '0',
            RST => rst_temp,
            DBOUT => data_mem_temp,
            RDA => RDA_temp
        );

end Structural;
