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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mod_VGA is
    Port ( clk_100MHz, reset : in  STD_LOGIC; 			 		-- FPGA's clock, FPGA's reset(Active Low)

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
	signal clk_25MHz : std_logic;

--Contadores vertical y horizontal
	component contador10bits is
		 Port ( A : in  STD_LOGIC_VECTOR (9 downto 0);
				  A_next : out  STD_LOGIC_VECTOR (9 downto 0));
	end component;

--Señales
	signal Vcount, Vcount_next : std_logic_vector(9 downto 0);
	signal Hcount, Hcount_next : std_logic_vector(9 downto 0);

--Imagen
	component mod_Image is
		 Port ( clk_100MHz, reset : in  STD_LOGIC;
				  readX, readY : in  STD_LOGIC_VECTOR (9 downto 0); 						-- Pixel read addr(row, column)
				  vga_red, vga_green, vga_blue : out  STD_LOGIC_VECTOR (3 downto 0);	-- Pixel read color
				  writeX, writeY : in std_logic_vector (9 downto 0);						-- Pixel write addr(row, column)
				  pixel : in std_logic_vector(7 downto 0)										-- Pixel write color
				  );
	end component;

begin

	--Divisor de frecuencia 1/4 
	Div_VGA: Divisor4 port map(clk_in => clk_100MHz, reset => reset, clk_out => clk_25MHz); 
	
	--Asignar colores
	Im: mod_Image port map( clk_100MHz => clk_100MHz, reset => reset, readX => Hcount, readY => Vcount, 
								vga_red => vga_red, vga_green => vga_green, vga_blue => vga_blue,
								writeX => std_logic_vector(to_unsigned(640, 10)), writeY =>std_logic_vector(to_unsigned(480,10)),
								pixel => "00000011" );
	
	--Process VSYNC
	FA_Vsync: contador10bits port map(A => Vcount, A_next => Vcount_next);
	process(clk_25MHz, reset, Hcount, Vcount)
	begin
		if clk_25MHz'event and clk_25MHz = '1' then
			if reset = '0' then
				Vcount <= (others => '0');
				vga_vsync <= '0';
			else
				if Hcount = std_logic_vector(to_unsigned(800, 10)) then -- 1040 | 800 | 800
					if Vcount = std_logic_vector(to_unsigned(525, 10)) then -- 665 | 525 | 448
						Vcount <= (others => '0');
					else 
						Vcount <= Vcount_next;
					end if;
				
					if Vcount >= std_logic_vector(to_unsigned(490, 10)) and Vcount < std_logic_vector(to_unsigned(492, 10)) then -- 636,642 | 490,492 | 386,388
						vga_vsync <= '1';
					else
						vga_vsync <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;


	--Process HSYNC
	FA_Hsync: contador10bits port map(A => Hcount, A_next => Hcount_next);
	process(clk_25MHz, reset)
	begin
		if clk_25MHz'event and clk_25MHz = '1' then
			if reset = '0' then
				Hcount <= (others => '0');
				vga_hsync <= '0';
			else
				if Hcount = std_logic_vector(to_unsigned(800, 10)) then -- 1040 | 800 | 800
					Hcount <= (others => '0');
				else
					Hcount <= Hcount_next;
				end if;
				
				if Hcount >= std_logic_vector(to_unsigned(656, 10)) and Hcount < std_logic_vector(to_unsigned(752, 10)) then -- 855, 975 | 656,752 | 656,752
					vga_hsync <= '1';
				else
					vga_hsync <= '0';
				end if;
			end if;
		end if;
	end process;

end Behavioral;