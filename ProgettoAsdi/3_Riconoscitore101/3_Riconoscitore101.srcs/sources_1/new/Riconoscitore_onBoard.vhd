----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2024 17:50:58
-- Design Name: 
-- Module Name: Riconoscitore_onBoard - Structural
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

entity Riconoscitore_onBoard is
    port(
        RST: in std_logic;
        CLK: in std_logic;
        i: in std_logic;
        i_read: in std_logic;
        M: in std_logic;
        m_read: in std_logic;
        Y: out std_logic;
        state: out std_logic_vector(3 downto 0)
    );
end Riconoscitore_onBoard;

architecture Structural of Riconoscitore_onBoard is

    component ButtonDebouncer is
        generic(
            CLK_period: integer := 10;
            btn_noise_time: integer := 10000000
        );
        port(
            RST: in std_logic;
            CLK: in std_logic;
            BTN: in std_logic;
            CLEARED_BTN: out std_logic -- segnale di output ripulito
        );
    end component;
    
    component Riconoscitore_101 is
         port(
            i: in std_logic;
            RST: in std_logic;
            CLK: in std_logic;
            M: in std_logic;
            i_read: in std_logic;
            M_read: in std_logic;
            Y: out std_logic;
            state: out std_logic_vector(3 downto 0)
        );
    end component;
         

    signal cleared_i: std_logic;
    signal cleared_m: std_logic;

begin

    deb_i: ButtonDebouncer generic map(
            CLK_period => 10,
            btn_noise_time => 10000000
        )
        port map(
            RST => RST,
            CLK => CLK,
            BTN => i_read,
            CLEARED_BTN => cleared_i
    );
    
    deb_m: ButtonDebouncer generic map(
            CLK_period => 10,
            btn_noise_time => 10000000
        )
        port map(
            RST => RST,
            CLK => CLK,
            BTN => m_read,
            CLEARED_BTN => cleared_m
    );
    
    ric: Riconoscitore_101 port map(
        i => i,
        CLK => CLK, 
        RST => RST,
        M => M,
        i_read => cleared_i,
        m_read => cleared_m,
        Y => Y,
        state => state
    );

end Structural;
