

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DESIGN is
  Port (
    signal clk: in std_logic;
    signal rst: in std_logic;
    signal start: in std_logic;
    
    signal cop: in std_logic_vector(1 downto 0);
    signal op1: in std_logic_vector(7 downto 0);
    signal X: in std_logic_vector(7 downto 0);
    signal op2: in std_logic_vector(7 downto 0)
    
    
   );
end DESIGN;

architecture structural of DESIGN is

signal acktempA: std_logic;
signal reqtempA: std_logic;
signal donetempA: std_logic;
signal acktempB: std_logic;
signal reqtempB: std_logic;
signal donetempB: std_logic;
signal stoptemp: std_logic;

signal coptemp: std_logic_vector(1 downto 0);
signal op1temp: std_logic_vector(7 downto 0);
signal Xtemp: std_logic_vector(7 downto 0);
signal op2temp: std_logic_vector(7 downto 0);

begin

NODOA: entity work.nodoA port map(
    clk=>clk,
    rst=>rst,
    start=>start,
    cop=>cop,
    op1=>op1,
    cop_to_C=>coptemp,
    op1_to_C=>op1temp,
    
    ack=>acktempA,
    req=>reqtempA,
    done=>donetempA,
    stop=>stoptemp
    
);

NODOB: entity work.nodoB port map(
    clk=>clk,
    rst=>rst,
    start=>start,
    X=>X,
    op2=>op2,
    X_to_C=>xtemp,
    op2_to_C=>op2temp,
    
    ack=>acktempB,
    req=>reqtempB,
    done=>donetempB,
    stop=>stoptemp
);

NODOC: entity work.nodoC port map(
    clk=>clk,
    rst=>rst,
    
    cop=>coptemp,
    op1=>op1temp,
    X=>xtemp,
    op2=>op2temp,
    
    ackA=>acktempA,
    reqA=>reqtempA,
    doneA=>donetempA,
  
    ackB=>acktempB,
    reqB=>reqtempB,
    doneB=>donetempB,
    stop=>stoptemp
    );



end structural;
