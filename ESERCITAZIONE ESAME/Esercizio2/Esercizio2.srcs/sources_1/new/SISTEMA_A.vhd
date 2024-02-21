----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.02.2024 12:17:02
-- Design Name: 
-- Module Name: SISTEMA_A - Structural
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

entity SISTEMA_A is port (
    signal start: in std_logic;
    signal clk: in std_logic;
    signal rst: in std_logic;
    signal ack: in std_logic;
    signal strobe: out std_logic;
    signal dataAtoB: out std_logic_vector(3 downto 0)
);
end SISTEMA_A;

architecture Structural of SISTEMA_A is

signal counter_to_rom: std_logic_vector(2 downto 0);
signal rom_to_comp: std_logic_vector (3 downto 0);
signal counter_enable_temp: std_logic;

begin

ROM: entity work.rom generic map (k => 2)
        port map(
    addr=>counter_to_rom,
    data_out=>rom_to_comp
);

COMP: entity work.comparatore port map(
    input_string=>rom_to_comp,
    output_string=>dataAtoB
);

CUA:  entity work.CU_A port map(
start=>start,
    clk=>clk,
    rst=>rst,
    ack=>ack,
    strobe=>strobe,
    count=>counter_to_rom,
    en_count=>counter_enable_temp
);

COUNT: entity work.counter_mod8 port map(
    clk=>clk,
    reset=>rst,
    enable=>counter_enable_temp,
    count=>counter_to_rom
);


end Structural;
