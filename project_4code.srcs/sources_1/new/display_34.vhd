----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.10.2017 12:46:22
-- Design Name: 
-- Module Name: display_34 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_34 is
	generic
	(
		lw:   integer := 10;
		dl:   integer := 50;
		dh:   integer := 100
	);
	Port (
			value:  in    std_logic_vector(7 downto 0);
			hcount: in    std_logic_vector(10 downto 0);
			vcount: in    std_logic_vector(10 downto 0);
			posx:   in    integer;
		    posy:   in    integer;
            paint:  out   std_logic
			
		);

end display_34;

architecture Behavioral of display_34 is

	--Ancho de linea lw
	--alto del segmento dh (x)
	--Largo del segmento dl (y)



	signal segments : STD_LOGIC_VECTOR(33 downto 0):= (others=>'0');
	
    
	component segment_decoder_34 is
		port (
			input : in STD_LOGIC_VECTOR(7 downto 0);
            output : out STD_LOGIC_VECTOR(33 downto 0)
		);
	end component segment_decoder_34;

begin

decodificador: segment_decoder_34 port map (
    input => value,
    output => segments
);

rect_segments: process(hcount)

    --segmentos horizontales
    variable shx1 : INTEGER;
    variable shx2 : INTEGER;
    
    variable shx3 : INTEGER;
    variable shx4 : INTEGER ;

    variable shy1 : INTEGER;
    variable shy2 : INTEGER ;

    variable shy3 : INTEGER ;
    variable shy4 : INTEGER ;

    variable shy5 : INTEGER ;
    variable shy6 : INTEGER ;


    -- Segmentos Verticales
    variable svx1 : INTEGER ;
    variable svx2 : INTEGER ;

    variable svx3 : INTEGER ;
    variable svx4 : INTEGER ;

    variable svx5 : INTEGER ;
    variable svx6 : INTEGER ;
    
    variable svy1 : INTEGER ;
    variable svy2 : INTEGER ;

    variable svy3 : INTEGER ;
    variable svy4 : INTEGER ;

    variable svy5 : INTEGER ;
    variable svy6 : INTEGER ;

    variable svy7 : INTEGER ;
    variable svy8 : INTEGER ;


    --segmentos diagonales
    variable sd4 : INTEGER;
    variable sd4u : INTEGER;
    variable sd4d : INTEGER;
    
    variable sd5 : INTEGER;
    variable sd5u : INTEGER;
    variable sd5d : INTEGER;

    variable sd7 : INTEGER;
    variable sd7d : INTEGER;
    variable sd7u : INTEGER;

    variable sd8 : INTEGER;
    variable sd8d : INTEGER;
    variable sd8u : INTEGER;
    
    variable sd11 : INTEGER;
    variable sd11d : INTEGER;
    variable sd11u : INTEGER;

    variable sd12 : INTEGER;
    variable sd12d : INTEGER;
    variable sd12u : INTEGER;

    variable sd14 : INTEGER;
    variable sd14d : INTEGER;
    variable sd14u : INTEGER;

    variable sd15 : INTEGER;
    variable sd15d : INTEGER;
    variable sd15u : INTEGER;

    variable sd20 : INTEGER;
    variable sd20d : INTEGER;
    variable sd20u : INTEGER;

    variable sd21 : INTEGER;
    variable sd21d : INTEGER;
    variable sd21u : INTEGER;

    variable sd23 : INTEGER;
    variable sd23d : INTEGER;
    variable sd23u : INTEGER;

    variable sd24 : INTEGER;
    variable sd24d : INTEGER;
    variable sd24u : INTEGER;

    variable sd27 : INTEGER;
    variable sd27d : INTEGER;
    variable sd27u : INTEGER;

    variable sd28 : INTEGER;
    variable sd28d : INTEGER;
    variable sd28u : INTEGER;

    variable sd30 : INTEGER;
    variable sd30d : INTEGER;
    variable sd30u : INTEGER;
    
    variable sd31 : INTEGER;
    variable sd31d : INTEGER;
    variable sd31u : INTEGER;

    --pendiente m y variable auxiliar a
    variable m: INTEGER;
    variable val: INTEGER ;
    variable a1: std_logic := '0';
    variable a2: std_logic := '0';
    variable adiag: integer;

