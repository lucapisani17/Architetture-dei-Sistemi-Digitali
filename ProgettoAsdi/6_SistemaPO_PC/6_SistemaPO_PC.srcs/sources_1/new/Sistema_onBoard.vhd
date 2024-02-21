library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sistema_onBoard is
    port(
        clock: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        Y: out std_logic_vector(3 downto 0);
        stop: out std_logic
    );
end Sistema_onBoard;

architecture Structural of Sistema_onBoard is

    component ButtonDebouncer is
        generic(
            CLK_period: integer := 10;
            btn_noise_time: integer := 10000000
        );
        port(
            RST: in std_logic;
            CLK: in std_logic;
            BTN: in std_logic;
            CLEARED_BTN: out std_logic -- segnale di output ripulito
        );
    end component;
    
    component sistemaPO_PC is
        port(
            clk: in std_logic;
            reset: in std_logic;
            start: in std_logic;
            output: out std_logic_vector(3 downto 0);
            stop: out std_logic
        );
    end component;
   
    signal cleared_start: std_logic;

begin

    deb_s: ButtonDebouncer generic map(
            CLK_period => 10,
            btn_noise_time => 10000000
        )
        port map(
            RST => reset,
            CLK => clock,
            BTN => start,
            CLEARED_BTN => cleared_start
    );
    
    sys: sistemaPO_PC port map(
            clk => clock,
            reset => reset,
            start => cleared_start,
            output => Y,
            stop => stop
        );

end Structural;
