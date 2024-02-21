library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registro_M is
    port (
        clk : in std_logic;
        rst : in std_logic;
        load : in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
end entity registro_M;

architecture Behavioral of registro_M is
    signal m_reg : std_logic_vector(7 downto 0);
begin
    process(clk)
    begin
        if (clk'event and clk='1') then
            if rst = '1' then      
                m_reg <= (others => '0');
            elsif load = '1' then 
                m_reg <= data_in;
            end if;
        end if;
    end process;
    data_out <= m_reg;

end architecture;
