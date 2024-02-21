----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2024 15:50:09
-- Design Name: 
-- Module Name: ripple_carry - Structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_carry is
	port( 
	    X, Y: in std_logic_vector(7 downto 0); -- Ingressi: due operandi a 8 bit da sommare.
        c_in: in std_logic; -- Ingresso: il riporto iniziale.
        c_out: out std_logic; -- Uscita: il riporto finale.
        Z: out std_logic_vector(7 downto 0) -- Uscita: risultato della somma a 8 bit.
   );
end ripple_carry;

architecture structural of ripple_carry is
	component full_adder is
        port(
            a,b: in std_logic;
            cin: in std_logic;
            cout, sum: out std_logic);
	end component;

	signal temp: std_logic_vector(7 downto 0);

begin

	RA0: full_adder port map(X(0), Y(0), c_in, temp(0), Z(0));

	RA1to6: FOR i IN 1 TO 6 GENERATE
			RA: full_adder port map(X(i), Y(i), temp(i-1), temp(i), Z(i));
			END GENERATE;

	RA7: full_adder port map(X(7), Y(7), temp(6), c_out, Z(7));

end structural;
