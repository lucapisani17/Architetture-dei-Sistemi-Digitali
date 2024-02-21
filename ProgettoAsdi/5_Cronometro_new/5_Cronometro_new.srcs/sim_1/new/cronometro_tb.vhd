library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Testbench Entity
ENTITY tb_cronometro IS
END tb_cronometro;

-- Testbench Architecture
ARCHITECTURE behavior OF tb_cronometro IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT cronometro
    PORT(
        clk : IN  std_logic;
        rst : IN  std_logic;
        set : IN  std_logic;
        in_sec : IN  std_logic_vector(5 downto 0);
        in_min : IN  std_logic_vector(5 downto 0);
        in_ore : IN  std_logic_vector(4 downto 0);
        out_sec : OUT  std_logic_vector(5 downto 0);
        out_min : OUT  std_logic_vector(5 downto 0);
        out_ore : OUT  std_logic_vector(4 downto 0)
    );
    END COMPONENT;
   
    --Inputs
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal set : std_logic := '0';
    signal in_sec : std_logic_vector(5 downto 0) := (others => '0');
    signal in_min : std_logic_vector(5 downto 0) := (others => '0');
    signal in_ore : std_logic_vector(4 downto 0) := (others => '0');

    --Outputs
    signal out_sec : std_logic_vector(5 downto 0);
    signal out_min : std_logic_vector(5 downto 0);
    signal out_ore : std_logic_vector(4 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: cronometro PORT MAP (
        clk => clk,
        rst => rst,
        set => set,
        in_sec => in_sec,
        in_min => in_min,
        in_ore => in_ore,
        out_sec => out_sec,
        out_min => out_min,
        out_ore => out_ore
    );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Testbench statements
    stim_proc: process
    begin       
        -- test reset
        rst <= '1';
        wait for clk_period*2;
        rst <= '0';
 

        -- Set initial time (optional)
        set <= '1';
        in_sec <= "110000"; --esempio: imposta 48 minuti
        in_min <= "000010"; -- esempio: imposta 2 minuti
        in_ore <= "00001";  -- esempio: imposta 1 ora
        wait for clk_period*2;
        set <= '0';

        -- Attendi per un periodo di tempo per osservare il funzionamento del cronometro
        wait for 100000 * clk_period;

        -- Termina la simulazione
        wait;
    end process;

END behavior;
