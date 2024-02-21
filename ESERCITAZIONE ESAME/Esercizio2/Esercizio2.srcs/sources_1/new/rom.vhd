library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom is
    generic (
        k : integer := 2
    );
    port (
        addr: in std_logic_vector(2 downto 0);
        data_out: out std_logic_vector(3 downto 0)
    );
end rom;

architecture Behavioral of rom is

    type rom_type is array (0 to 7) of std_logic_vector(3 downto 0);
    signal ROM: rom_type := (
        ("0101"), 
        ("0000"), 
        ("1001"), 
        ("1010"), 
        ("0100"),
        ("0000"),
        ("1111"), 
        ("1100")
    );

begin
    data_out <= std_logic_vector(ROM(conv_integer(addr)+ k) );
    
end Behavioral;