begin

    --segmentos horizontales
    shx1 := posx;
    shx2 := posx + dl/2;
    
    shx3 := posx + dl/2;
    shx4 := posx + dl;

    shy1 := posy;
    shy2 := posy + lw;

    shy3 := posy + dh/2 - lw/2;
    shy4 := posy + dh/2 + lw/2;

    shy5 := posy + dh - lw;
    shy6 := posy + dh;


    -- Segmentos Verticales
    svx1 := posx;
    svx2 := posx + lw;

    svx3 := posx + dl/2 - lw/2;
    svx4 := posx + dl/2 + lw/2;

    svx5 := posx + dl - lw;
    svx6 := posx + dl;
    
    --svy1 := posy + lw;
    svy1 := posy;
    svy2 := posy + dh/4;

    svy3 := posy + dh/4;
    svy4 := posy + 2*dh/4 - lw/2;

    svy5 := posy + 2*dh/4 + lw/2;
    svy6 := posy + 3*dh/4;

    svy7 := posy + 3*dh/4;
    --svy8 := posy + dh - lw;
    svy8 := posy + dh;

    a1:='0';
	--SEGMENTOS HORIZONTALES
	--  segmento 1
	if    (segments(0)  = '1' and (hcount>=shx1)and(hcount<=shx2)and(vcount>=shy1)and(vcount<=shy2)) then
		a1 := '1';
-- segmento 2
	elsif (segments(1)  = '1' and (hcount>=shx3)and(hcount<=shx4)and(vcount>=shy1)and(vcount<=shy2)) then
		a1 := '1';
-- segmento 17
	elsif (segments(16) = '1' and (hcount>=shx1)and(hcount<=shx2)and(vcount>=shy3)and(vcount<=shy4)) then
		a1 := '1';
-- segmento 18
	elsif (segments(17) = '1' and (hcount>=shx3)and(hcount<=shx4)and(vcount>=shy3)and(vcount<=shy4)) then
		a1 := '1';
-- segmento 33
	elsif (segments(32) = '1' and (hcount>=shx1)and(hcount<=shx2)and(vcount>=shy5)and(vcount<=shy6)) then
		a1 := '1';
-- segmento 34
	elsif (segments(33) = '1' and (hcount>=shx3)and(hcount<=shx4)and(vcount>=shy5)and(vcount<=shy6)) then
		a1 := '1';

--SEGMENTOS VERTICALES IZQUIERDOS

-- segmento 3
	elsif (segments(2)  = '1' and (hcount>=svx1)and(hcount<=svx2)and(vcount>=svy1)and(vcount<=svy2)) then
		a1 := '1';
-- segmento 10
	elsif (segments(9)  = '1' and (hcount>=svx1)and(hcount<=svx2)and(vcount>=svy3)and(vcount<=svy4)) then
		a1 := '1';
-- segmento 19
	elsif (segments(18)  = '1' and (hcount>=svx1)and(hcount<=svx2)and(vcount>=svy5)and(vcount<=svy6)) then
	    a1 := '1';		
-- segmento 26
	elsif (segments(25)  = '1' and (hcount>=svx1)and(hcount<=svx2)and(vcount>=svy7)and(vcount<=svy8)) then
		a1 := '1';

--SEGMENTOS VERTICALES DERECHOS

-- segmento 9
	elsif (segments(8)  = '1' and (hcount>=svx5)and(hcount<=svx6)and(vcount>=svy1)and(vcount<=svy2)) then
		a1 := '1';
