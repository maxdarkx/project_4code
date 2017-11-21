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
           led :      out STD_LOGIC_VECTOR (7 downto 0);
           led_st:    out STD_LOGIC_VECTOR (7 downto 0);
           hcount:    in  STD_LOGIC_VECTOR (10 downto 0);  --para simular
           vcount:    in  STD_LOGIC_VECTOR (10 downto 0);  --para simular
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
      flag_x:    out std_logic
    );
end component;

component display_34
port(
      value:  in  std_logic_vector(7 downto 0);
      hcount: in  std_logic_vector(10 downto 0);
      vcount: in  std_logic_vector(10 downto 0);
      paint:  out std_logic;
      posx:   in  integer;
      posy:   in  integer
  );
end component;
--component vga_ctrl_640x480_60hz
--port
--(
--   rst:     in  std_logic;
--   clk:     in  std_logic;
--   rgb_in:  in  std_logic_vector(11 downto 0);
--   HS:      out std_logic;
--   VS:      out std_logic;
--   hcount:  out std_logic_vector(10 downto 0);
--   vcount:  out std_logic_vector(10 downto 0);
--   rgb_out: out std_logic_vector(11 downto 0);--R3R2R1R0GR3GR3GR3GR3B3B2B1B0
--   blank:   out std_logic
--  );
--end component;

component states_machine
Port 
(
  clk:      in  STD_LOGIC;
  clk_1:    in  STD_LOGIC;
  keycode:  in  std_logic_vector(7 downto 0);
  flag_x:   in  std_logic;
  rst:      in  std_logic;
  hcount:   in  std_logic_vector(10 downto 0);
  vcount:   in  std_logic_vector(10 downto 0);
  value:    out std_logic_vector(7 downto 0);
  posx:     out integer;
  posy:     out integer;
  led:      out std_logic_vector(7 downto 0)
);
end component;


signal Tled :         std_logic_vector(7 downto 0):= "00000000";
--signal Iv: std_logic := '0';
signal flag_x :       std_logic:='0';
signal clk50Mhz :     std_logic:='0';
signal rgb_aux:       std_logic_vector(11 downto 0);
--signal hcount,vcount: std_logic_vector (10 downto 0 ); --quitar para simular
signal paint0:        std_logic;
signal px,py:         integer;
signal val :          std_logic_vector(7 downto 0);
signal cnt :          integer:=0;
signal clk100hz:      std_logic:='0';
signal rst_r:         std_logic:='0';
signal temp:          std_logic:='0';

begin


clk_50mhz: process (clk)
begin  
  if (clk'event and clk = '1') then
    clk50Mhz <= not clk50Mhz;
  end if;
end process;

clk_100hz: process(clk)
begin
  if (clk'event and clk='1') then
    --debe ser 10000000
    --if cnt >=10000000 then
    if cnt>=1200000 then--solo para simular
      temp<=not temp;
      cnt<=0;
    else
      cnt<=cnt+1;
    end if;
  end if;
  clk100hz<=temp;
end process;

rst_real:process (rst)
begin
  if(clk100hz'event and clk100hz='1') then
    if(rst='1') then
      rst_r<='1';
    else
      rst_r<='0';
    end if;
  end if;
end process;
 
rgb<= rgb_aux; --para simular
--vgacontroller:vga_ctrl_640x480_60hz 
--port map
--(
--   rst      =>  rst_r,
--   clk      =>  clk50Mhz,
--   rgb_in   =>  rgb_aux,
--   HS       =>  hs,
--   VS       =>  vs,
--   hcount   =>  hcount,
--   vcount   =>  vcount,
--   rgb_out  =>  rgb,
--   blank    =>  open
--);

keboardin: PS2Receiver
	PORT MAP(
		clk     => clk50Mhz,
		kclk    => PS2Clk,
		kdata   => PS2Data,
		keycode => Tled,
    flag_x   => flag_x
);

states_machine1: states_machine
Port map
(
  clk       => clk,
  clk_1     => clk100hz,
  keycode   => Tled,
  flag_x    => flag_x,
  rst       => rst,
  hcount    => hcount,
  vcount    => vcount,
  value     => val,
  posx      => px,
  posy      => py,
  led       => led_st
);

display: display_34
port map
(
  value   =>  val,
  hcount  =>  hcount,
  vcount  =>  vcount,
  posx    =>  px,
  posy    =>  py,
  paint   =>  paint0      
);

led<=Tled;
  

color: process(paint0)
begin
  if paint0='1' then
    rgb_aux<="111100000000";
  else
    rgb_aux<="111111111111";
  end if;
end process;       


end Behavioral;
