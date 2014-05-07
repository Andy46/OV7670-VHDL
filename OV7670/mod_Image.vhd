----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:31:23 05/07/2014 
-- Design Name: 
-- Module Name:    mod_Image - Behavioral 
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

entity mod_Image is
    Port ( clk_100MHz, reset : in  STD_LOGIC;
			  readX, readY : in  STD_LOGIC_VECTOR (9 downto 0); 						-- Pixel read addr(row, column)
           vga_red, vga_green, vga_blue : out  STD_LOGIC_VECTOR (3 downto 0);	-- Pixel read color
			  writeX, writeY : in std_logic_vector (9 downto 0);						-- Pixel write addr(row, column)
			  writePix : in std_logic_vector(7 downto 0)									-- Pixel write color
			  );
end mod_Image;

architecture Behavioral of mod_Image is

type linea is array (0 to 639) of std_logic_vector(7 downto 0) ;
type image is array (0 to 479) of linea;

constant fotogram_0 : image := (others => (others => "00001100"));
constant fotogram_1 : image :=(others => (others => "00000011"));

signal i_fot : std_logic;
begin

-- Peticion de pixel por parte de la vga
	process (clk_100MHz, reset)
	begin 
		if clk_100MHz'event and clk_100MHz = '1' then
			if reset = '0' then
				vga_red   <= (others => '0');
				vga_green <= (others => '0');
				vga_blue  <= (others => '0');
			else
				if (readY >= std_logic_vector(to_unsigned(0, 10)) and readY <= std_logic_vector(to_unsigned(479, 10)) and
							readX >= std_logic_vector(to_unsigned(0, 10)) and readX <= std_logic_vector(to_unsigned(639, 10))) then
					if i_fot = '0' then
						vga_red   <= fotogram_0(to_integer(unsigned(readY)))(to_integer(unsigned(readX)))(7 downto 4);
						vga_green <= fotogram_0(to_integer(unsigned(readY)))(to_integer(unsigned(readX)))(3 downto 2) & "00";
						vga_blue  <= fotogram_0(to_integer(unsigned(readY)))(to_integer(unsigned(readX)))(1 downto 0) & "00";
					else
						vga_red   <= fotogram_1(to_integer(unsigned(readY)))(to_integer(unsigned(readX)))(7 downto 4);
						vga_green <= fotogram_1(to_integer(unsigned(readY)))(to_integer(unsigned(readX)))(3 downto 2) & "00";
						vga_blue  <= fotogram_1(to_integer(unsigned(readY)))(to_integer(unsigned(readX)))(1 downto 0) & "00";
					end if;
				else
					vga_red 	 <= (others => '0');
					vga_green <= (others => '0');
					vga_blue  <= (others => '0');
				end if;
			end if;
		end if;
	end process;

-- Peticion de pixel por parte de la vga
	process (clk_100MHz, reset)
	begin 
		if clk_100MHz'event and clk_100MHz = '1' then
			if reset = '0' then
				vga_red   <= (others => '0');
				vga_green <= (others => '0');
				vga_blue  <= (others => '0');
			else
				if (writeY >= std_logic_vector(to_unsigned(0, 10)) and writeY <= std_logic_vector(to_unsigned(479, 10)) and
							writeX >= std_logic_vector(to_unsigned(0, 10)) and writeX <= std_logic_vector(to_unsigned(639, 10))) then
					if i_fot = '0' then
						fotogram_0(to_integer(unsigned(writeY)))(to_integer(unsigned(writeX)))(7 downto 0) <= writePix(7 downto 0);
					else
						fotogram_1(to_integer(unsigned(writeY)))(to_integer(unsigned(writeX)))(7 downto 0) <= writePix(7 downto 0);
					end if;
				else
					vga_red 	 <= (others => '0');
					vga_green <= (others => '0');
					vga_blue  <= (others => '0');
				end if;
			end if;
		end if;
	end process;

	--Elegir imagen a mostrar nueva imagen
	process (clk_100MHz, reset)
	begin
		if clk_100MHz'event and clk_100MHz = '1' then
			if reset = '0' then
					i_fot <= '0';
			else
				if (writeY = std_logic_vector(to_unsigned(480, 10)) and
							writeX = std_logic_vector(to_unsigned(640, 10))) then
					i_fot <= not i_fot;
				end if;
			end if;
		end if;
	end process;

end Behavioral;

