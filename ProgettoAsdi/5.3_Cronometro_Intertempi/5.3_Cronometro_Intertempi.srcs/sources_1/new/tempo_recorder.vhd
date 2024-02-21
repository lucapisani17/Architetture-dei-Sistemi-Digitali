library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tempo_recorder is
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
end tempo_recorder;

architecture Structural of tempo_recorder is

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

    component manager_intertempi
         port(
            clk: in std_logic;
            reset: in std_logic;
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

signal sec_temp: std_logic_vector(5 downto 0) := (others => '0');
signal min_temp: std_logic_vector(5 downto 0) := (others => '0');
signal ore_temp: std_logic_vector(4 downto 0) := (others => '0');

begin

    cron: cronometro
        port map(
            clk => clk,
            rst => reset,
            set => set,
            in_sec => sec_in,
            in_min => min_in,
            in_ore => ore_in,
            out_sec => sec_temp,
            out_min => min_temp,
            out_ore => ore_temp
        );
        
        
    mi: manager_intertempi
        port map(
            clk => clk,
            reset => reset,
            save => save,
            show => show,
            sec_in => sec_temp,
            min_in => min_temp,
            ore_in => ore_temp,
            sec_out => sec_out,
            min_out => min_out,
            ore_out => ore_out
        );

end Structural;
