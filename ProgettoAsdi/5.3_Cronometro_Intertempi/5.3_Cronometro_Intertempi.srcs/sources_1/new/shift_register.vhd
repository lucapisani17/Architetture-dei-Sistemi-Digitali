library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
    generic (
        n   : integer := 8
    );
    port(
        clk, reset : in std_logic;
        enable : in std_logic;
        input : in std_logic;
        Y : out std_logic_vector(n-1 downto 0)
        );
end shift_register;

architecture Behavioral of shift_register is
    signal temp_Y: std_logic_vector(n-1 downto 0);
begin

    sh_reg : process (clk)
    begin
        if rising_edge(clk) then
            if (reset='1') then
                temp_Y <= (others=>'0');
            elsif( enable = '1') then-- shift di una poszione
                    temp_Y(n-1) <= input ;
                    temp_Y(n-2 downto 0) <= temp_Y(n-1 downto 1);
            end if;
        end if;

      end process;
      Y <= temp_Y;
         

end Behavioral;
