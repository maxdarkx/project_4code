----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.11.2017 21:04:02
-- Design Name: 
-- Module Name: machine_sim - Behavioral
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
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity machine_sim is
--Port ( );
end machine_sim;

architecture Behavioral of machine_sim is
component machine
Port ( 
       clk :      in  STD_LOGIC;
       rst:       in  std_logic;
       PS2Data :  in  STD_LOGIC;
       PS2Clk :   in  STD_LOGIC;
       led :      out STD_LOGIC_VECTOR (7 downto 0);
       led_st:    out STD_LOGIC_VECTOR (7 downto 0);
       hcount:	  in  STD_LOGIC_VECTOR (10 downto 0);  --para simular
       vcount: 	  in  STD_LOGIC_VECTOR (10 downto 0);  --para simular
       hs:        out std_logic;
       vs:        out std_logic;
       rgb:       out std_logic_vector(11 downto 0)
    );

end component;
	constant hmax: integer:=639;
	constant vmax: integer:=479;
	constant frame_max: integer :=240;
	constant code_F0: std_logic_vector(7 downto 0):="11110000"; --"F0"
	constant code_E0: std_logic_vector(7 downto 0):="11100000";	--"E0"
	constant keycode0: std_logic_vector(7 downto 0):="01000111";
	constant keycode1: std_logic_vector(7 downto 0):="01000110";
	constant keycode2: std_logic_vector(7 downto 0):="00111110";
	constant keycode3: std_logic_vector(7 downto 0):="00101110";
	constant keycode4: std_logic_vector(7 downto 0):="00011010";
	constant keycode5: std_logic_vector(7 downto 0):="00100010";



	SIGNAL CLK_10:STD_LOGIC:='0';
	SIGNAL rgb_out: std_logic_vector(11 downto 0):= (others=>'0');
	--signal hs,vs: std_logic:='0';
	--signal reset: std_logic:='1';
	signal hcount,vcount : STD_LOGIC_VECTOR (10 downto 0) := "00000000000";
	signal frame_count: integer :=1;
	signal rst: std_logic:='0';
	signal led_code: std_logic_vector(7 downto 0):= (others=>'0');
	signal led_state: std_logic_vector(7 downto 0):= (others=>'0');
	signal cnt: integer:=0;
	signal kdata: std_logic:='0';
	signal kclk: std_logic:='0';
	signal kcnt: integer:=0;
	signal input_c: integer:=0;
	signal send: std_logic:='0';
	signal keysend: std_logic_vector(7 downto 0):="00000000";
	signal keysend_F: std_logic_vector(7 downto 0):= code_F0;
begin



test: machine port map(
    clk 	=>	clk_10,
    rst 	=>	rst,
    PS2Data =>	kdata,
    PS2Clk	=>	kclk,
    led 	=>	led_code,
    led_st 	=>	led_state,
    hcount	=>	hcount,
    vcount  =>	vcount,
    hs 		=>	open,
    vs 		=>	open,
    rgb 	=>	rgb_out
);






clk_process: process
begin
    wait for 5ns;
    clk_10<=not(clk_10); 
end process;






