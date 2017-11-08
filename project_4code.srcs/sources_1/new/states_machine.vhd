----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.11.2017 17:16:10
-- Design Name: 
-- Module Name: state_f_machine - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity states_machine is
generic
(
	--liss: code "45","45","16","45";
	constant user11: std_logic_vector(7 downto 0):="01000101";
	constant user12: std_logic_vector(7 downto 0):="01000101";
	constant user13: std_logic_vector(7 downto 0):="00010110";
	constant user14: std_logic_vector(7 downto 0):="01000101";

	--nili: code "45","16","45","45";
	constant user21: std_logic_vector(7 downto 0):="01000101";
	constant user22: std_logic_vector(7 downto 0):="00010110";
	constant user23: std_logic_vector(7 downto 0):="01000101";
	constant user24: std_logic_vector(7 downto 0):="01000101";

	--cedula 1: 1017131966, code 4 finales: "16","46","36","36";
	constant code11: std_logic_vector(7 downto 0):="00010110";
	constant code12: std_logic_vector(7 downto 0):="01000110";
	constant code13: std_logic_vector(7 downto 0):="00110110";
	constant code14: std_logic_vector(7 downto 0):="00110110";

	--cedula 2: 1036662012, code 4 finales: "1E","45","16","1E";
	constant code21: std_logic_vector(7 downto 0):="00011110";
	constant code22: std_logic_vector(7 downto 0):="01000101";
	constant code23: std_logic_vector(7 downto 0):="00010110";
	constant code24: std_logic_vector(7 downto 0):="00011110"
);
Port 
(
	clk:		in 	std_logic;
	keycode:    in 	std_logic_vector(7 downto 0);
	flag_x:		in 	std_logic;
	rst: 		in 	std_logic;
	hcount:		in 	std_logic_vector(10 downto 0);
	vcount:		in 	std_logic_vector(10 downto 0);
	value:		out std_logic_vector(7 downto 0);
	posx:  		out	integer;
	posy:   	out integer
);
end states_machine;

architecture Behavioral of states_machine is
	constant dl:  integer := 50; 	--largo del caracter
	constant dh:  integer := 100; 	--altura del caracter
	constant lw:  integer := 5; 	--ancho de las lineas
	constant esh: integer := 10; 	--espacio entre caracterers

	constant th: integer := 640;
	constant tv: integer := 480;

	constant CC1 : integer := 4; 	-- cantidad de letras para primera fila (codigo + confirmacion= 4 + 1) 
	
	constant esl : integer := dl+lw; --espacio entre palabras

	constant EVU : integer := 2*(dh+esh); -- espacio vertical utilizado
	constant EHU1: integer := cc1*(dl+esh) ; --Espacio horizontal total utilizado fila 1 y 2
	
	constant RESET_DATA: std_logic_vector(7 downto 0):=(others=>'0');
	constant code_F0: std_logic_vector(7 downto 0):="11110000";
	signal data11,data12,data13,data14 :std_logic_vector(7 downto 0):=RESET_DATA;
	signal data21,data22,data23,data24 :std_logic_vector(7 downto 0):=RESET_DATA;
	signal data_icon1,data_icon2: std_logic_vector(7 downto 0):=RESET_DATA;
	type state_code is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,sx);
	signal state_p,state_f: state_code:= s0;
begin

	print: process(hcount)
		variable px1,px10,px11,px12,px13,px101: integer:=0;
		variable px2,px20,px21,px22,px23,px201: integer:=0;
		variable py1,py2,py3: integer;
	begin
		--centrado vertical y horizontalmente
		px1 := (th-ehu1)/2 ;
		py1 := (tv - EVU)/2;

		py2:=py1+dh;											   
		py3:=py1+2*dh;

		--cuatro simbolos primera y segunda lineas
		px10:= px1;
		px11:= px1 + dl + esh;
		px12:= px1 + 2*(dl + esh);
		px13:= px1 + 3*(dl + esh);
		px101:= px1 + 4*(dl + esh);


		if (vcount > py1) and (vcount <py2) then
			posy<=py1;

			if hcount>px10 and hcount<px11 then
				posx<=px10;
				value<=data11;

			elsif hcount>px11 and hcount<px12 then
				posx<=px11;
				value<=data12;

			elsif hcount>px12 and hcount<px13 then
				posx<=px12;
				value<=data13;
			elsif hcount>px13 and hcount<px101 then
				posx<=px13;
				value<=data14;
			--elsif hcount>px14 and hcount<px101 then
			--	posx<=px14;
			--	value<=data_icon1;
			end if;

		elsif vcount > py2 and vcount <py3 then
			posy<=py2;
			
			if hcount>px10 and hcount<px11 then
				posx<=px10;
				value<=data21;
			elsif hcount>px11 and hcount<px12 then
				posx<=px11;
				value<=data22;
			elsif hcount>px12 and hcount<px13 then
				posx<=px12;
				value<=data23;
			elsif hcount>px13 and hcount<px101 then
				posx<=px13;
				value<=data24;
			--elsif hcount>px14 and hcount<px101 then
			--	posx<=px14;
			--	value<=data_icon2;
			end if;
		end if;
	end process;

	next_state: process(clk)
	begin
		if(clk'event and clk='1') then
			if(rst = '1')then
				state_p<=s0;
			else
				state_p<=state_f;
			end if;
		end if;

	end process;


	finite_state_f_machine: process(state_p,flag_x)
	begin
		if keycode /= code_F0 then

			case state_p is
				when s0=>
					if(flag_x='1') then
						data11<=keycode;
						state_f<=s1;
					end if;

				when s1=>
					if(flag_x='1') then
						data12<=keycode;
						state_f<=s2;
					end if;

				when s2=>
					if(flag_x='1') then
						data13<=keycode;
						state_f<=s3;
					end if;

				when s3=>
					if(flag_x='1') then
						data14<=keycode;
						state_f<=s4;
					end if;

				when s4=>
					if(user11=data11 and user12=data12 and user13=data13 and user14=data14) then
						state_f<=s5;
					elsif (user21=data11 and user22=data12 and user23=data13 and user24=data14) then
						state_f<=s5;
					else
						state_f<=s0;
						data11<=RESET_DATA;
						data12<=RESET_DATA;
						data13<=RESET_DATA;
						data14<=RESET_DATA;
					end if;

				when s5=>
					if(flag_x='1') then
						data21<=keycode;
						state_f<=s6;
					end if;
				when s6=>
					if(flag_x='1') then
						data22<=keycode;
						state_f<=s7;
					end if;
				when s7=>
					if(flag_x='1') then
						data23<=keycode;
						state_f<=s8;
					end if;
				when s8=>
					if(flag_x='1') then
						data24<=keycode;
						state_f<=s9;
					end if;
				when s9=>
					if(code11=data21 and code12=data22 and code13=data23 and code14=data24) then
						state_f<=sx;
					elsif (code21=data21 and code22=data22 and code23=data23 and code24=data24) then
						state_f<=sx;
					else
						state_f<=s0;

						--resetea todos los datos si hay algun error y regresa al estado inicial
						data11<=RESET_DATA;
						data12<=RESET_DATA;
						data13<=RESET_DATA;
						data14<=RESET_DATA;

						data21<=RESET_DATA;
						data22<=RESET_DATA;
						data23<=RESET_DATA;
						data24<=RESET_DATA;
					end if;

				when others =>
					state_f<=s0;
			end case;
		end if;
	end process;
		
end Behavioral;
