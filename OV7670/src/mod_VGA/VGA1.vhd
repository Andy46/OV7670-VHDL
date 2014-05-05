----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Daniel Sánchez Huerta
-- 
-- Create Date:    19:04:59 12/18/2013 
-- Design Name: 
-- Module Name:    VGA - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity VGA is 
	port (clk: in std_logic; -- reloj
		   RGB_in 	: in  STD_LOGIC_VECTOR (2 downto 0);--  rojo, verde, azul (entradas)
			reset: in std_logic;
			RGB_out 	: out STD_LOGIC_VECTOR (2 downto 0); -- Rojo, verde, azul (salidas)
			col_req 	: out STD_LOGIC_VECTOR(9 downto 0); -- columna
			row_req	: out STD_LOGIC_VECTOR(9 downto 0); -- fila
			h_sinc, v_sinc: out std_logic); -- Sincronismo
end;

architecture Behavioral of vga is
	signal hsinc, vsinc : std_logic; -- Señales de sincronismo horizontal y vertical
	signal video: std_logic; -- Señal de vídeo, indicadora de imagen
	signal hcont, hcont_next, vcont, vcont_next : std_logic_vector (9 downto 0);
	signal clk_25: std_logic;
	
component Divisor50MHz is
    Port ( clk_in, reset : in  STD_LOGIC;
           clk_out : out  STD_LOGIC);
end component;
--component Divisor25MHz is
--   Port ( clk_in, reset : in  STD_LOGIC;
--           clk_out : out  STD_LOGIC);
--end component;

component contador10bits is
    Port ( A : in  STD_LOGIC_VECTOR (9 downto 0);
           A_next : out  STD_LOGIC_VECTOR (9 downto 0));
end component;

begin


div1: Divisor50MHz port map (clk_in=>clk, clk_out=>clk_25,reset=>reset);
--div1: Divisor25MHz port map (clk_in=>clk, clk_out=>clk_25,reset=>reset);
sumah : contador10bits port map (A => hcont, A_next =>hcont_next);
sumav : contador10bits port map (A => vcont, A_next =>vcont_next);

process(clk_25, reset)
	begin
   if reset ='1' then
		hcont <= "0000000000";
		vcont <= "0000000000";
		
	elsif clk_25'event and clk_25 = '1' then 
		
		 --if (hcont > 655) and (hcont < 751) then 
			if (hcont >= "1010001111") and (hcont < "1011101111") then 
				hsinc <= '0';
			else hsinc <= '1';
			end if;
			
			--if (hcont = 799) then 
			if (hcont = "1100011111") then 
				hcont <= "0000000000";
			else hcont <= hcont_next;
			end if;

			--if hcont = 799 then 
			if (hcont = "1100011111") then	
				-- Contador vcont
				if vcont = "1000001100" then --524 
					vcont <= "0000000000"; -- rango de vcont: de 0 a 524
				else vcont <= vcont_next;
				end if;
			end if;
			-- if (vcont = 489) or (vcont = 491) then -- ancho mas front poch
						
			if (vcont >= "111101001") and (vcont < "111101011") then 
				vsinc <= '0';
			else vsinc <= '1';
			end if;

			-- (hcont < 640  				  vcont < 480) 
			if (hcont < "1010000000" and vcont < "111100000") then
				video <= '1';
			else
				video <= '0';
			end if;

		col_req <= hcont;
		row_req <= vcont;
		RGB_out(2) <= RGB_in (2) and video;
		RGB_out(1) <= RGB_in (1) and video;
		RGB_out(0) <= RGB_in (0) and video;
		h_sinc <= hsinc;
		v_sinc <= vsinc;
	end if;

end process;

end;
