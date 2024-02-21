----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2024 15:26:56
-- Design Name: 
-- Module Name: Riconoscitore_101_TB - Behavioral
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

entity Riconoscitore_101_TB is
end Riconoscitore_101_TB;

architecture Behavioral of Riconoscitore_101_TB is

COMPONENT Riconoscitore_101
    PORT(
         i : IN  std_logic;
         RST,CLK,M : IN  std_logic;
         Y : OUT  std_logic;
         state: OUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
--Inputs
   signal i : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0'; 
   signal M : std_logic := 'U'; 

 	--Outputs
   signal Y : std_logic;
   signal state: std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
   uut: Riconoscitore_101 port map(
          i => i,
          CLK => CLK,
          M => M,
          RST => RST,
          Y => Y,
          state => state
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      RST <= '1';
      wait for 100 ns;	

      
        RST <= '0';
      -- insert stimulus here 
        M<='1';
        wait for 10 ns;      
      
		i<='0';
		wait for 10 ns;
		i<='0';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='0';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='0';
		wait for 10 ns;
		i<='0';
		
		M<='0';
		wait for 10 ns;
		RST<='1';
		wait for 20 ns;
		RST <= '0';
		
        wait for 7.5 ns;      
      
		i<='0';
		wait for 10 ns;
		i<='0';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='0';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='0';
		wait for 10 ns;
		i<='1';
		wait for 10 ns;
		i<='0';
		
		
      wait;
   end process;

END;

