library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity COMPARATORE_Testbench is
end COMPARATORE_Testbench;

architecture Behavioral of COMPARATORE_Testbench is
    -- Component declaration for the unit under test (UUT)
    component COMPARATORE
        Port (
            clk : in std_logic;
            rst : in std_logic;
            start : in std_logic;
            stringaA : in std_logic_vector(7 downto 0);
            stringaB : in std_logic_vector(7 downto 0);
            count : out integer range 0 to 8
        );
    end component;

    -- Clock signal declaration
    signal clk_tb : std_logic := '0';
    constant clk_period : time := 10 ns;

    -- Testbench signals
    signal rst_tb, start_tb : std_logic;
    signal stringaA_tb, stringaB_tb : std_logic_vector(7 downto 0);
    signal count_tb : integer range 0 to 8;

begin
    -- Instantiate the unit under test (UUT)
    uut : COMPARATORE
        port map (
            clk => clk_tb,
            rst => rst_tb,
            start => start_tb,
            stringaA => stringaA_tb,
            stringaB => stringaB_tb,
            count => count_tb
        );

    -- Clock process
    clk_process : process
    begin
        while now < 1000 ns loop
            clk_tb <= not clk_tb;
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stimulus : process
    begin
        rst_tb <= '1';
        wait for 10 ns;
        rst_tb <= '0';
        
        wait for 10 ns;
        start_tb <= '1';
        stringaA_tb <= "11001010";
        stringaB_tb <= "11001111";
        wait for 20 ns;

--        rst_tb <= '0';
--        wait for 10 ns;

--        start_tb <= '1';
--        stringaA_tb <= "11001010";
--        stringaB_tb <= "11001111";
--        wait for 100 ns;

        -- Add additional test cases as needed

        wait;
    end process;

end Behavioral;
