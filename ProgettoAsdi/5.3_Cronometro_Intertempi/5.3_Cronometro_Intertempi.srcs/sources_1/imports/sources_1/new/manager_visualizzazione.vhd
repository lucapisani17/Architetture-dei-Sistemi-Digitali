library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity manager_visualizzazione is
    port(
        clk: in std_logic;
        reset: in std_logic;
        sec_in: in std_logic_vector(5 downto 0);
        min_in: in std_logic_vector(5 downto 0);
        ore_in: in std_logic_vector(4 downto 0);
        anodi: out std_logic_vector(7 downto 0);
        catodi: out std_logic_vector(7 downto 0)
    );
end manager_visualizzazione;

architecture Structural of manager_visualizzazione is

    component encoder is
        port(
            sec_in: in std_logic_vector(5 downto 0);
            min_in: in std_logic_vector(5 downto 0);
            ore_in: in std_logic_vector(4 downto 0);
            value_out: out std_logic_vector(31 downto 0)
        );
    end component;
    
    component display_seven_segments is
        Generic( 
            CLKIN_freq : integer := 100000000; 
            CLKOUT_freq : integer := 500
        );
        Port ( CLK : in  STD_LOGIC;
               RST : in  STD_LOGIC;
               VALUE : in  STD_LOGIC_VECTOR (31 downto 0);
               ENABLE : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
               DOTS : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare
               ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
               CATHODES : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;
  
    signal value_out_temp: std_logic_vector(31 downto 0) := (others => '0');

begin
    
    enc: encoder
        port map(
            sec_in => sec_in,
            min_in => min_in,
            ore_in => ore_in,
            value_out => value_out_temp
        );
    
    dis: display_seven_segments
        generic map(
            CLKIN_freq => 100000000,
            CLKOUT_freq => 500
        )
        port map(
            CLK => clk,
            RST => reset,
            VALUE => value_out_temp,
            ENABLE => "00111111", --accendiamo tutte le cifre tranne le prime due
            DOTS => "00010100", --accendiamo solo i punti tra ore e min e tra min e sec
            ANODES => anodi,
            CATHODES => catodi
        );
    
end Structural;
