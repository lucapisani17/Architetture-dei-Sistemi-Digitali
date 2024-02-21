library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SISTEMA_B is 
port (
        signal clk: in std_logic;
        signal rst: in std_logic;
        signal strobe: in std_logic;
        signal datain_C: in std_logic_vector(7 downto 0);
        signal datain_X: in std_logic_vector(3 downto 0);
        
        signal ACK: out std_logic
        
    );
end SISTEMA_B;

architecture Structural of SISTEMA_B is

signal datainput_temp1: std_logic_vector(7 downto 0);
signal datainput_temp2: std_logic_vector(3 downto 0);
signal dataoutput_temp: std_logic_vector(7 downto 0);
signal counter_to_mem: std_logic_vector(2 downto 0);
signal write_mem_temp1: std_logic;
signal write_mem_temp2: std_logic;
signal counter_enable_temp: std_logic;



begin

MEM1: entity work.mem port map(
    clk=>clk,
    input=>dataoutput_temp,
    write_addr=>counter_to_mem,
    write_en=>write_mem_temp1
);

MEM2: entity work.mem port map(
    clk=>clk,
    input=>dataoutput_temp,
    write_addr=>counter_to_mem,
    write_en=>write_mem_temp2
);

CU_B: entity work.CU_B port map(
    clk=>clk,
    rst=>rst,
    strobe=>strobe,
    count=>counter_to_mem,
    
    datain_C=>datain_C,
    datain_X=>datain_X,
    
    ack=>ack,
    
    dataout=>dataoutput_temp,
    
    writeMEM1=>write_mem_temp1,
    writeMEM2=>write_mem_temp2,
    
    counter_enable=>counter_enable_temp
);

COUNTER: entity work.counter_mod8 port map(
    clk=>clk,
    reset=>rst,
    enable=> counter_enable_temp,
    count=> counter_to_mem
);

end structural;