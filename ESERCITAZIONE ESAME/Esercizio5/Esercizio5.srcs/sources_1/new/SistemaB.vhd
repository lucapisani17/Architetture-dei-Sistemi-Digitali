----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.02.2024 18:38:19
-- Design Name: 
-- Module Name: SistemaB - STRUCTURAL
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

entity SistemaB is
  Port (
    signal datafromA: in std_logic;
    signal clk: in std_logic;
    signal rst: in std_logic;
    signal strobe: in std_logic;
    signal ack: out std_logic
   );
end SistemaB;

architecture STRUCTURAL of SistemaB is
signal trigger_temp: std_logic;
signal en_write_temp: std_logic;
signal en_count_temp: std_logic;
signal accumulatemp: std_logic;
signal counter_to_cu: std_logic_vector(2 downto 0);
signal outputfinale: std_logic_vector(2 downto 0);
signal data_in_temp:std_logic_vector(3 downto 0);

begin

CUB: entity work.CUB port map(
    clk=>clk,
    rst=>rst,
    accumula=>accumulatemp,
    strobe=>strobe,
    ack=>ack,
    trigger=>trigger_temp,
    en_write=>en_write_temp,
    conteggiooutput=>outputfinale,
    count=>counter_to_cu
);

COUNTER: entity work.counter_mod8 port map(
    clk=>clk,
    reset=>rst,
    enable=>en_count_temp,
    count=>counter_to_cu    
);

RICONOSCITORE: entity work.riconoscitore4bit port map(
    datain=>data_in_temp,
    write=>en_write_temp,
    trigger=>en_count_temp,
    en_count=>trigger_temp
);

ACCUMULTORE: entity work.BitAccumulator port map(
    clk=>clk,
    reset=>rst,
    accumula=>accumulatemp,
    input_bit=>datafroma,
    output_4bit=>data_in_temp
);

end STRUCTURAL;
