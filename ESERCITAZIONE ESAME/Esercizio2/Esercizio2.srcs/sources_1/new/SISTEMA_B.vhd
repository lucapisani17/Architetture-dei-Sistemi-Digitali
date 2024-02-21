----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.02.2024 12:17:02
-- Design Name: 
-- Module Name: SISTEMA_B - Structural
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

entity SISTEMA_B is
  Port ( 
  signal clk: in std_logic;
  signal rst: in std_logic;
  signal strobe : in std_logic;
  
  signal ack: out std_logic;
  signal datafromA: in std_logic_vector(3 downto 0)
  );
end SISTEMA_B;

architecture Structural of SISTEMA_B is
signal comptoB: std_logic_vector(3 downto 0);
signal en_count_temp: std_logic;
signal counterout: std_logic_vector(2 downto 0);

begin

COMP: entity work.comparatore port map(
    input_string=>datafromA,
    output_string=>comptoB
);

CU_B: entity work.Cu_b port map(
count=>counterout,
en_count=>en_count_temp,
    clk=>clk,
    rst=>rst,
    strobe=>strobe,
    ack=>ack,
    datafromA=>comptoB
);

COUNT: entity work.counter_mod8 port map(
    clk=>clk,
    reset=>rst,
    enable=>en_count_temp,
    count=>counterout
);

end Structural;
