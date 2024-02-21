library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity rom is
    port(
        addr: in std_logic_vector(2 downto 0);
        data_outC: out std_logic_vector(7 downto 0);
        data_outX: out std_logic_vector(3 downto 0)
    );
    
    
end rom;

architecture Behavioral of rom is

type rom_type is array (0 to 7) of std_logic_vector(11 downto 0);
signal ROM: rom_type := (
    ("110101010101"), 
    ("001110011001"), 
    ("111000111000"), 
    ("010101010101"), 
    ("100100100100"),
    ("011011011011"),
    ("000111000111"), 
    ("101010101010")
);

begin

    data_outC <= ROM(conv_integer(addr))(7 downto 0);
    data_outX <= ROM(conv_integer(addr))(11 downto 8);

end Behavioral;
