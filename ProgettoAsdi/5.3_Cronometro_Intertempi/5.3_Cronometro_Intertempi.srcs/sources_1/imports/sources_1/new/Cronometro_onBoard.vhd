library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Cronometro_onBoard is
    port(
        clk: in std_logic;
        reset: in std_logic;
        switches: in std_logic_vector(5 downto 0);
        btn_load: in std_logic;
        btn_set: in std_logic;
        btn_show: in std_logic;
        btn_save: in std_logic;
        catodi: out std_logic_vector(7 downto 0);
        anodi: out std_logic_vector(7 downto 0)
    );
end Cronometro_onBoard;

architecture Structural of Cronometro_onBoard is

    component Blocco_acquisizione
        port(
            clk: in std_logic;
            reset: in std_logic;
            switches: in std_logic_vector(5 downto 0);
            load: in std_logic;
            sec_out: out std_logic_vector(5 downto 0);
            min_out: out std_logic_vector(5 downto 0);
            ore_out: out std_logic_vector(4 downto 0)
        );
    end component;
    
    component tempo_recorder
        port(
            clk: in std_logic;
            reset: in std_logic;
            set: in std_logic;
            save: in std_logic;
            show: in std_logic;
            sec_in: in std_logic_vector(5 downto 0);
            min_in: in std_logic_vector(5 downto 0);
            ore_in: in std_logic_vector(4 downto 0);
            sec_out: out std_logic_vector(5 downto 0);
            min_out: out std_logic_vector(5 downto 0);
            ore_out: out std_logic_vector(4 downto 0)
        );
    end component;
    
    component manager_visualizzazione
        port(
            clk: in std_logic;
            reset: in std_logic;
            sec_in: in std_logic_vector(5 downto 0);
            min_in: in std_logic_vector(5 downto 0);
            ore_in: in std_logic_vector(4 downto 0);
            anodi: out std_logic_vector(7 downto 0);
            catodi: out std_logic_vector(7 downto 0)
        );
    end component;
    
    signal sec_in_temp: std_logic_vector(5 downto 0) := (others => '0');
    signal min_in_temp: std_logic_vector(5 downto 0) := (others => '0');
    signal ore_in_temp: std_logic_vector(4 downto 0) := (others => '0');
    signal sec_out_temp: std_logic_vector(5 downto 0) := (others => '0');
    signal min_out_temp: std_logic_vector(5 downto 0) := (others => '0');
    signal ore_out_temp: std_logic_vector(4 downto 0) := (others => '0');

begin

    ba: Blocco_acquisizione port map(
        clk => clk,
        reset => reset,
        switches => switches,
        load => btn_load,
        sec_out => sec_in_temp,
        min_out => min_in_temp,
        ore_out => ore_in_temp
    );
    
    tr: tempo_recorder port map(
        clk => clk,
        reset => reset,
        set => btn_set,
        save => btn_save,
        show => btn_show,
        sec_in => sec_in_temp,
        min_in => min_in_temp,
        ore_in => ore_in_temp,
        sec_out => sec_out_temp,
        min_out => min_out_temp,
        ore_out => ore_out_temp
    );
    
    mv: manager_visualizzazione port map(
        clk => clk,
        reset => reset,
        sec_in => sec_out_temp,
        min_in => min_out_temp,
        ore_in => ore_out_temp,
        anodi => anodi,
        catodi => catodi
    );


end Structural;
