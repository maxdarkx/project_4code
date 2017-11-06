library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--use STD.textio.all;
--use IEEE.std_logic_textio.all;

library UNISIM;
use UNISIM.VComponents.all;

--use IEEE.NUMERIC_STD.ALL;
--use UNISIM.VComponents.all;

entity machine is
    Port ( 
           clk :      in  STD_LOGIC;
           rst:       in  std_logic;
           PS2Data :  in  STD_LOGIC;
           PS2Clk :   in  STD_LOGIC;
           leds :     out STD_LOGIC_VECTOR (7 downto 0);
           hs:        out std_logic;
           vs:        out std_logic;
           rgb:       out std_logic_vector(11 downto 0)
    );
end machine;


architecture Behavioral of machine is
component PS2Receiver
port( 
      clk:      in  std_logic;
      kclk:     in  std_logic;
      kdata:    in  std_logic;
      keycode:  out std_logic_vector(7 downto 0);
      oflag:    out std_logic);
end component;

component display_34
port(
      value:  in  std_logic_vector(5 downto 0);
      hcount: in  std_logic_vector(10 downto 0);
      vcount: in  std_logic_vector(10 downto 0);
      paint:  out std_logic;
      posx:   in  integer;
      posy:   in  integer
  );
end component;
component vga_ctrl_640x480_60hz
port
(
   rst:     in  std_logic;
   clk:     in  std_logic;
   rgb_in:  in  std_logic_vector(11 downto 0);
   HS:      out std_logic;
   VS:      out std_logic;
   hcount:  out std_logic_vector(10 downto 0);
   vcount:  out std_logic_vector(10 downto 0);
   rgb_out: out std_logic_vector(11 downto 0);--R3R2R1R0GR3GR3GR3GR3B3B2B1B0
   blank:   out std_logic
  );
end component;



signal Tleds : std_logic_vector(7 downto 0);
--signal Iv: std_logic := '0';
signal oflag : std_logic;
signal clk50Mhz : std_logic;
signal rgb_aux: std_logic_vector(11 downto 0);
signal hcount,vcount: std_logic_vector (10 downto 0 );
signal paint0: std_logic;
signal value: std_logic_vector(5 downto 0);
signal px,py: integer;

begin


clk_50mhz: process (clk)
begin  
  if (clk'event and clk = '1') then
    clk50Mhz <= NOT clk50Mhz;
  end if;
end process;

vgacontroller:vga_ctrl_640x480_60hz 
port map
(
   rst      =>  rst,
   clk      =>  clk50Mhz,
   rgb_in   =>  rgb_aux,
   HS       =>  hs,
   VS       =>  vs,
   hcount   =>  hcount,
   vcount   =>  vcount,
   rgb_out  =>  rgb,
   blank    =>  open
);

keboardin: PS2Receiver
	PORT MAP(
		clk     => clk50Mhz,
		kclk    => PS2Clk,
		kdata   => PS2Data,
		keycode => Tleds,
    oflag   => oflag
);
--falta la maquina de estados____________________

--_________________________________________________
display: display_34
port map
(
  value   =>  val,
  hcount  =>  hcount,
  vcount  =>  vcount,
  posx    =>  px,
  posy    =>  py,
  paint   =>  paint0,      
);

ledsout: process(clk)
begin  
  if (clk'event and clk = '1') then
     if ( oflag =  '1' ) then
        leds <= Tleds;
     end if;
  end if; 
end process;
  

color: process
begin
  if paint0='1' then
    rgb_aux<="111100000000";
  else
    rgb_aux<="111111111111";
  end if;
end process;       


end Behavioral;
