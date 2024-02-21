library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registro_intertempi is
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
end registro_intertempi;

architecture Behavioral of registro_intertempi is

    component shift_register
        generic (
            n   : integer := 8
        );
        port(
            clk, reset : in std_logic;
            enable : in std_logic;
            input : in std_logic;
            Y : out std_logic_vector(n-1 downto 0)
            );
    end component;
    
    component mux_8_1
        port( 
            data : in STD_LOGIC_VECTOR (7 downto 0);
            sel : in STD_LOGIC_VECTOR (2 downto 0);
            output : out STD_LOGIC
           );
    end component;
    
    type out_array is array (N-1 downto 0) of std_logic_vector(6 downto 0);
    signal output_temp: out_array;
     
begin
    
    sr_n_1_to_0: for i in N-1 downto 0 generate
        
        sr_i: shift_register
        generic map(7)
        port map(
            clk => clk,
            reset => reset,
            enable => en,
            input => data_in(i),
            Y => output_temp(i)
        );
        
        mux_i: mux_8_1 port map(
            data => output_temp(i) & data_in(i),
            sel => sel,
            output => data_out(i)
        );
    
   end generate;

end Behavioral;
