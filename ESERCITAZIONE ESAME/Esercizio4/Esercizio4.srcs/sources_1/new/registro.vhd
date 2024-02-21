
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Registro is generic(
	M: integer := 4
); port(
	CLK: in std_logic;
    RST: in std_logic;
	input: in std_logic_vector(M-1 downto 0);
	enable: in std_logic;
	output: out std_logic_vector(M-1 downto 0)
);
end Registro;

architecture Behavioral of Registro is
signal reg: std_logic_vector(M-1 downto 0) := (others => 'U');

begin
	reg_behavioral: process(CLK)
	begin
		if(rising_edge(CLK)) then
			if(RST = '1') then
				reg <= (others =>'0');
			elsif(enable = '1') then
				reg <= input;
			end if;
		end if;
	end process;
	output <= reg;
end Behavioral;
