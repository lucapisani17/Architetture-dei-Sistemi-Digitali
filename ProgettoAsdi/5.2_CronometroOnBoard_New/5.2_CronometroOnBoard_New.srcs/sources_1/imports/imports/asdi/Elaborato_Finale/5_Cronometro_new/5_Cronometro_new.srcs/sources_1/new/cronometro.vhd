library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cronometro is
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
end cronometro;

architecture Structural of cronometro is

    -- Segnali interni per abilitare i contatori e per segnalare il conteggio massimo.
    signal en_sec: std_logic := '0';
    signal en_min: std_logic := '0';
    signal en_ore: std_logic := '0';
    signal count_sec: std_logic := '0';
    signal count_min: std_logic := '0';
    signal count_ore: std_logic := '0';
    
    component clock_filter
        generic(
			CLKIN_freq : integer := 100000000; -- Frequenza di clock della scheda (100MHz).
			CLKOUT_freq : integer := 500       -- Frequenza desiderata di output (1Hz).
				);
        Port ( 
           clock_in : in  STD_LOGIC;          -- Clock in ingresso.
		   reset : in STD_LOGIC;             -- Segnale di reset.
           clock_out : out  STD_LOGIC         -- Clock ridotto in uscita.
        ); 
    end component;
        
    component counter
        generic(
            modulo: integer := 8;             
            n: integer := 3                  
        );
        port(
            clk: in std_logic;             
            reset: in std_logic;             
            enable: in std_logic;            
            load: in std_logic;              
            input: in std_logic_vector(n-1 downto 0); 
            y: out std_logic_vector(n-1 downto 0);    
            countMax: out std_logic          
        );
    end component;
    
begin

    -- Instanziazione del componente clock_filter per generare il segnale "en_sec".
    base_dei_tempi: clock_filter
        generic map( 100000000, 1)
        port map(
            clock_in => clk,
            reset => rst,
            clock_out => en_sec
        );
        
    counter_secondi: counter
        generic map(
            60,                             -- Conta fino a 60 per i secondi.
            6                               -- Larghezza del contatore di 6 bit.
        )
        port map(
            clk => clk,
            reset => rst,
            enable => en_sec,
            load => set,
            input => in_sec,
            y => out_sec,
            countMax => count_sec
        );
        
    -- Abilitazione del contatore dei minuti quando i secondi raggiungono il massimo.
    en_min <= en_sec and count_sec;
    
    counter_minuti: counter
        generic map(
            60,                             -- Conta fino a 60 per i minuti.
            6                               -- Larghezza del contatore di 6 bit.
        )
        port map(
            clk => clk,
            reset => rst,
            enable => en_min,
            load => set,
            input => in_min,
            y => out_min,
            countMax => count_min
        ); 
     
    -- Abilitazione del contatore delle ore quando i minuti raggiungono il massimo.
    en_ore <= en_sec and en_min and count_min;
     
    counter_ore: counter
        generic map(
            24,                             -- Conta fino a 24 per le ore.
            5                               -- Larghezza del contatore di 5 bit.
        )
        port map(
            clk => clk,
            reset => rst,
            enable => en_ore,
            load => set,
            input => in_ore,
            y => out_ore,
            countMax => count_ore
        );

end Structural;
