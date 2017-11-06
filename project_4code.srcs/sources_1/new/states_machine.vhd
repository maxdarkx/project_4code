----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.11.2017 17:16:10
-- Design Name: 
-- Module Name: states_machine - Behavioral
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

entity states_machine is
Port 
(
	keycode:    in 	std_logic_vector(7 downto 0);
	oflag:		in 	std_logic;
	hcount:		in 	std_logic_vector(10 downto 0);
	vcount:		in 	std_logic_vector(10 downto 0);
	value:		out std_logic_vector(5 downto 0);
	posx:  		out	integer;
	posy:   	out integer;
);
end states_machine;

architecture Behavioral of states_machine is
	constant dl:  integer := 50; 	--largo del caracter
	constant dh:  integer := 100; 	--altura del caracter
	constant lw:  integer := 5; 	--ancho de las lineas
	constant esh: integer := 10; 	--espacio entre caracterers

	constant th: integer := 640;
	constant tv: integer := 480;

	constant CC1 : integer := 5; 	-- cantidad de letras para primera fila (codigo + confirmacion= 4 + 1) 
	
	constant esl : integer := dl+lw; --espacio entre palabras

	constant EVU : integer := 2*(dh+esh); -- espacio vertical utilizado
	constant EHU1: integer := cc1*(dl+esh) ; --Espacio horizontal total utilizado fila 1 y 2
	signal data11,data12,data13,data14 :std_logic_vector(5 downto 0);
	signal data21,data22,data23,data24 :std_logic_vector(5 downto 0);
	signal data_con1,data_con2: std_logic_vector(5 downto 0);
	signal state: std_logic_vector(3 downto 0);
begin

	print: process
		variable px1,px10,px11,px12,px13,px101: integer:=0;
		variable px2,px20,px21,px22,px23,px201: integer:=0;
		variable py1,py2,py3: integer;
	begin
		--centrado vertical y horizontalmente
		px1 := (th-ehu1)/2 ;
		py1 := (tv - EVU)/2;

		py2:=py1+dh;											   
		py3:=py1+2*dh;

		--cinco simbolos primera y segunda lineas
		px10:= px1;
		px11:= px1 + dl + esh;
		px12:= px1 + 2*(dl + esh);
		px13:= px1 + 3*(dl + esh);
		px101:= px1 + 4*(dl + esh);


		if (vcount > py1) and (vcount <py2) then
			posy<=py1;

			if    hcount>px10 and hcount<px11 then
				posx<=px10;
				value<=data11; --J
			elsif hcount>px11 and hcount<px12 then
				posx<=px11;
				value<=data21; --u
			elsif hcount>px12 and hcount<px13 then
				posx<=px12;
				value<=data31; --a
			elsif hcount>px13 and hcount<px14 then
				posx<=px13;
				value<=data41; --n
			elsif hcount>px14 and hcount<px101 then
				posx<=px14;
				value<=data_con1; --c
			end if;

		elsif vcount > py2 and vcount <py3 then
			posy<=py2;
			
			if hcount>px10 and hcount<px11 then
				posx<=px10;
				value<=data21; --J
			elsif hcount>px11 and hcount<px12 then
				posx<=px11;
				value<=data22; --u
			elsif hcount>px12 and hcount<px13 then
				posx<=px12;
				value<=data23; --a
			elsif hcount>px13 and hcount<px14 then
				posx<=px13;
				value<=data24; --n
			elsif hcount>px14 and hcount<px101 then
				posx<=px14;
				value<=data_con2; --c
			end if;
		end if;

		--hacer process que modifique los data segun los estados states
end Behavioral;