-- segmento 16
	elsif (segments(15) = '1' and (hcount>=svx5)and(hcount<=svx6)and(vcount>=svy3)and(vcount<=svy4)) then
		a1 := '1';
-- segmento 25
	elsif (segments(24) = '1' and (hcount>=svx5)and(hcount<=svx6)and(vcount>=svy5)and(vcount<=svy6)) then
		a1 := '1';		
-- segmento 32
	elsif (segments(31) = '1' and (hcount>=svx5)and(hcount<=svx6)and(vcount>=svy7)and(vcount<=svy8)) then
		a1 := '1';

--SEGMENTOS VERTICALES CENTRALES

-- segmento 6
	elsif (segments(5) = '1' and (hcount>=svx3)and(hcount<=svx4)and(vcount>=svy1)and(vcount<=svy2)) then
		a1 := '1';
-- segmento 13
	elsif (segments(12) = '1' and (hcount>=svx3)and(hcount<=svx4)and(vcount>=svy3)and(vcount<=svy4)) then
		a1 := '1';
-- segmento 22
	elsif (segments(21) = '1' and (hcount>=svx3)and(hcount<=svx4)and(vcount>=svy5)and(vcount<=svy6)) then
		a1 := '1';		
-- segmento 29
	elsif (segments(28) = '1' and (hcount>=svx3)and(hcount<=svx4)and(vcount>=svy7)and(vcount<=svy8)) then
		a1 := '1';
	end if;

