library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ROM is port( 
	CLK: in std_logic;
	write_rom: in std_logic;
	ADDRESS: in std_logic_vector(2 downto 0);
	data_in: in std_logic_vector(7 downto 0)
);
end ROM;

architecture Behavioral of ROM is
TYPE registri is array (7 downto 0) of std_logic_vector(7 downto 0);
signal memoria : registri := (	
				("00000000"),
				("00000000"),
				("00000000"),
				("00000000"),
				("00000000"),
				("00000000"),
				("00000000"),
				("00000000") 
				);

begin
	memo_behavioral: process(CLK)
	begin
		if(rising_edge(CLK)) then
			if(write_rom = '1') then
				memoria(conv_integer(ADDRESS)) <= data_in;
			end if;
		end if;
	end process;
end Behavioral;
