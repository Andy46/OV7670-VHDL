----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:32:02 05/05/2014 
-- Design Name: 
-- Module Name:    mod_VGA - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mod_VGA is
    Port ( clk_100, reset : in  STD_LOGIC; 			 		-- FPGA's clock, FPGA's reset(Active Low)

-- VGA pins --
			  vga_vsync, vga_hsync : out STD_LOGIC; 	 				-- VGA Vertical synchronization, VGA Horizontal synchronization
			  vga_red, vga_green, vga_blue : out STD_LOGIC_VECTOR(3 downto 0) -- VGA colors (4bits)
		--	  vga_red, vga_green, vga_blue : out STD_LOGIC; -- VGA colors (1bit)
-- VGA pins --

			);
end mod_VGA;

architecture Behavioral of mod_VGA is
--Divisor de frecuencia
	component Divisor4 is
		Port ( clk_in, reset : in std_logic;
			   clk_out : out std_logic);
	end component;
	signal clk50MHz : std_logic;

--Contadores vertical y horizontal
--Constantes
	constant UNO : std_logic_vector(15 downto 0) := "0000000000000001";

--Señales
	signal Vcount, Vcount_next : std_logic_vector(15 downto 0);
	signal Hcount, Hcount_next : std_logic_vector(15 downto 0);

begin

	--Process VSYNC
	--cambiar por contador
	FA_Vsync: FullAdder16bits port map(clk => clk100MHz, reset => reset, a => Vcount, b => std_logic_vector(to_unsigned(1, 16)),
													cin => '0', sum => Vcount_next);
	--Cambiar a 640x480
	process(clk50MHz, reset, Hcount, Vcount)
	begin
		if reset = '0' then
			Vcount <= (others => '0');
			VSync <= '0';
		elsif clk50MHz'event and clk50MHz = '1' then
			if Hcount = std_logic_vector(to_unsigned(1040, 16)) then --800 | 800
				if Vcount = std_logic_vector(to_unsigned(665, 16)) then --525 | 448
					Vcount <= (others => '0');
				else 
					Vcount <= Vcount_next;
				end if;
			
				if Vcount >= std_logic_vector(to_unsigned(636, 16)) and Vcount < std_logic_vector(to_unsigned(642, 16)) then --490,492 | 386,388
					Vsync <= '1';
				else
					Vsync <= '0';
				end if;
			end if;
		end if;
	end process;


	--Process HSYNC
	--cambiar por contador 
	FA_Hsync: FullAdder16bits port map(clk => clk100MHz, reset => reset, a => Hcount, b => UNO,
													cin => '0', sum => Hcount_next);
	--Cambiar a 640x480
	process(clk50MHz, reset)
	begin
		if reset = '0' then
			Hcount <= (others => '0');
			Hsync <= '0';
		elsif clk50MHz'event and clk50MHz = '1' then
			if Hcount = std_logic_vector(to_unsigned(1040, 16)) then --800 | 800
				Hcount <= (others => '0');
			else
				Hcount <= Hcount_next;
			end if;
			
			if Hcount >= std_logic_vector(to_unsigned(855, 16)) and Hcount < std_logic_vector(to_unsigned(975, 16)) then --656,752 | 656,752
				Hsync <= '1';
			else
				Hsync <= '0';
			end if;
		end if;
	end process;

end Behavioral;


--Asignar colores
--process(clk100MHz, reset, Vcount, Hcount, colRed, colGreen, colBlue)
--begin
--	if (Vcount >= std_logic_vector(to_unsigned(0, 16)) and Vcount <= std_logic_vector(to_unsigned(799, 16)) and
--				Hcount >= std_logic_vector(to_unsigned(0, 16)) and Hcount <= std_logic_vector(to_unsigned(799, 16))) then
--		vgaRed 	<= colRed;
--		vgaGreen <= colGreen;
--		vgaBlue 	<= colBlue;
--	else
--		vgaRed 	<= (others => '0');
--		vgaGreen <= (others => '0');
--		vgaBlue 	<= (others => '0');
--	end if;
--end process;
--
--Div_VGA: Divisor50MHz port map(clk_in => clk100MHz, reset => reset, clk_out => clk50MHz);


