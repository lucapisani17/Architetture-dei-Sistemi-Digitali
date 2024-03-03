library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.MATH_REAL.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity MemoriaRW is generic(
	NumeroLocazioni: integer := 8;
	LunghezzaWord: integer := 8
	);
	port( 
	CLK: in std_logic;
	RST: in std_logic;
	--R: in std_logic;	--Read
	W: in std_logic;	--Write
	ADDRESS: in std_logic_vector(integer(ceil(log2(real(NumeroLocazioni))))-1 downto 0);
	DATA_INPUT: in std_logic_vector(LunghezzaWord-1 downto 0)
	--DATA_OUT: out std_logic_vector(LunghezzaWord-1 downto 0)
);
end MemoriaRW;

architecture Behavioral of MemoriaRW is
TYPE registri is array (NumeroLocazioni-1 downto 0) of std_logic_vector(LunghezzaWord-1 downto 0);
signal memoria : registri; 

begin
	
	memo_behavioral: process(CLK)
	begin
		if(rising_edge(CLK)) then
			if(RST = '1') then
				for k in 0 to NumeroLocazioni-1 loop 
					memoria(k) <= (others =>'0');
				end loop;
			elsif(W = '1') then
				memoria(conv_integer(ADDRESS)) <= DATA_INPUT;
			end if;
		end if;
	end process;
end Behavioral;
