library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DESIGN_tb is
end DESIGN_tb;

architecture behavioral of DESIGN_tb is
    -- Component declaration for the design under test
    component DESIGN
        Port (
            clk: in std_logic;
            rst: in std_logic;
            start: in std_logic;
            cop: in std_logic_vector(1 downto 0);
            op1: in std_logic_vector(7 downto 0);
            X: in std_logic_vector(7 downto 0);
            op2: in std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals for the test bench
    signal clk_tb: std_logic := '0';
    signal rst_tb: std_logic := '0';
    signal start_tb: std_logic := '0';
    signal cop_tb: std_logic_vector(1 downto 0) := (others => '0');
    signal op1_tb: std_logic_vector(7 downto 0) := (others => '0');
    signal X_tb: std_logic_vector(7 downto 0) := (others => '0');
    signal op2_tb: std_logic_vector(7 downto 0) := (others => '0');
    
   -- Clock period definitions
   constant CLK_period : time := 10 ns;
begin
    -- Instantiate the design under test
    DUT: DESIGN
        port map (
            clk => clk_tb,
            rst => rst_tb,
            start => start_tb,
            cop => cop_tb,
            op1 => op1_tb,
            X => X_tb,
            op2 => op2_tb
        );

    -- Clock process
  CLK_process :process
   begin
		clk_tb <= '0';
		wait for CLK_period/2;
		clk_tb <= '1';
		wait for CLK_period/2;
   end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Initialize inputs
--        rst_tb <= '1';
--        start_tb <= '0';
--        cop_tb <= (others => '0');
--        op1_tb <= (others => '0');
--        X_tb <= (others => '0');
--        op2_tb <= (others => '0');

--        -- Wait for reset to finish
--        wait until rising_edge(clk_tb);
--        rst_tb <= '0';

         --Provide stimulus
        --caso della somma < di X
        cop_tb <= "00";  -- Example value for cop
        op1_tb <= "01010101";  -- Example value for op1 --85
        X_tb <= "11110000";  -- Example value for X --240
        op2_tb <= "00101010";  -- Example value for op2 -- 42
        wait until rising_edge(clk_tb);
        start_tb <= '1';
        
--        wait for 200ns;

--------         --caso della sottrazione < di X
--        cop_tb <= "11";  -- Example value for cop
--        op1_tb <= "10010011";  -- Example value for op1 --147
--        X_tb <= "11110000";  -- Example value for X --240
--        op2_tb <= "10010011";  -- Example value for op2 -- 147
--        wait until rising_edge(clk_tb);
--        start_tb <= '1';
        
--        wait for 200ns;

----         --caso della somma > di X
--        cop_tb <= "00";  -- Example value for cop
--        op1_tb <= "10010011";  -- Example value for op1 --147
--        X_tb <= "11110000";  -- Example value for X --240
--        op2_tb <= "01100100";  -- Example value for op2 -- 100
--        wait until rising_edge(clk_tb);
--        start_tb <= '1';
        

        
        
        



        -- End stimulus
        --start_tb <= '0';

        -- Further stimulus and checks can be added here

        -- End simulation
        wait;
    end process;
end behavioral;
