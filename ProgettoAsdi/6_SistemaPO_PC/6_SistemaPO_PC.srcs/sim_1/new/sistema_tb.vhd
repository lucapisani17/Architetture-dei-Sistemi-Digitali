LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY sistemaPO_PC_tb IS
END sistemaPO_PC_tb;

ARCHITECTURE behavior OF sistemaPO_PC_tb IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT sistemaPO_PC
    PORT(
        clk : IN  std_logic;
        reset : IN  std_logic;
        start : IN  std_logic;
        output : OUT  std_logic_vector(3 downto 0)
    );
    END COMPONENT;
    
    --Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal start : std_logic := '0';

    --Outputs
    signal output : std_logic_vector(3 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: sistemaPO_PC PORT MAP (
        clk => clk,
        reset => reset,
        start => start,
        output => output
    );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset state for 100 ns.
        wait for 100 ns;	
        reset <= '1';
        wait for 100 ns;
        reset <= '0';

        -- insert other stimulus here 
        start <= '1';
        wait for 20 ns;
        start <= '0';

        wait for 500 ns;
        wait;
    end process;

END;
