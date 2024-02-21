----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.02.2024 16:07:26
-- Design Name: 
-- Module Name: Sistema A - structural
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

entity SistemaA is
  Port (
    signal clk: in std_logic;
    signal rst: in std_logic;
    signal ack: in std_logic;
    signal strobe: out std_logic;
    start: in std_logic;
    signal data_to_B: out std_logic
   );
end SistemaA;

architecture structural of SistemaA is
signal en_count_temp: std_logic;
signal read_temp: std_logic;
signal counter_to_rom: std_logic_vector(2 downto 0);
signal rom_to_shift: std_logic_vector(3 downto 0);
signal load_temp: std_logic;
signal shift_temp: std_logic;


begin

CUA: entity work.CUA port map(
    clk=>clk,
    count=>counter_to_rom,
    start=>start,
    load=>load_temp,
    shift=>shift_temp,
    rst=>rst,
    en_count=>en_count_temp,
    read=>read_temp,
    strobe=>strobe,
    ack=>ack 
);

ROM: entity work.rom port map(
    clk=>clk,
    read_rom=>read_temp,
    address=>counter_to_rom,
    data_out=>rom_to_shift
);

COUNTER: entity work.counter_mod8 port map(
    clk=>clk,
    reset=>rst,
    enable=>en_count_temp,
    count=>counter_to_rom    
);

SHIFTEREG: entity work.shift_register port map(
    clk=>clk,
    load=>load_temp,
    shift=>shift_temp,
    rst=>rst,
    SI=>rom_to_shift,
    SO=>data_to_B
);


end structural;
