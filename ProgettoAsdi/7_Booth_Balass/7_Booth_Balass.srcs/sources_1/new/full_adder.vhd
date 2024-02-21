library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port (
        a, b, cin: in std_logic;
        cout, sum: out std_logic
    );
end entity full_adder;

architecture Dataflow of full_adder is
begin
    sum <= (a xor b) xor cin;
    cout <= (a and b) or ((a xor b) and cin);
end architecture;
