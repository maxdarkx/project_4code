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
generic
(
	--liss: code "4B","43","1B","1B";
	signal user11: std_logic_vector(7 downto 0):="01001011";
	signal user12: std_logic_vector(7 downto 0):="01000011";
	signal user13: std_logic_vector(7 downto 0):="00011011";
	signal user14: std_logic_vector(7 downto 0):="00011011";

	--nili: code "31","43","4B","43";
	signal user21: std_logic_vector(7 downto 0):="00110001";
	signal user22: std_logic_vector(7 downto 0):="01000011";
	signal user23: std_logic_vector(7 downto 0):="01001011";
	signal user24: std_logic_vector(7 downto 0):="01000011";

	--cedula 1: 1017131966, code 4 finales: "16","46","36","36";
	signal code11: std_logic_vector(7 downto 0):="00010110";
	signal code12: std_logic_vector(7 downto 0):="01000110";
	signal code13: std_logic_vector(7 downto 0):="00110110";
	signal code14: std_logic_vector(7 downto 0):="00110110";

	--cedula 2: 1036662012, code 4 finales: "1E","45","16","1E";
	signal code21: std_logic_vector(7 downto 0):="00011110";
	signal code22: std_logic_vector(7 downto 0):="01000101";
	signal code23: std_logic_vector(7 downto 0):="00010110";
	signal code24: std_logic_vector(7 downto 0):="00011110";
);
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
	constant RESET_DATA: std_logic_vector(7 downto 0):=(others=>'0');
	signal data11,data12,data13,data14 :std_logic_vector(7 downto 0):=RESET_DATA;
	signal data21,data22,data23,data24 :std_logic_vector(7 downto 0):=RESET_DATA;
	signal data_icon1,data_icon2: std_logic_vector(7 downto 0):=RESET_DATA;
	signal state: std_logic_vector(3 downto 0):="0000";
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
				value<=data11;
			elsif hcount>px11 and hcount<px12 then
				posx<=px11;
				value<=data12;
			elsif hcount>px12 and hcount<px13 then
				posx<=px12;
				value<=data13;
				elsif hcount>px13 and hcount<px14 then
				posx<=px13;
				value<=data14;
			elsif hcount>px14 and hcount<px101 then
				posx<=px14;
				value<=data_icon1;
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
			elsif hcount>px13 and hcount<px14 then
				posx<=px13;
				value<=data24;
			elsif hcount>px14 and hcount<px101 then
				posx<=px14;
				value<=data_icon2;
			end if;
		end if;
	end process;



	finite_states_machine: process(oflag)

	begin
		case states is
			when "0000"=>
				if(oflag='1' and keycode/="11110000") then
					data11<=keycode;
					states<="0001";
				end if;
			when "0001"=>

				if(oflag='1') then
					data12<=keycode;
					states<="0010";
				end if;
			when "0010"=>

				if(oflag='1') then
					data13<=keycode;
					states<="0011";
				end if;
			when "0011"=>

				if(oflag='1') then
					data14<=keycode;
					states<="0100";
				end if;
			when "0100"=>
				if(user11=data11 and user12=data12 and user13=data13 and user14=data14) then
					states<="0101";
				elsif (user21=data11 and user22=data12 and user23=data13 and user24=data14) then
					states<="0101";
				else
					states<="0000";
					data11<=RESET_DATA;
					data12<=RESET_DATA;
					data13<=RESET_DATA;
					data14<=RESET_DATA;
				end if;
			when "0101"=>
			when "0110"=>
			when "0111"=>
			when "1000"=>
			when others =>
		end case;



	end process;
		--hacer process que modifique los data segun los estados states
end Behavioral;
