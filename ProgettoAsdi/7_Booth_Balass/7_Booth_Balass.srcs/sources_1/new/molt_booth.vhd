library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity molt_booth is
    port(
        X, Y: in std_logic_vector (7 downto 0);
        clock, reset, start: in std_logic;
        P: out std_logic_vector (15 downto 0);
        stop_cu: out std_logic
    );
end molt_booth;

architecture Structural of molt_booth is

    component unita_controllo is
        port(
            qi,qi_meno1: in std_logic;
            clock, reset, start: in std_logic;
            count: in std_logic_vector(2 downto 0);
            loadA, loadM, loadQ: out std_logic;
            resetRegs: out std_logic;
            shift: out std_logic;
            sub: out std_logic;
            count_in: out std_logic;
            stop_cu: out std_logic
        );
    end component;
    
    component unita_operativa is
        port(
            X, Y: in std_logic_vector (7 downto 0);
            clock, reset: in std_logic;
            loadQ, loadA, loadM: in std_logic;
            shift: in std_logic;
            sub: in std_logic;
            count_in: in std_logic;
            count: out std_logic_vector (2 downto 0);
            P: out std_logic_vector(15 downto 0);
            qi, qi_meno1: out std_logic  
        );
    end component;
    
    component ButtonDebouncer is
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

    signal tmp_qi, tmp_qi_meno1: std_logic;    
    signal tmp_count: std_logic_vector(2 downto 0);
    signal tmp_loadA, tmp_loadM, tmp_loadQ: std_logic;
    signal tmp_shift: std_logic;
    signal tmp_resetRegs: std_logic;
    signal tmp_sub: std_logic;
    signal tmp_count_in, tmp_stop_cu: std_logic;
    signal cleared_start: std_logic;

begin

    UC: unita_controllo port map(tmp_qi, tmp_qi_meno1,clock,reset,cleared_start,tmp_count,tmp_loadA,tmp_loadM,tmp_loadQ,tmp_resetRegs,tmp_shift,tmp_sub,tmp_count_in, tmp_stop_cu);
    UO: unita_operativa port map(X,Y,clock,tmp_resetRegs,tmp_loadQ,tmp_loadA,tmp_loadM,tmp_shift,tmp_sub,tmp_count_in,tmp_count,P,tmp_qi,tmp_qi_meno1);
    
    deb: ButtonDebouncer port map(
        RST => '0',
        CLK => clock,
        BTN => start,
        CLEARED_BTN => cleared_start
    );
    
    stop_cu <= tmp_stop_cu or reset;

end Structural;
