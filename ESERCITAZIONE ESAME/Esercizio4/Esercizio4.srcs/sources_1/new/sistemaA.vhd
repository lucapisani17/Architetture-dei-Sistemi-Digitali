

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sistemaA is
  Port (
  signal clk: in std_logic;
  signal rst: in std_logic;
  
  signal datainput : in std_logic_vector(3 downto 0);
  signal ack : in std_logic;
  
  signal strobe: out std_logic;
  signal dataout : in std_logic
  
   );
end sistemaA;

architecture structural of sistemaA is
signal loadtemp: std_logic;
signal strobetemp: std_logic;
begin

CUA: entity work.cua port map(
    clk=>clk,
    rst=>rst,
    ack=>ack,
    load=>loadtemp,
    strobe=>strobe
);

SHIFTREG: entity work.shift_register generic map (N=>4) port map(
    clk=>clk,
    reset=>rst,
    load=>loadtemp,
    data_in=>datainput,
    data_out=>dataout
);


end structural;
