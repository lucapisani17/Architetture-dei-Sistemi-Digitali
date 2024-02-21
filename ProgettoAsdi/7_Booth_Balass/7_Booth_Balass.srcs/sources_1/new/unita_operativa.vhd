----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2024 22:54:58
-- Design Name: 
-- Module Name: unita_operativa - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity unita_operativa is
    port(
        X, Y: in std_logic_vector (7 downto 0);
        clock, reset: in std_logic;
        loadQ, loadA, loadM: in std_logic;
        shift: in std_logic;
        sub: in std_logic;
        count_in: in std_logic;
        count: out std_logic_vector (2 downto 0);
        P: out std_logic_vector(15 downto 0);
        qi, qi_meno1: out std_logic
        
        
    );
end unita_operativa;

architecture Structural of unita_operativa is

    component adder_sub is
        port(
            X, Y: in std_logic_vector(7 downto 0);
            cin: in std_logic;
            Z: out std_logic_vector(7 downto 0);
            cout: out std_logic
            );
    end component;
    
    component cont_mod8 is
        port(
            clock, reset: in std_logic;
            count_in: in std_logic; --segnali di abilitazione per il contatore
            count: out std_logic_vector(2 downto 0) --uscita 3 bit che rappresenta il valore del contatore
            );
    end component;
    
    component shift_register is
        port(
            A_in: in std_logic_vector(7 downto 0);
            Q_in: in std_logic_vector(7 downto 0);
            clock, reset, loadQ, loadA , shift: in std_logic; -- Segnali di clock, reset, caricamento e shift.
            parallel_out: out std_logic_vector(16 downto 0)
        );
    end component;
    
    component registro_M is
        port(
            clk : in std_logic;
            rst : in std_logic;
            load : in std_logic;
            data_in : in std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(7 downto 0)
        );
    end component;

    --signal adder_to_acc: std_logic_vector (7 downto 0);
    signal tmp_A: std_logic_vector (7 downto 0);
    signal out_M: std_logic_vector (7 downto 0);
    signal tmp_cout: std_logic;
    signal tmp_Z: std_logic_vector (7 downto 0);
    signal tmp_P: std_logic_vector (16 downto 0);
begin

    P <= tmp_P(16 downto 1);
    qi <= tmp_P(1);
    qi_meno1 <= tmp_P(0);
    
    M: registro_M port map(clock,reset,loadM,Y,out_M); -- OK
    
    CNT: cont_mod8 port map(clock,reset,count_in,count); -- OK
    
    tmp_A <= tmp_P(16 downto 9);
    
    ADDR: adder_sub port map(tmp_A,out_M,sub,tmp_Z,tmp_cout);
    
    SHFREG: shift_Register port map(tmp_Z,X,clock,reset,loadQ,loadA,shift,tmp_P);
    
    

end Structural;
