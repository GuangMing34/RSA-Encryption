-- Entity name: montgomery_multiplier_tb
-- Author: Stephen Carter, Jacob Barnett
-- Contact: stephen.carter@mail.mcgill.ca, jacob.barnett@mail.mcgill.ca
-- Date: April 05, 2016
-- Description:
-- 	Testbench used to test the Montgomery Multiplier
--		Tests autogenerated from a python script

library ieee;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
--use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity montgomery_multiplier_tb is
end entity;

architecture test of montgomery_multiplier_tb is
-- define the ALU compontent to be tested
Component montgomery_multiplier is
 	Generic(
		WIDTH_IN : integer := 16
	);
	Port(	A :	in unsigned(WIDTH_IN-1 downto 0);
		B :	in unsigned(WIDTH_IN-1 downto 0);
		N :	in unsigned(WIDTH_IN-1 downto 0);
		latch : in std_logic;
		clk :	in std_logic;
		reset :	in std_logic;
		M : 	out unsigned(WIDTH_IN-1 downto 0)
	);
end component;

CONSTANT WIDTH_IN : integer := 8;

CONSTANT clk_period : time := 1 ns;

Signal N_in : unsigned(WIDTH_IN-1 downto 0) := (others => '0');
Signal A_in : unsigned(WIDTH_IN-1 downto 0) := (others => '0');
Signal B_in : unsigned(WIDTH_IN-1 downto 0) := (others => '0');

Signal clk : std_logic := '0';
Signal reset_t : std_logic := '0';
Signal latch_in : std_logic := '0';

Signal M_out : unsigned(WIDTH_IN-1 downto 0) := (others => '0');
CONSTANT NUM_12 : unsigned(WIDTH_IN-1 downto 0) := "00010010";
CONSTANT NUM_2	: unsigned(WIDTH_IN-1 downto 0) := "00000001";
CONSTANT N_5	: unsigned(WIDTH_IN-1 downto 0) := "00000101";

Begin
-- device under test
dut: montgomery_multiplier PORT MAP(	A	=> 	A_in,
					B 	=> 	B_in,
					N 	=> 	N_in,
					latch	=>	latch_in,
					clk	=> 	clk,
					reset 	=>	reset_t,
					M	=>	M_out);
  
-- process for clock
clk_process : Process
Begin
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
end process;

stim_process: process
Begin


	reset_t <= '1';
	wait for 1 * clk_period;
	reset_t <= '0';
	wait for 1 * clk_period;


	REPORT "Begin test case for a=40339 (A=34684), b=65537 (B=23582), N=38957";
	REPORT "Expected output is 22272, 0101011100000000";
	A_in <= "1000011101111100";
	B_in <= "0101110000011110";
	N_in <= "1001100000101101";
	latch_in <= '1';
	wait for 2 * clk_period;
	latch_in <= '0';
	wait for 17 * clk_period;
	ASSERT(M_out = "0101011100000000") REPORT "test failed" SEVERITY ERROR;

	REPORT "Begin test case for a=61709 (A=20566), b=65537 (B=7760), N=53357";
	REPORT "Expected output is 36122, 1000110100011010";
	A_in <= "0101000001010110";
	B_in <= "0001111001010000";
	N_in <= "1101000001101101";
	latch_in <= '1';
	wait for 2 * clk_period;
	latch_in <= '0';
	wait for 17 * clk_period;
	ASSERT(M_out = "1000110100011010") REPORT "test failed" SEVERITY ERROR;

	REPORT "Begin test case for a=58096 (A=27858), b=65537 (B=1698), N=43357";
	REPORT "Expected output is 9833, 0010011001101001";
	A_in <= "0110110011010010";
	B_in <= "0000011010100010";
	N_in <= "1010100101011101";
	latch_in <= '1';
	wait for 2 * clk_period;
	latch_in <= '0';
	wait for 17 * clk_period;
	ASSERT(M_out = "0010011001101001") REPORT "test failed" SEVERITY ERROR;

	REPORT "Begin test case for a=45968 (A=27870), b=65537 (B=17690), N=37769";
	REPORT "Expected output is 7350, 0001110010110110";
	A_in <= "0110110011011110";
	B_in <= "0100010100011010";
	N_in <= "1001001110001001";
	latch_in <= '1';
	wait for 2 * clk_period;
	latch_in <= '0';
	wait for 17 * clk_period;
	ASSERT(M_out = "0001110010110110") REPORT "test failed" SEVERITY ERROR;



	wait;

end process;
end architecture;

