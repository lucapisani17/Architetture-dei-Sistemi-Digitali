library ieee;
use ieee.std_logic_1164.all;

entity Comparatore is
    port (
        input_string : in  std_logic_vector(3 downto 0);
        output_string : out std_logic_vector(3 downto 0)
    );
end entity Comparatore;

architecture Behavioral of Comparatore is
begin
    process(input_string)
    begin
        if input_string = "1111" then
            output_string <= "0000";
            else
            output_string <= input_string; 
        end if;
    end process;
end architecture Behavioral;
