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
	--liss: code "45","45","16","45"; 0010
	constant user11: std_logic_vector(7 downto 0):="01000101";
	constant user12: std_logic_vector(7 downto 0):="01000101";
	constant user13: std_logic_vector(7 downto 0):="00010110";
	constant user14: std_logic_vector(7 downto 0):="01000101";

	--nili: code "45","16","45","45"; 0100
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
	clk_1:		in  std_logic;
	keycode:    in 	std_logic_vector(7 downto 0);
	flag_x:		in 	std_logic;
	rst: 		in 	std_logic;
	hcount:		in 	std_logic_vector(10 downto 0);
	vcount:		in 	std_logic_vector(10 downto 0);
	value:		out std_logic_vector(7 downto 0);
	posx:  		out	integer;
	posy:   	out integer;
	led:	    out std_logic_vector(7 downto 0)
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
	constant code_F0: std_logic_vector(7 downto 0):="11110000"; --"F0"
	constant code_E0: std_logic_vector(7 downto 0):="11100000";	--"E0"
	constant code_R:  std_logic_vector(7 downto 0):="00101101";	--"R= 2D"
	signal data11,data12,data13,data14 :std_logic_vector(7 downto 0):=RESET_DATA;
	signal data21,data22,data23,data24 :std_logic_vector(7 downto 0):=RESET_DATA;
	type state_code is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19);
	signal state_p,state_f: state_code:= s0;
	constant c_max:integer:=5000000;
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

	next_state: process(clk_1)
	begin
		if rst='1' then
			state_p<=s0;
		elsif(clk_1'event and clk_1='1') then
			state_p<=state_f;
		end if;

	end process;


	--keyboard_receiver: process(clk_1)
	--begin
	--	if clk_1'event and clk_1='1' then
	--		case state_p is
	--			when s1|s3|s5|s7|s10|s12|s14|s16=>
	--				if(flag_x='1' and c=0) then
	--			  		c<=c+1;	
	--			  	else
	--			  		c<=0;
	--			  	end if;
	--			  when others=>
	--			  	c<=0;
	--	  	end case;
	--	end if;
	--end process;




	finite_state_f_machine: process(flag_x)
	begin
			state_f<=state_p;
			if keycode/= code_F0 and keycode/= code_E0 then
				case state_p is
					when s0=>
						state_f<=s1;
						led<="00000000";
					when s1=>
							state_f<=s2;
							led<="00000001";
					when s2=>
							state_f<=s3;
							led<="00000010";
					when s3=>
							state_f<=s4;
							led<="00000011";
					when s4=>
							state_f<=s5;
							led<="00000100";
					when s5=>
							state_f<=s6;
							led<="00000101";
					when s6=>
							state_f<=s7;
							led<="00000110";
					when s7=>
							state_f<=s8;
							led<="00000111";
					when s8=>
							state_f<=s9;
							led<="00001000";
						
					when s9=>
						if(user11=data11 and user12=data12 and user13=data13 and user14=data14) then
							state_f<=s10;
						elsif (user21=data11 and user22=data12 and user23=data13 and user24=data14) then
							state_f<=s10;
						else
							state_f<=s0;
						end if;
						led<="00001001";
					when s10=>
						if(flag_x='1' and keycode /= code_F0) then
							state_f<=s11;
						end if;
						led<="00001010";
					when s11=>
						state_f<=s12;
						led<="00001011";
					when s12=>
						if(flag_x='1' and keycode /= code_F0) then
							state_f<=s13;
						end if;
						led<="00001100";
					when s13=>
						state_f<=s14;
						led<="00001101";
					when s14=>
						if(flag_x='1'and keycode /= code_F0 ) then
							state_f<=s15;
						end if;
						led<="00001110";
					when s15=>
						state_f<=s16;
						led<="00001111";
					when s16=>
						if(flag_x='1'and keycode /= code_F0 ) then
							state_f<=s17;
						end if;
						led<="00010000";
					when s17=>
						state_f<=s18;
						led<="00010001";
					when s18=>
						if(user11=data11 and user12=data12 and user13=data13 and user14=data14) then
							state_f<=s19;
						elsif (user21=data11 and user22=data12 and user23=data13 and user24=data14) then
							state_f<=s19;
						else
							state_f<=s0;
						end if;
						led<="00010010";
					when others=>
						state_f<=s0;
						led<="11110000";
				end case;
			end if;
	end process;

	write_data: process(state_p)
	begin
		case state_p is
			when s0=>
				data11<=RESET_DATA;
				data12<=RESET_DATA;
				data13<=RESET_DATA;
				data14<=RESET_DATA;

				data21<=RESET_DATA;
				data22<=RESET_DATA;
				data23<=RESET_DATA;
				data24<=RESET_DATA;	
			when s2=>
				data11<=keycode;
			when s4=>
				data12<=keycode;
			when s6=>
				data13<=keycode;
			when s8=>
				data14<=keycode;
			when s11=>
				data21<=keycode;
			when s13=>
				data22<=keycode;
			when s15=>
				data23<=keycode;
			when s17=>
				data24<=keycode;
			when others=>
		end case;
	end process;
		
end Behavioral;
