library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
    port(
        CLK, RST : in std_logic;
        SI: IN std_logic_vector(3 downto 0);
        shift: in std_logic;
        load: in std_logic;
        SO : out std_logic
    );
end shift_register;

architecture archi of shift_register is
    signal tmp: std_logic_vector(3 downto 0);
    signal shiftedbit: std_logic;
begin
    process (CLK)
    begin
        if (rising_edge(CLK)) then
            if (RST = '1') then
                tmp <= (others => '0');
            else
                if load = '1' then 
                    tmp <= SI;
                elsif shift = '1' then
                    shiftedbit <= tmp(0);
                    tmp <= '0' & tmp(3 downto 1);
                end if;
            end if;
        end if;
    end process;
    SO <= shiftedbit;
end archi;
