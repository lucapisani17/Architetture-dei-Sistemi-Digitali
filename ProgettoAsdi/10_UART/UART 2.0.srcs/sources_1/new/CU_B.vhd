library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU_B is
    port(
        clk: in std_logic;
        reset: in std_logic;
        RDA: in std_logic;
        
        en_count: out std_logic;
        en_write: out std_logic;
        sys_rst: out std_logic;
        RD: out std_logic
    );
end CU_B;

architecture Behavioral of CU_B is

type stato is (IDLE, WRITE_MEM, INC_COUNT);
signal stato_corrente: stato := IDLE;
signal stato_successivo: stato;

begin

stato_uscita: process(stato_corrente, RDA)
begin

    en_count <= '0';
    en_write <= '0';
    sys_rst<='0';

    case stato_corrente is
        when IDLE =>
        en_count<='0';
        en_write<='0';
        sys_rst<='0';
        RD<='0';
            if(RDA = '1') then
                stato_successivo <= WRITE_MEM;
            else
                stato_successivo <= IDLE;
            end if;
            
        when WRITE_MEM =>
            RD <= '1'; 
            en_write <= '1';
            stato_successivo <= INC_COUNT;
       
       when INC_COUNT =>
            en_count <= '1';
            RD <='1'; --
            sys_rst<='1';
            stato_successivo <= IDLE;
     
        end case;
    end process;

    mem: process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                stato_corrente <= IDLE;
            else
                stato_corrente <= stato_successivo;
            end if;
        end if;
    end process;


end Behavioral;