clk_keyboard_process: process(clk_10,cnt,send)
begin
	if (send='1') then
		if(clk_10'event and clk_10='1') then
			
			if(cnt=5000) then
				kclk<=not kclk;
				cnt<=0;
			else
				cnt<=cnt+1;	
			end if;
		end if;
	else
		kclk<='0';
		cnt<=0;
	end if;
end process;

keyboard_data1: process(kclk)

begin
	if (kclk'event and kclk='1') then

		case kcnt is
			when 0=>
				kdata<='0';
			when 1=>
				kdata<=keysend(0);
			when 2=>
				kdata<=keysend(1);
			when 3=>
				kdata<=keysend(2);
			when 4=>
				kdata<=keysend(3);
			when 5=>
				kdata<=keysend(4);
			when 6=>
				kdata<=keysend(5);
			when 7=>
				kdata<=keysend(6);
			when 8=>
				kdata<=keysend(7);
			when 9=>
				kdata<='1';
			when 10=>
				kdata<='0';

			when others=>			
				kdata <='0' ;
		end case;

		
		if kcnt=10 then
			kcnt<=0;
		else
			kcnt<=kcnt+1;
		end if;
	end if;
end process;


hvsync: process(clk_10)
begin
	if(clk_10'event and clk_10='1') then

		
		hcount<= hcount+'1';
		if hcount=hmax then
			hcount<= "00000000000";
			
			if(vcount>=vmax) then
				vcount<= "00000000000";
				if frame_count<frame_max then
					frame_count<=frame_count+1;
				end if;
			else
				vcount<=vcount+'1';
			end if;
			
			
		end if;
	end if;
end process;






input_data: process(frame_count,kclk)
begin
	if frame_count=10then
		send<='1';
		keysend<=keysend_F;
	elsif frame_count=11 then
		send<='1';
		keysend<=keycode0;
	elsif frame_count=30 then
		send<='1';
		keysend<=keysend_F;
	elsif frame_count=31 then
		send<='1';
		keysend<=keycode1;
	elsif frame_count=50 then
		send<='1';
		keysend<=keysend_F;
	elsif frame_count=51 then
		send<='1';
		keysend<=keycode2;
	elsif frame_count=70 then
		send<='1';
		keysend<=keysend_F;
	elsif frame_count=71 then
		send<='1';
		keysend<=keycode3;
	elsif frame_count=85 then
		send<='1';
		keysend<=keysend_F;
	elsif frame_count=86 then
		send<='1';
		keysend<=keycode4;
	elsif frame_count=100 then
		send<='1';
		keysend<=keysend_F;
	elsif frame_count=101 then
		send<='1';
		keysend<=keycode0;
	end if;
	if send='1' and kclk'event and kclk='0' then
		if input_c<10 then
			input_c<=input_c+1;
		else
			input_c<=0;
			send<='0';
		end if;
	end if;
end process;



capa1r: process(hcount)
	variable texto1: line;
    variable color: std_logic_vector(11 downto 0);
    variable temp1,temp2,temp3: std_logic_vector (3 downto 0);
    file solucion: text;
    variable c: std_logic:='0';
    variable frame_aux: integer;
begin
	

	frame_aux:=frame_count+1;
	temp1:= rgb_out(3) & rgb_out(2) & rgb_out(1) & rgb_out(0);
	--color:= temp3 & temp2 & temp1;
	
	if(vcount=0 and hcount=0 and c='0') then
		file_open(solucion, "resultadosr.m",  append_mode);
		write(texto1,string'("r(:,:,"));
		write(texto1,frame_count);
		write(texto1,string'(")=["));

		c:= not c;
		--write(texto1,string'(""));
	end if;

	write (texto1, conv_integer(temp1));

	if(hcount<hmax)then
		write (texto1, string'(","));
	else
		if (vcount<=vmax) then
			if (vcount=vmax) then
				write (texto1, string'("];"));
				writeline (solucion, texto1);

				if frame_count>frame_max then
					file_close(solucion);
				else
					write(texto1,string'("r(:,:,"));
					write(texto1,frame_aux);
					write(texto1,string'(")=["));

				end if;
			else
				write (texto1, string'(";"));
				--write(texto1, string'("   %("));
				--write(texto1, conv_integer(hcount));
				--write(texto1, string'(","));
				--write(texto1, conv_integer(vcount));
				--write(texto1, string'(")"));
				--writeline (solucion, texto1);
			end if;
		end if;
	end if;
end process;

resultado: process(frame_count)
	variable texto1: line;
    file solucion: text;
 begin
	if (frame_count=frame_max) then
		file_open(solucion, "resultado.m",  append_mode);
		write (texto1, string'("clear all;"));
		write (texto1, string'("close all;"));
		write (texto1, string'("clc;"));
		writeline (solucion, texto1);

		write (texto1, string'("run('resultadosr.m');"));
		--write (texto1, string'("run('resultadosg.m');"));
		--write (texto1, string'("run('resultadosb.m');"));
		writeline (solucion, texto1);
		write (texto1, string'("for i=1:"));
		write (texto1, frame_max);
		writeline (solucion, texto1);
		write(texto1,string'("imagen=zeros(640,480,3"));
		write(texto1,frame_max);
		write(texto1,string'(",60);"));
		write (texto1, string'("imagen(:,:,1,i)=uint8(r(:,:,i).*16);"));
		--write (texto1, string'("imagen(:,:,2,i)=uint8(g(:,:,i).*16);"));
		--write (texto1, string'("imagen(:,:,3,i)=uint8(b(:,:,i).*16);"));
		writeline (solucion, texto1);
		write (texto1, string'("end;"));
		writeline (solucion, texto1);

		write (texto1, string'("implay(imagen,0.5);"));
		
		writeline (solucion, texto1);
		file_close(solucion);
	end if;
end process;

end Behavioral;

--capa3b: process(hcount)
--	variable texto1: line;
--    variable color: std_logic_vector(11 downto 0);
--    variable temp1,temp2,temp3: std_logic_vector (3 downto 0);
--    file solucion: text;
--    variable c: std_logic:='0';
--    variable frame_aux: integer;
--begin
--	frame_aux:=frame_count+1;
--	temp3:= rgb_out(11) & rgb_out(10) & rgb_out(9) & rgb_out(8);
--	--color:= temp3 & temp2 & temp1;
	
--	if(vcount=0 and hcount=0 and c='0') then
--		file_open(solucion, "resultadosb.m",  append_mode);
--		write(texto1,string'("b(:,:,"));
--		write(texto1,frame_count);
--		write(texto1,string'(")=["));


--		c:= not c;
--		--write(texto1,string'(""));
--	end if;

--	write (texto1, conv_integer(temp3));

--	if(hcount<hmax)then
--		write (texto1, string'(","));
--	else
--		if (vcount<=vmax) then
--			if (vcount=vmax) then
--				write (texto1, string'("];"));
--				writeline (solucion, texto1);

--				if frame_count>frame_max then
--					file_close(solucion);
--				else
--					write(texto1,string'("b(:,:,"));
--					write(texto1,frame_aux);
--					write(texto1,string'(")=["));

--				end if;
--			else
--				write (texto1, string'(";"));
--				--write(texto1, string'("   %("));
--				--write(texto1, conv_integer(hcount));
--				--write(texto1, string'(","));
--				--write(texto1, conv_integer(vcount));
--				--write(texto1, string'(")"));
--				--writeline (solucion, texto1);
--			end if;
--		end if;
--	end if;
--end process;

--capa2g: process(hcount)
--	variable texto1: line;
--    variable color: std_logic_vector(11 downto 0);
--    variable temp1,temp2,temp3: std_logic_vector (3 downto 0);
--    file solucion: text;
--    variable c: std_logic:='0';
--    variable frame_aux: integer;
--begin
--	frame_aux:=frame_count+1;
--	temp2:= rgb_out(7) & rgb_out(6) & rgb_out(5) & rgb_out(4);
--	--color:= temp3 & temp2 & temp1;
	
--	if(vcount=0 and hcount=0 and c='0') then
--		file_open(solucion, "resultadosg.m",  append_mode);
--		write(texto1,string'("g(:,:,"));
--		write(texto1,frame_count);
--		write(texto1,string'(")=["));


--		c:= not c;
--		--write(texto1,string'(""));
--	end if;

--	write (texto1, conv_integer(temp2));

--	if(hcount<hmax)then
--		write (texto1, string'(","));
--	else
--		if (vcount<=vmax) then
--			if (vcount=vmax) then
--				write (texto1, string'("];"));
--				writeline (solucion, texto1);

--				if frame_count>frame_max then
--					file_close(solucion);
--				else
--					write(texto1,string'("g(:,:,"));
--					write(texto1,frame_aux);
--					write(texto1,string'(")=["));

--				end if;
--			else
--				write (texto1, string'(";"));
--				--write(texto1, string'("   %("));
--				--write(texto1, conv_integer(hcount));
--				--write(texto1, string'(","));
--				--write(texto1, conv_integer(vcount));
--				--write(texto1, string'(")"));
--				--writeline (solucion, texto1);
--			end if;
--		end if;
--	end if;
--end process;
