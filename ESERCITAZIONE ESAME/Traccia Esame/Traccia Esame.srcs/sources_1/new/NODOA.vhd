
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity NODOA is
  Port (
  signal clk: in std_logic;
  signal rst: in std_logic;
  signal start: in std_logic;
  
  signal cop: in std_logic_vector(1 downto 0);
  signal op1: in std_logic_vector(7 downto 0);
  
  signal cop_to_C: out std_logic_vector(1 downto 0);
  signal op1_to_C: out std_logic_vector(7 downto 0);
  
  signal req: out std_logic;
  signal ack: in std_logic;
  signal done:in std_logic;
  
  signal stop: in std_logic
   );
end NODOA;

architecture structural of NODOA is

begin

CUA: entity work.cuA port map(
    clk=>clk,
    rst=>rst,
    start=>start,
    copinput=>cop,
    op1input=>op1,
    copoutput=>cop_to_C,
    op1ouput=>op1_to_C,
    
    req=>req,
    ack=>ack,
    done=>done,
    
    stop=>stop
);

end structural;
