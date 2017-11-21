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
    		input : in STD_LOGIC_VECTOR(7 downto 0);
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
          "1100000000000000000000000000000000" when input = "00000000" else --dato no ingresado
		  "0010000001000000001010100010001000" when input = "01000110" else --9 => scan code hex:"46"
		  "0000101000100010000010100010001000" when input = "00111110" else --8 => scan code hex:"3E"
		  "0000000010000010000010000100000011" when input = "00111101" else --7 => scan code hex:"3D"
		  "0100100010100001010000001000001010" when input = "00110110" else --6 => scan code hex:"36"
		  "0100100000100000010000001000000111" when input = "00101110" else --5 => scan code hex:"2E"
		  "0010000001000000111000010101000000" when input = "00100101" else --4 => scan code hex:"25"
		  "0100100000100000010000010001000011" when input = "00100110" else --3 => scan code hex:"26"
		  "1100000010000010000010000100001010" when input = "00011110" else --2 => scan code hex:"1E"
		  "1100010000001000000001000000101000" when input = "00010110" else --1 => scan code hex:"16"
		  "0000101001000011001010001010001000" when input = "01000101" else --0 => scan code hex:"45"
		  "1100000010100010000010100100000011" when input = "00011010" else --Z => scan code hex:"1A"
		  "0000010000001000000010100100000100" when input = "00110101" else --Y => scan code hex:"35"
		  "0010000010100010000010100100000100" when input = "00100010" else --X => scan code hex:"22"
		  "0000111001001001001001001100100100" when input = "00011101" else --W => scan code hex:"1D"
		  "0000101001000001001000001100000100" when input = "00101010" else --V => scan code hex:"2A"
		  "1110000011000001001000001100000100" when input = "00111100" else --U => scan code hex:"3C"
		  "0000010000001000000001000000100011" when input = "00101100" else --T => scan code hex:"2C"
		  "0100100000100000010000001000001010" when input = "00011011" else --S => scan code hex:"1B"
		  "0010000010100001010010001010000101" when input = "00101101" else --R => scan code hex:"2D"
		  "0101100011000001001000001100000111" when input = "00010101" else --Q => scan code hex:"15"
		  "0000000010000001010010001010000101" when input = "01001101" else --P => scan code hex:"4D"
		  "1110000011000001001000001100000111" when input = "01000100" else --O => scan code hex:"44"
		  "0011000011001001001001001100010100" when input = "00110001" else --N => scan code hex:"31"
		  "0010000011000001001000001101010100" when input = "00111010" else --M => scan code hex:"3A"
		  "1100000010000001000000001000000100" when input = "01001011" else --L => scan code hex:"4B"
		  "0010000010100001010010001100000100" when input = "01000010" else --K => scan code hex:"42"
		  "0000101001000000001000000100000011" when input = "00111011" else --J => scan code hex:"3B"
		  "1100010000001000000001000000100011" when input = "01000011" else --I => scan code hex:"43"
		  "0010000011000001111000001100000100" when input = "00110011" else --H => scan code hex:"33"
		  "0100100011000001100000001000000111" when input = "00110100" else --G => scan code hex:"34"
		  "0000000010000001110000001000000111" when input = "00101011" else --F => scan code hex:"2B"
		  "1100000010000001110000001000000111" when input = "00100100" else --E => scan code hex:"24"
		  "0100100011000001001000001010000101" when input = "00100011" else --D => scan code hex:"23"
		  "1100000010000001000000001000000111" when input = "00100001" else --C => scan code hex:"21"
		  "0100100010100001010010001010000101" when input = "00110010" else --B => scan code hex:"32"
		  "0010000011000001111000001010001000" when input = "00011100" else --A => scan code hex:"1C"
		  "1100000000000000110000000000000011"; --caso error

    output<=std;
end Behavioral;





