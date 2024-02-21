----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.02.2024 18:05:14
-- Design Name: 
-- Module Name: riconoscitore4bit - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity riconoscitore4bit is
  Port (
  signal datain: in std_logic_vector(3 downto 0);
  signal trigger: out std_logic; 
  signal en_count: out std_logic;
  signal write: in std_logic     
   );
end riconoscitore4bit;

architecture Behavioral of riconoscitore4bit is
constant X : integer := 6;
begin

process(write)

begin
en_count<='0';
trigger<='0';

    if (write='1') then
        if to_integer(unsigned(datain))>X then
            en_count<='1';
        else 
            trigger<='1';
        end if;
    end if;
end process;
    

end Behavioral;
