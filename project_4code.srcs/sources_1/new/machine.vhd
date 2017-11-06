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
           clk : in STD_LOGIC;
           PS2Data : in STD_LOGIC;
           PS2Clk : in STD_LOGIC;
           leds : out STD_LOGIC_VECTOR (7 downto 0)
    );
end machine;


architecture Behavioral of machine is
component PS2Receiver
port( clk: in std_logic;
      kclk: in std_logic;
      kdata: in std_logic;
      keycode: out std_logic_vector(7 downto 0);
      oflag:  out std_logic);
end component;

signal Tleds : std_logic_vector(7 downto 0);
--signal Iv: std_logic := '0';
signal oflag : std_logic;
signal clk50Mhz : std_logic;
begin


clk_50mhz: process (clk)
begin  
    if (clk'event and clk = '1') then
        clk50Mhz <= NOT clk50Mhz;
    end if;
end process;

keboardin: PS2Receiver
	PORT MAP(
		clk => clk50Mhz,
		kclk =>PS2Clk,
		kdata => PS2Data,
		keycode => Tleds,
        oflag => oflag
	);
	
ledsout: process(clk)
       begin  
       if (clk'event and clk = '1') then
           if ( oflag =  '1' ) then
              leds <= Tleds;
           end if;
        end if; 
 end process;
       
	
end Behavioral;
