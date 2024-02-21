----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.02.2024 12:46:36
-- Design Name: 
-- Module Name: SISTEMA_HANDSHAKE - STRUCTURAL
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

entity SISTEMA_HANDSHAKE is
  Port ( 
  signal start: in std_logic;
    signal clk: in std_logic;
    signal rst: in std_logic
  );
end SISTEMA_HANDSHAKE;

architecture STRUCTURAL of SISTEMA_HANDSHAKE is

signal acktemp: std_logic;
signal strobetemp: std_logic;
signal datatravel: std_logic_vector(3 downto 0);

begin

SISA: entity work.sistema_a port map(
start=>start,
    clk=>clk,
    rst=>rst,
    ack=>acktemp,
    strobe=>strobetemp,
    dataAtoB=>datatravel
);

SISB: entity work.sistema_b port map(
    clk=>clk,
    rst=>rst,
    ack=>acktemp,
    strobe=>strobetemp,
    datafromA=>datatravel
);

end STRUCTURAL;
