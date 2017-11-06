----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.10.2017 14:36:48
-- Design Name: 
-- Module Name: 36_segment_decoder - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity segment_decoder_34 is
    Port ( 
    		input : in STD_LOGIC_VECTOR(5 downto 0);
            output : out STD_LOGIC_VECTOR(33 downto 0)
         );
end segment_decoder_34;

architecture Behavioral of segment_decoder_34 is
signal std : STD_LOGIC_VECTOR(33 downto 0);

begin
std <=
--		    "0001100000000000000000000000000000" when input = "101100" else --test cuadro 8
--          "0000001100000000000000000000000000" when input = "101011" else --test cuadro 7
--          "0000000000110000000000000000000000" when input = "101010" else --test cuadro 6
--          "0000000000000110000000000000000000" when input = "101001" else --test cuadro 5
--          "0000000000000000000110000000000000" when input = "101000" else --test cuadro 4
--          "0000000000000000000000110000000000" when input = "100111" else --test cuadro 3
--          "0000000000000000000000000011000000" when input = "100110" else --test cuadro 2
--          "0000000000000000000000000000011000" when input = "100101" else --test cuadro 1
          "0111111111111111111111111111111111" when input = "100100" else --test
		  "0010000001000000001010100010001000" when input = "100011" else --9, test: input 35 => output hex 8100A88
		  "0000101000100010000010100010001000" when input = "100010" else --8
		  "0000000010000010000010000100000011" when input = "100001" else --7
		  "0100100010100001010000001000001010" when input = "100000" else --6
		  "0100100000100000010000001000000111" when input = "011111" else --5
		  "0010000001000000111000010101000000" when input = "011110" else --4
		  "0100100000100000010000010001000011" when input = "011101" else --3
		  "1100000010000010000010000100001010" when input = "011100" else --2
		  "1100010000001000000001000000101000" when input = "011011" else --1
		  "0000101001000011001010001010001000" when input = "011010" else --0
		  "1100000010100010000010100100000011" when input = "011001" else --Z
		  "0000010000001000000010100100000100" when input = "011000" else --Y
		  "0010000010100010000010100100000100" when input = "010111" else --X
		  "0000111001001001001001001100100100" when input = "010110" else --W
		  "0000101001000001001000001100000100" when input = "010101" else --V
		  "1110000011000001001000001100000100" when input = "010100" else --U
		  "0000010000001000000001000000100011" when input = "010011" else --T
		  "0100100000100000010000001000001010" when input = "010010" else --S
		  "0010000010100001010010001010000101" when input = "010001" else --R
		  "0101100011000001001000001100000111" when input = "010000" else --Q
		  "0000000010000001010010001010000101" when input = "001111" else --P
		  "1110000011000001001000001100000111" when input = "001110" else --O
		  "0011000011001001001001001100010100" when input = "001101" else --N
		  "0010000011000001001000001101010100" when input = "001100" else --M
		  "1100000010000001000000001000000100" when input = "001011" else --L
		  "0010000010100001010010001100000100" when input = "001010" else --K
		  "0000101001000000001000000100000011" when input = "001001" else --J
		  "1100010000001000000001000000100011" when input = "001000" else --I
		  "0010000011000001111000001100000100" when input = "000111" else --H
		  "0100100011000001100000001000000111" when input = "000110" else --G
		  "0000000010000001110000001000000111" when input = "000101" else --F
		  "1100000010000001110000001000000111" when input = "000100" else --E
		  "0100100011000001001000001010000101" when input = "000011" else --D
		  "1100000010000001000000001000000111" when input = "000010" else --C
		  "0100100010100001010010001010000101" when input = "000001" else --B
		  "0010000011000001111000001010001000" when input = "000000" else --A
		  "1100000000000000110000000000000011"; --caso error
--    process (std)
--    begin
--        for i in 0 to 33 loop
--            output(i)<= std(33-i);
--        end loop;
--    end process;
    output<=std;
end Behavioral;





