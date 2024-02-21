library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SISTEMA_HANDSHAKE is 
port (
    signal clk: in std_logic;
    signal rst: in std_logic;
    signal start: in std_logic
    );
end SISTEMA_HANDSHAKE;

architecture structural of SISTEMA_HANDSHAKE is

signal ack_temp : std_logic;
signal strobe_temp: std_logic;
signal dataC_temp: std_logic_vector(7 downto 0);
signal dataX_temp: std_logic_vector(3 downto 0);

begin

SISTEMA_A: entity work.SISTEMA_A port map(
    start=>start,
    clk=>clk,
    rst=>rst,
    ack=>ack_temp,
    strobe=>strobe_temp,
    dataC=>dataC_temp,
    dataX=>dataX_temp
);

SISTEMA_B: entity work.SISTEMA_B port map(
    clk=>clk,
    rst=>rst,
    ack=>ack_temp,
    strobe=>strobe_temp,
    datain_C=>dataC_temp,
    datain_X=>dataX_temp
    );

end structural;