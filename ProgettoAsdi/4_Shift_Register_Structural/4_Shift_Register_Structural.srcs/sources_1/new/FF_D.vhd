library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FF_D is
	port( 
	   clk, reset, d: in std_logic;
       y: out std_logic :='0'
       );
end FF_D;

architecture behavioural of FF_D is

	begin

	FFD: process(clk)
		  begin
			if rising_edge(clk) then
		       if(reset='1') then
				  y<='0';
			   else
			      y<=d;
			   end if;
			end if;
		  end process;


	end behavioural;