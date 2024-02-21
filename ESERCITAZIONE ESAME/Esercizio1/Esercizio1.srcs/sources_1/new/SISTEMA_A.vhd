library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SISTEMA_A is 
port (
    signal clk: in std_logic;
    signal rst: in std_logic;
    signal ack: in std_logic;
    signal start: in std_logic;
    
    signal strobe: out std_logic;
    signal dataC: out std_logic_vector(7 downto 0);
    signal dataX: out std_logic_vector(3 downto 0)
        
    );
end SISTEMA_A;

architecture Structural of SISTEMA_A is

signal counter_to_rom: std_logic_vector(2 downto 0);
signal counter_enable_temp: std_logic;
signal rst_counter: std_logic;

begin

ROM: entity work.rom port map(
    addr=>counter_to_rom,
    data_outC=>dataC,
    data_outX=>dataX
);

COUNTER: entity work.counter_mod8 port map(
    clk=>clk,
    reset=>rst_counter,
    enable=> counter_enable_temp,
    count=> counter_to_rom
);

CU_A: entity work.CU_A port map(
    start=>start,
    clk=>clk,
    rst=>rst,
    ACK=>ack,
    counter_enable=>counter_enable_temp,
    strobe=>strobe,
    rst_counter=>rst_counter,
    count=>counter_to_rom
);

end structural;