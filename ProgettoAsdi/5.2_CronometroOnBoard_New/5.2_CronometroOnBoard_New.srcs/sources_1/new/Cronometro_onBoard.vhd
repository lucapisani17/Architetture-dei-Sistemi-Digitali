library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Cronometro_onBoard is
    port(
        clk: in std_logic;
        reset: in std_logic;
        switches: in std_logic_vector(5 downto 0);
        btn_load: in std_logic;
        btn_set: in std_logic;
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
    
    component cronometro
        port(
            clk: in std_logic;                  -- Segnale di clock in ingresso.
            rst: in std_logic;                  -- Segnale di reset in ingresso.
            set: in std_logic;                  -- Segnale per impostare i valori iniziali.
            in_sec: in std_logic_vector(5 downto 0);  -- Valore iniziale per i secondi.
            in_min: in std_logic_vector(5 downto 0);  -- Valore iniziale per i minuti.
            in_ore: in std_logic_vector(4 downto 0);  -- Valore iniziale per le ore.
            out_sec: out std_logic_vector(5 downto 0); -- Output dei secondi.
            out_min: out std_logic_vector(5 downto 0); -- Output dei minuti.
            out_ore: out std_logic_vector(4 downto 0)  -- Output delle ore.
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
    
    cron: cronometro port map(
        clk => clk,
        rst => reset,
        set => btn_set,
        in_sec => sec_in_temp,
        in_min => min_in_temp,
        in_ore => ore_in_temp,
        out_sec => sec_out_temp,
        out_min => min_out_temp,
        out_ore => ore_out_temp
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
