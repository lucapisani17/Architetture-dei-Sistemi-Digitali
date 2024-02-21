

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity NODOC is
  Port (
  
    signal clk: in std_logic;
    signal rst: in std_logic;
    
    --dati
    signal cop: in std_logic_vector(1 downto 0);
    signal op1: in std_logic_vector(7 downto 0);
    signal X: in std_logic_vector(7 downto 0);
    signal op2: in std_logic_vector(7 downto 0);
  
    --hs
    signal reqA: in std_logic;
    signal ackA: out std_logic;
    signal doneA: out std_logic;
    signal reqB: in std_logic;
    signal ackB: out std_logic;
    signal doneB: out std_logic;
    
    --stop
    signal stop: out std_logic
  
   );
end NODOC;

architecture structura of NODOC is
signal result_to_cu: std_logic_vector(7 downto 0);
signal write_rom_temp: std_logic;
signal counter_to_rom: std_logic_vector(2 downto 0);
signal finaldata: std_logic_vector(7 downto 0);
signal counter_enable_temp: std_logic;
signal cintemp: std_logic;


begin

CUC: entity work.cuC port map(
    clk=>clk,
    rst=>rst,
    X=>X,
    enable=>counter_enable_temp,
    write=>write_rom_temp,
    result_from_add=>result_to_cu,
    data_to_save=>finaldata,
    cop=>cop,
    cin=>cintemp,
    
    reqA=>reqA,
    ackA=>ackA,
    doneA=>doneA,
    
    reqB=>reqB,
    ackB=>ackB,
    doneB=>doneB,
    
    stop=>stop
);

ADDSUB: entity work.adder_sub port map(
    X=>op1,
    Y=>op2,
    cin=>cintemp,
    Z=>result_to_cu
);

ROM: entity work.rom port map(
    clk=>clk,
    write_rom=>write_rom_temp,
    address=>counter_to_rom,
    data_in=>finaldata
);

COUNTER: entity work.counter_mod8 port map(
    clk=>clk,
    reset=>rst,
    enable=>counter_enable_temp,
    count=>counter_to_rom
    
);



end structura;
