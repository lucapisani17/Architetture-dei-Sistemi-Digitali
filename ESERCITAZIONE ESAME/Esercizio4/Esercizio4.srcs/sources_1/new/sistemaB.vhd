----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.02.2024 16:10:08
-- Design Name: 
-- Module Name: sistemaB - structural
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

entity sistemaB is port(
  signal clk: in std_logic;
  signal rst: in std_logic;
  
  signal datainput : in std_logic;
  signal ack : out std_logic;
  
  signal strobe: in std_logic
  );
end sistemaB;

architecture structural of sistemaB is

begin




end structural;
