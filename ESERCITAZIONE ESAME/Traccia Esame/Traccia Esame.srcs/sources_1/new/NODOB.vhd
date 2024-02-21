
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity NODOB is
  Port (
  signal clk: in std_logic;
  signal rst: in std_logic;
  signal start: in std_logic;
  
  signal X: in std_logic_vector(7 downto 0);
  signal op2: in std_logic_vector(7 downto 0);
  
  signal X_to_C: out std_logic_vector(7 downto 0);
  signal op2_to_C: out std_logic_vector(7 downto 0);
  
  signal req: out std_logic;
  signal ack: in std_logic;
  signal done:in std_logic;
  
  signal stop: in std_logic
   );
end NODOB;

architecture structural of NODOB is

begin

CUB: entity work.cuB port map(
    clk=>clk,
    start=>start,
    rst=>rst,
    Xinput=>X,
    op2input=>op2,
    Xoutput=>X_to_C,
    op2ouput=>op2_to_C,
    
    req=>req,
    ack=>ack,
    done=>done,
    
    stop=>stop
);

end structural;
