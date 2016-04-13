-- Entity name: modular_exponentiation_tb
-- Author: Luis Gallet, Jacob Barnett
-- Contact: luis.galletzambrano@mail.mcgill.ca, jacob.barnett@mail.mcgill.ca
-- Date: April 12, 2016
-- Description:

library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--use IEEE.std_logic_arith.all;
--use IEEE.std_logic_unsigned.all;

entity modular_exponentiation_tb is
end entity;

architecture test of modular_exponentiation_tb is
-- define the ALU compontent to be tested
component modular_exponentiation is
 	generic(
		WIDTH_IN : integer := 1024
	);
	port(	N :	in unsigned(WIDTH_IN-1 downto 0); --Number
		Exp :	in unsigned(WIDTH_IN-1 downto 0); --Exponent
		M :	in unsigned(WIDTH_IN-1 downto 0); --Modulus
		--latch_in: in std_logic;
		clk :	in std_logic;
		reset :	in std_logic;
		C : 	out unsigned(WIDTH_IN-1 downto 0) --Output
		--C : out std_logic
	);

end component;

CONSTANT WIDTH_IN : integer := 1024;

CONSTANT clk_period : time := 1 ns;

Signal M_in : unsigned(WIDTH_IN-1 downto 0) := (WIDTH_IN-1 downto 0 => '0');
Signal N_in : unsigned(WIDTH_IN-1 downto 0) := (WIDTH_IN-1 downto 0 => '0');
Signal Exp_in : unsigned(WIDTH_IN-1 downto 0) := (WIDTH_IN-1 downto 0 => '0');
signal latch_in : std_logic := '0';

Signal clk : std_logic := '0';
Signal reset_t : std_logic := '0';

Signal C_out : unsigned(WIDTH_IN-1 downto 0) := (WIDTH_IN-1 downto 0 => '0');
--signal c_out : std_logic;

