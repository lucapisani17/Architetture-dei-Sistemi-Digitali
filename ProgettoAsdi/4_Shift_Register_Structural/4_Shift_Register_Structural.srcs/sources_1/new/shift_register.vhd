library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is 
    
    generic(N: integer := 4);
    port (
        clk     : in std_logic;                                    
        reset   : in std_logic;        
        load    : in std_logic;           
        input   : in std_logic_vector(N-1 downto 0);
        sel     : in std_logic_vector(1 downto 0);
        output  : out std_logic_vector(N-1 downto 0)
    );
    
end shift_register;

architecture Structural of shift_register is
    signal out_mux4: std_logic_vector(N-1 downto 0);
    signal out_mux2: std_logic_vector(N-1 downto 0);
    signal out_FFD: std_logic_vector(N-1 downto 0);
    
    component FF_D
        port(
            clk, reset, d: in std_logic;
            y: out std_logic
        );
     end component;
     
     component mux_2_1
        port(
            A : in std_logic_vector(1 downto 0); 
            S : in std_logic; 
            Y : out std_logic
        );
     end component;
     
     component mux_4_1
        port(
            A: in std_logic_vector(3 downto 0);
            S: in std_logic_vector(1 downto 0);
            Y: out std_logic
        );
     end component;
     
begin

    --Primo componente (N-1)
    Mux4_Primo: mux_4_1
        port map(
            A(0) => out_FFD(N-2),
            A(1) => '0',
            A(2) => out_FFD(N-3),
            A(3) => '0',
            S => sel,
            Y => out_mux4(N-1)
        );
        
    Mux2_Primo: mux_2_1
        port map(
            A(0) => out_mux4(N-1),
            A(1) => input(N-1),
            s => load,
            y => out_mux2(N-1)
        );
        
    FF_Primo: FF_D
        port map(
            clk => clk,
            reset => reset,
            d => out_mux2(N-1),
            y => out_FFD(N-1)
        );
    
    --Secondo componente (N-2)
    Mux4_Secondo: mux_4_1
        port map(
            A(0) => out_FFD(N-3),
            A(1) => out_FFD(N-1),
            A(2) => out_FFD(N-4),
            A(3) => '0',
            S => sel,
            Y => out_mux4(N-2) 
        ); 
    
    Mux2_Secondo: mux_2_1
        port map(
            A(0) => out_mux4(N-2),
            A(1) => input(N-2),
            s => load,
            y => out_mux2(N-2)
        );
    
    FF_Secondo: FF_D
        port map(
            clk => clk,
            reset => reset,
            d => out_mux2(N-2),
            y => out_FFD(N-2)
        );
   
   Mux4_intermedi: for i in N-3 downto 2 generate
        mux: mux_4_1
            port map(
                A(0) => out_FFD(i-1),
                A(1) => out_FFD(i+1),
                A(2) => out_FFD(i-2),
                A(3) => out_FFD(i+2),
                S => sel,
                Y => out_mux4(i)
            );
    end generate Mux4_intermedi;
    
    Mux2_intermedi: for i in N-3 downto 2 generate
        mux: mux_2_1
            port map(
                A(0) => out_mux4(i),
                A(1) => input(i),
                s => load,
                y => out_mux2(i)
            );
    end generate Mux2_intermedi;
    
    FF_intermedi: for i in N-3 downto 2 generate
        FF: FF_D
            port map(
                clk => clk,
                reset => reset, 
                d => out_mux2(i),
                y => out_FFD(i)
            );
    end generate FF_intermedi;
    
    Mux4_penultimo: mux_4_1
        port map(
            A(0) => out_FFD(0),
            A(1) => out_FFD(2),
            A(2) => '0',
            A(3) => out_FFD(3),
            S => sel,
            Y => out_mux4(1)
        );
    
    Mux2_penultimo: mux_2_1
        port map(
            A(0) => out_mux4(1),
            A(1) => input(1),
            s => load,
            y => out_mux2(1)
        );
    
    FF_penultimo: FF_D
        port map(
            clk => clk,
            reset => reset,
            d => out_mux2(1),
            y => out_FFD(1)
        );
        
    Mux4_ultimo: mux_4_1
        port map(
            A(0) => '0',
            A(1) => out_FFD(1),
            A(2) => '0',
            A(3) => out_FFD(2),
            S => sel,
            Y => out_mux4(0)
        );
        
    Mux2_ultimo: mux_2_1
        port map(
            A(0) => out_mux4(0),
            A(1) => input(0),
            s => load, 
            y => out_mux2(0)            
        );
        
    FF_ultimo: FF_D
        port map(
            clk => clk, 
            reset => reset,
            d => out_mux2(0),
            y => out_FFD(0)
        );
     
     output <= out_FFD;
     
end Structural;