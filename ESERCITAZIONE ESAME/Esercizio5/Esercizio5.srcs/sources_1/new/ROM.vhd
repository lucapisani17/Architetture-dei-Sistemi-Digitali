library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ROM is port( 
	CLK: in std_logic;
	READ_ROM: in std_logic;
	ADDRESS: in std_logic_vector(2 downto 0);
	DATA_OUT: out std_logic_vector(3 downto 0)
);
end ROM;

architecture Behavioral of ROM is
TYPE registri is array (7 downto 0) of std_logic_vector(3 downto 0);
signal memoria : registri := (	
				("0001"),
				("0101"),
				("0011"),
				("1001"),
				("1001"),
				("0101"),
				("1001"),
				("0101") 
				);

begin
	memo_behavioral: process(CLK)
	begin
		if(rising_edge(CLK)) then
			if(READ_ROM = '1') then
				DATA_OUT <= memoria(conv_integer(ADDRESS));
			end if;
		end if;
	end process;
end Behavioral;
