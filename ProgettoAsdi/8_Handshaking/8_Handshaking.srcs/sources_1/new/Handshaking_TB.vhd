library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Handshaking_TB is port (
    clockA  : in std_logic;
    clockB  : in std_logic;
    reset   : in std_logic;
    start   : in std_logic
);
end Handshaking_TB;

architecture Behavioral of Handshaking_TB is

signal data_line    : std_logic_vector(7 downto 0);
signal ack          : std_logic;
signal strobe       : std_logic;

begin

nodoA : entity work.nodo_A port map(
    clk       => clockA,
    reset       => reset,
    start       => start,
    ack         => ack,
    strobe      => strobe,
    data_out    => data_line
);

nodoB : entity work.nodo_B port map(
    clk         => clockB,
    reset       => reset,
    strobe      => strobe,
    data_in     => data_line,
    ack         => ack
);


end Behavioral;