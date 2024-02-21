    
    ----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.02.2024 16:10:08
-- Design Name: 
-- Module Name: CUB - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CUA is
  Port ( 
  SIGNAL clk: in std_logic;
  signal rst: in std_logic;
  sIgnal load: out std_logic;
  signal ack: in std_logic;
  signal strobe: out std_logic
  );
end CUA;

architecture Behavioral of CUA is

begin


end Behavioral;
