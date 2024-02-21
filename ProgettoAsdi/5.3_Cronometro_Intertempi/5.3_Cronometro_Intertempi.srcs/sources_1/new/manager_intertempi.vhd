library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity manager_intertempi is
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
end manager_intertempi;

architecture Structural of manager_intertempi is

    component registro_intertempi
        generic(
            N: integer := 8 --numero di registri
        );
        port(
            clk: in std_logic;
            reset: in std_logic;
            en: in std_logic;
            sel: in std_logic_vector(2 downto 0);
            data_in: in std_logic_vector(N-1 downto 0);
            data_out: out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    component counter_mod8
        Port(
            clock : in  STD_LOGIC;
            reset : in  STD_LOGIC;
		    enable : in STD_LOGIC; 
            counter : out  STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;
    
    component ButtonDebouncer
        generic(
            CLK_period: integer := 10; -- periodo del clock della board (in nanosecondi)
            btn_noise_time: integer := 10000000 -- durata stimata dell'oscillazione del bottone
                                                -- il valore di default è 10 millisecondi
        );
        port(
            RST: in std_logic;
            CLK: in std_logic;
            BTN: in std_logic;
            CLEARED_BTN: out std_logic -- segnale di output ripulito
        );
    end component;

    signal show_en_temp: std_logic := '0';
    signal save_en_temp: std_logic := '0';
    signal sel_temp: std_logic_vector(2 downto 0) := (others => '0');
    
begin

    deb_show: ButtonDebouncer port map(
        RST => reset,
        CLK => clk,
        BTN => show,
        CLEARED_BTN => show_en_temp
    );
    
    deb_save: ButtonDebouncer port map(
        RST => reset,
        CLK => clk,
        BTN => save,
        CLEARED_BTN => save_en_temp
    );
    
    counter: counter_mod8 port map(
        clock => clk,
        reset => reset,
        enable => show_en_temp,
        counter => sel_temp
    );
    
    reg_s: registro_intertempi
    generic map(6)
    port map(
        clk => clk,
        reset => reset,
        en => save_en_temp,
        sel => sel_temp,
        data_in => sec_in,
        data_out => sec_out
    );
    
    reg_m: registro_intertempi
    generic map(6)
    port map(
        clk => clk,
        reset => reset,
        en => save_en_temp,
        sel => sel_temp,
        data_in => min_in,
        data_out => min_out
    );
    
    reg_o: registro_intertempi
    generic map(5)
    port map(
        clk => clk,
        reset => reset,
        en => save_en_temp,
        sel => sel_temp,
        data_in => ore_in,
        data_out => ore_out
    );


end Structural;
