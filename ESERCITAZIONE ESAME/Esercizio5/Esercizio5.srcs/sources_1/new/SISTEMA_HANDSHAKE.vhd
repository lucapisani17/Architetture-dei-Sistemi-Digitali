----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.02.2024 18:48:39
-- Design Name: 
-- Module Name: SISTEMA_HANDSHAKE - structural
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
    signal clk: in std_logic;
    signal rst: in std_logic;
    signal start: in std_logic
     );
end SISTEMA_HANDSHAKE;

architecture structural of SISTEMA_HANDSHAKE is
signal acktemp: std_logic;
signal strobetemp: std_logic;
signal datalink: std_logic;

begin

SistemaA: entity work.SistemaA port map(
    clk=>clk,
    rst=>rst,
    start=>start,
    ack=>acktemp,
    strobe=>strobetemp,
    data_to_B=>datalink
);

SistemaB:entity work.SistemaB port map(
    datafromA=>datalink,
    clk=>clk,
    rst=>rst,
    strobe=>strobetemp,
    ack=>acktemp
);

end structural;
