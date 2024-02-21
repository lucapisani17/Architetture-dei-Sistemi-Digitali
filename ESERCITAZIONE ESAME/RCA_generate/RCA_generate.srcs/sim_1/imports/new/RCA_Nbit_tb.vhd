----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2023 19:47:14
-- Design Name: 
-- Module Name: RCA_16bit_tb - Behavioral
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


entity RCA_Nbit_tb is
end RCA_Nbit_tb;

architecture behavioral of RCA_Nbit_tb is

    component RCA_Nbit is
	generic (N: natural range 0 to 32 := 8);
	port(
		OP_A_RCA: in std_logic_vector(N-1 downto 0);
		OP_B_RCA: in std_logic_vector(N-1 downto 0);
		CIN_RCA: in std_logic;
		
		S_RCA: out std_logic_vector(N-1 downto 0);
		COUT_RCA: out std_logic;
		OV: out std_logic
	);
	end component;
	
	signal OP_A_ext: std_logic_vector(3 downto 0);
	signal OP_B_ext: std_logic_vector(3 downto 0);
	signal CIN_ext: std_logic;
	signal S_ext: std_logic_vector(3 downto 0);
	signal COUT_ext: std_logic;
	signal OV_ext: std_logic;

begin
	UUT: RCA_Nbit 
	    generic map (N =>4) --istanzio il RCA con stringhe di 4 bit
	    port map(
		OP_A_RCA => OP_A_ext,
		OP_B_RCA => OP_B_ext,
		CIN_RCA => CIN_ext,
		S_RCA => S_ext,
		COUT_RCA => COUT_ext,
		OV => OV_ext
	);
	
	stim_proc: process
	begin
		wait for 100ns;
		
		-- 0+7=7 ok
		OP_A_ext <= "0000";
		OP_B_ext <= "0111";
		CIN_ext <= '0';
		
		wait for 10 ns;
		
		-- (-1)+(-2)=-3 ok
		OP_A_ext <= "1111";
		OP_B_ext <= "1110";
		wait for 10 ns;
		
		-- 1+7=8 overflow
		OP_A_ext <= "0001";
		OP_B_ext <= "0111";
		CIN_ext <= '0';
		
		wait for 10 ns;
		
		-- (-1) + (-8) = -9 overflow
		OP_A_ext <= "1111";
		OP_B_ext <= "1000";
		wait for 10 ns;
		
		-- 7-3=4 ok
		OP_A_ext <= "0111";
		OP_B_ext <= "1101";
		CIN_ext <= '0';
		
		wait for 10 ns;
		
		OP_A_ext <= "1000";
		OP_B_ext <= "1101";
		wait for 10 ns;
		wait;
	end process;
end behavioral;