Begin
-- device under test
dut: modular_exponentiation 
			generic map(WIDTH_IN => WIDTH_IN)
			PORT MAP(	N	=> 	N_in,
					Exp 	=> 	Exp_in,
					M 	=> 	M_in,
					--latch_in => latch_in,
					clk	=> 	clk,
					reset 	=>	reset_t,
					C	=>	C_out
				);
  
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


	REPORT "Begin test case for base=45887094113759424281874047539341145013887312224581521333817212764051772726168565243963241467232892288491118009142825038959580974768286113098579055139263607255948083692281868230955551059151938446515928987261655639246013715394440032846140919836045467911220955062119360174621750875453722511321163828458387117486, exp=65537, mod=91018299765439889448453661775564187918004580494074273854219737842605276340948706620710656819373564595719808089423487010778042320236486933047007640973722604880063994968017774174986423975826688197968357160550963613350359338343570445270321885770616362940988940398483415526835367335242175239983808747461623067921";
	REPORT "Expected output is 31782069310156254678235996070654695196893913100934462116819476121574757855582414265046343632294145532844897327896120445885572593434383388937717097041081710359837565574685122458580121094757440172513128724276710928411186976937454062609963066403918262346938892129617301137438791770216088766476147924173959215048, 0010110101000010010110001110011010011010010010000010000100100101100110011110101111011011110011011000101110000111111000001111001000101011011000011110001010101011110110000011011000001110010010000001101111110111111101110101100111011101110100101010110001010111100011100011110101111111101001110010111101010011000001001101001010100111011111110011100101110111010000100000011001110001100100111111001001000101101010010111110101100011111000110100001101010110010100110001110101101010001011111001000001000001100010010011110101011010110001000111111100000000001101010101010001110010100110100010110101000001101000011101100100000100111001011001110000101011011101001001000110111100000011000101010010010010101001011000101100100111101111000000100011100101000111000000110111111011110000000011011110000100001001011100100001110001101010010010101000100010001001011111001010101001101100100011100010111111000111010110011100011001010110101011010100101010110101000000010001110110101111110111011001100000111000111100100110011011001110000011011111001000";
	N_in <= "0100000101011000011010111000110010101101010111111110101010110011100000001100000100111111100001010001000111010000001111110011110111011100101101001111011110100010101101101011010111101101100111001010110101010111010111110110111000011101011110101110101001000000101000101010111110110011011000101001000000100101101110010001001000111101001011010111110000101010111011100110111011000111100000001101011001100000100010111000110111111110011101100111110101010011010001111000111010101111000010010111001110000111001110010110101100001000010100111110111000010110001101010010100001111101010111001111001010100001110011110111010000011110001100110010111010001101011101101111100001110010101100001101000110000010011001011010110111100101010111010101010000000101110010001000000101111110111100110001010100001010001100101110010011110101011010011101101111010010010101101111111010000111110111000100110010101011100001110001010001010110010001011110001001000001011111101111000001110101010100011011001111111000011011000001010100001010000001111001010110101110";
	Exp_in <= "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000001";
	M_in <= "1000000110011101010001101100011101100110101011011110001011111011011111001101001101011000110011111000011111000101010011110010010111001100011011111011000011111101111000000011000101110101010000000111111111101000000100001100101101111111101011101100110110010000011001000100001001011011001010010001101010001101011000010110101010000010101001011000111111110000010101000101001111100010001110010100011111011010101000011100011110110111111000001100001011111010001001110001100010000010010110010001100110110110101000010010100111011111000000010011111101011100000111000111010001010111010010111001000000001101010110001101010101110001100010100001101111111010011100001010110011010001000110001101111110000111000100111101000000110011000001011000000110110110000000110110011011101111000111000101010101111110011110100001110111011101011001111000000000011101000000000100001011100001101011011011010110110111111001101100010010000000001011101101011100111000010110000101111010100010110001111011001001100110001110000010111011000010011001101011010100010001";
	wait for 2102273 * clk_period;
	ASSERT(C_out = "0010110101000010010110001110011010011010010010000010000100100101100110011110101111011011110011011000101110000111111000001111001000101011011000011110001010101011110110000011011000001110010010000001101111110111111101110101100111011101110100101010110001010111100011100011110101111111101001110010111101010011000001001101001010100111011111110011100101110111010000100000011001110001100100111111001001000101101010010111110101100011111000110100001101010110010100110001110101101010001011111001000001000001100010010011110101011010110001000111111100000000001101010101010001110010100110100010110101000001101000011101100100000100111001011001110000101011011101001001000110111100000011000101010010010010101001011000101100100111101111000000100011100101000111000000110111111011110000000011011110000100001001011100100001110001101010010010101000100010001001011111001010101001101100100011100010111111000111010110011100011001010110101011010100101010110101000000010001110110101111110111011001100000111000111100100110011011001110000011011111001000") REPORT "test failed" SEVERITY NOTE;

	REPORT "Begin test case for base=31782069310156254678235996070654695196893913100934462116819476121574757855582414265046343632294145532844897327896120445885572593434383388937717097041081710359837565574685122458580121094757440172513128724276710928411186976937454062609963066403918262346938892129617301137438791770216088766476147924173959215048, exp=80692513434725246146971247638491698527730932692474532851333982454659990020321371928475984291609973757427289769316316619622897216692560901229797452693136560842895518252937886920246256850188115583677163083045706938635332141539745629542339807416137808738268184931179200437936458514273181797269003519544072031897, mod=91018299765439889448453661775564187918004580494074273854219737842605276340948706620710656819373564595719808089423487010778042320236486933047007640973722604880063994968017774174986423975826688197968357160550963613350359338343570445270321885770616362940988940398483415526835367335242175239983808747461623067921";
	REPORT "Expected output is 45887094113759424281874047539341145013887312224581521333817212764051772726168565243963241467232892288491118009142825038959580974768286113098579055139263607255948083692281868230955551059151938446515928987261655639246013715394440032846140919836045467911220955062119360174621750875453722511321163828458387117486, 0100000101011000011010111000110010101101010111111110101010110011100000001100000100111111100001010001000111010000001111110011110111011100101101001111011110100010101101101011010111101101100111001010110101010111010111110110111000011101011110101110101001000000101000101010111110110011011000101001000000100101101110010001001000111101001011010111110000101010111011100110111011000111100000001101011001100000100010111000110111111110011101100111110101010011010001111000111010101111000010010111001110000111001110010110101100001000010100111110111000010110001101010010100001111101010111001111001010100001110011110111010000011110001100110010111010001101011101101111100001110010101100001101000110000010011001011010110111100101010111010101010000000101110010001000000101111110111100110001010100001010001100101110010011110101011010011101101111010010010101101111111010000111110111000100110010101011100001110001010001010110010001011110001001000001011111101111000001110101010100011011001111111000011011000001010100001010000001111001010110101110";
	N_in <= "0010110101000010010110001110011010011010010010000010000100100101100110011110101111011011110011011000101110000111111000001111001000101011011000011110001010101011110110000011011000001110010010000001101111110111111101110101100111011101110100101010110001010111100011100011110101111111101001110010111101010011000001001101001010100111011111110011100101110111010000100000011001110001100100111111001001000101101010010111110101100011111000110100001101010110010100110001110101101010001011111001000001000001100010010011110101011010110001000111111100000000001101010101010001110010100110100010110101000001101000011101100100000100111001011001110000101011011101001001000110111100000011000101010010010010101001011000101100100111101111000000100011100101000111000000110111111011110000000011011110000100001001011100100001110001101010010010101000100010001001011111001010101001101100100011100010111111000111010110011100011001010110101011010100101010110101000000010001110110101111110111011001100000111000111100100110011011001110000011011111001000";
	Exp_in <= "0111001011101000111100101011010100011001100011010001001111101101000011011110111101111001100011110001001110111001100100111011111111011001000011010011010010000110111111110101101000011001101011111000001100110110010001001001110110000101101001110111110111001011100000110111011101101000110001100111101000101001110110011011000111001001111111011110101000101100100100010011011010000101000110110110111101011110100111111000101100100110101100111111011101101000001110110111110011111001001000100101010101000001111001001001011100101101110011010100000111110101010001000111101101101100000110011001010100101100000100010100110110000101100000111101100100011011011010101111111110000010110110101101110111010000110000001110101100110011010000000001111100110110100101010111111111111011110101011011001101000000111111010010101001100101000010001011101000001111110111110111010101010000100001001011011101101000010100101001111001000100100010001110111111101011111101100000001100110111110111000100100001011101111011001111110101101111011000110100111010011001";
	M_in <= "1000000110011101010001101100011101100110101011011110001011111011011111001101001101011000110011111000011111000101010011110010010111001100011011111011000011111101111000000011000101110101010000000111111111101000000100001100101101111111101011101100110110010000011001000100001001011011001010010001101010001101011000010110101010000010101001011000111111110000010101000101001111100010001110010100011111011010101000011100011110110111111000001100001011111010001001110001100010000010010110010001100110110110101000010010100111011111000000010011111101011100000111000111010001010111010010111001000000001101010110001101010101110001100010100001101111111010011100001010110011010001000110001101111110000111000100111101000000110011000001011000000110110110000000110110011011101111000111000101010101111110011110100001110111011101011001111000000000011101000000000100001011100001101011011011010110110111111001101100010010000000001011101101011100111000010110000101111010100010110001111011001001100110001110000010111011000010011001101011010100010001";
	wait for 2102273 * clk_period;
	ASSERT(C_out = "0100000101011000011010111000110010101101010111111110101010110011100000001100000100111111100001010001000111010000001111110011110111011100101101001111011110100010101101101011010111101101100111001010110101010111010111110110111000011101011110101110101001000000101000101010111110110011011000101001000000100101101110010001001000111101001011010111110000101010111011100110111011000111100000001101011001100000100010111000110111111110011101100111110101010011010001111000111010101111000010010111001110000111001110010110101100001000010100111110111000010110001101010010100001111101010111001111001010100001110011110111010000011110001100110010111010001101011101101111100001110010101100001101000110000010011001011010110111100101010111010101010000000101110010001000000101111110111100110001010100001010001100101110010011110101011010011101101111010010010101101111111010000111110111000100110010101011100001110001010001010110010001011110001001000001011111101111000001110101010100011011001111111000011011000001010100001010000001111001010110101110") REPORT "test failed" SEVERITY NOTE;




	wait;

end process;
end;