--calculos para todos los segmentos diagonales, sin inicializar

	val:=conv_integer(vcount);
    
    a2:='0';
    adiag:=lw/3;
    
    --evaluo si el puntero hcount se encuentra en alguno de los segmentos de recta, y lo pinto en pantalla
    --rectangulo izquierdo (base * altura)= (segmento 1)* (segmento 9 + segmento 16 + segmento 25 + segmento 32)
    if ( hcount >= svx2 and hcount <= svx3)	then
    	
        

        if(vcount > svy1 and vcount < svy2)	then
            --primer cuadrado
            m:=(svy2 - svy1)/(svx3-svx2);

            sd4 := -(val - svy2)/m+svx2;
            sd4d:= sd4 -adiag;
            sd4u:= sd4 +adiag;

            sd5 := (val - svy1)/m+svx2;
            sd5d:= sd5 -adiag;
            sd5u:= sd5 +adiag;

            if ( segments(3)= '1' and hcount >= sd4d  and hcount <= sd4u) then
                a2 :='1';
            elsif (  segments(4) = '1' and hcount >= sd5d and hcount <= sd5u) then
                a2 :='1';
            end if;

            

            
        elsif (vcount >= svy3 and vcount <= svy4) then 
            --tercer cuadrado
            --recalculo la pendiente para mejorar la precision
            m:=(svy4-svy3)/(svx3-svx2);

            sd11  := -(val-svy4)/m+svx2;
            sd11d :=  sd11-adiag;
            sd11u :=  sd11 +adiag;

            sd12 := (val - svy3)/m+svx2;
            sd12d:= sd12 -adiag;
            sd12u:= sd12 +adiag;
            if( segments(10)='1' and hcount >= sd11d and  hcount <= sd11u ) then
                a2 :='1';
            elsif ( segments(11)='1' and hcount >= sd12d and  hcount <= sd12u ) then
                a2 :='1';
            end if;
        
        elsif (vcount >= svy5 and vcount <= svy6) then
        --quinto cuadrado
            m:=(svy6-svy5)/(svx3-svx2);

            sd20  := -(val-svy6)/m+svx2;
            sd20d :=  sd20-adiag;
            sd20u :=  sd20 +adiag;

            sd21 := (val - svy5)/m+svx2;
            sd21d:= sd21 -adiag;
            sd21u:= sd21 +adiag;

            if (segments(19)='1' and hcount >= sd20d and hcount <= sd20u) then
                a2 :='1';
            elsif(segments(20)='1' and hcount >= sd21d and hcount <= sd21u) then
                a2 :='1';
            end if;
        --septimo cuadrado
        elsif (vcount >= svy7 and vcount <= svy8) then
        --septimo recuadro
            m:=(svy8-svy7)/(svx3-svx2);

            sd27  := -(val-svy8)/m+svx2;
            sd27d :=  sd27-adiag;
            sd27u :=  sd27 +adiag;

            sd28 := (val - svy7)/m+svx2;
            sd28d:= sd28 -adiag;
            sd28u:= sd28 +adiag;
            if (segments(26)='1' and hcount >= sd27d and hcount <= sd27u) then
                a2 :='1';
            elsif(segments(27)='1' and hcount >= sd28d and hcount <= sd28u) then
                a2 :='1';
            end if;
        end if;
    --rectangulo derecho (base * altura)= (segmento 2)* (segmento 9 + segmento 16 + segmento 25 + segmento 32)
    elsif ( hcount >= svx4 and hcount <= svx5) then
    	if(vcount >= svy1 and vcount <= svy2) then
        --segundo recuadro
            m:=(svy2 - svy1)/(svx3-svx2);
            sd7 := -(val - svy2)/m+svx4;
            sd7d:= sd7 -adiag;
            sd7u:= sd7 +adiag;

            sd8 := (val - svy1)/m+svx4;
            sd8d:= sd8 -adiag;
            sd8u:= sd8 +adiag;
            if(segments(6)='1' and hcount >= sd7d and  hcount <= sd7u) then
                a2 :='1';
            elsif ( segments(7)='1' and hcount >= sd8d and  hcount <= sd8u ) then
                a2 :='1';
            end if;
        --cuarto cuadrado
        elsif(vcount >= svy3 and vcount <= svy4) then
            m:=(svy4-svy3)/(svx3-svx2);
            sd14 := -(val - svy4)/m+svx4;
            sd14d:= sd14 -adiag;
            sd14u:= sd14 +adiag;

            sd15 := (val - svy3)/m+svx4;
            sd15d:= sd15 -adiag;
            sd15u:= sd15 +adiag;
            if ( segments(13)='1' and hcount >= sd14d and  hcount <= sd14u ) then
                a2 :='1';
            elsif ( segments(14)='1' and hcount >= sd15d and  hcount <= sd15u) then
                a2 :='1';
            end if;
        
        elsif(vcount >= svy5 and vcount <= svy6) then
            --sexto recuadro
            m:=(svy6-svy5)/(svx3-svx2);
            sd23 := -(val - svy6)/m+svx4;
            sd23d:= sd23 -adiag;
            sd23u:= sd23 +adiag;

            sd24 := (val - svy5)/m+svx4;
            sd24d:= sd24 -adiag;
            sd24u:= sd24 +adiag;
            
            if ( segments(22)='1' and hcount >= sd23d and  hcount <= sd23u ) then
                a2 :='1';
            elsif ( segments(23)='1' and hcount > sd24d and  hcount < sd24u) then
                a2 :='1';
            end if;
        --octavo cuadrado
        elsif(vcount >= svy7 and vcount <= svy8) then
        --octavo recuadro
            m:=(svy8-svy7)/(svx3-svx2);
            sd30 := -(val - svy8)/m+svx4;
            sd30d:= sd30 -adiag;
            sd30u:= sd30 +adiag;

            sd31 := (val - svy7)/m+svx4;
            sd31d:= sd31 -adiag;
            sd31u:= sd31 +adiag;

            if ( segments(29)='1' and hcount >= sd30d and  hcount <= sd30u ) then
                a2 :='1';
            elsif ( segments(30)='1' and hcount >= sd31d and  hcount <= sd31u) then
                a2 :='1';
            end if;
        end if;
    end if;

paint<= a1 or a2;

end process;



end Behavioral;
