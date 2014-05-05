----------------------------------------------------------------------------------
-- Company: *
-- Engineer: Andrés Gamboa
-- 
-- Create Date:    17:51:05 05/05/2014 
-- Design Name: 
-- Module Name:    main - Behavioral 
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

---------------- OV7670 pins ----------------
-- VDD**		Supply			Power supply
-- GND		Supply			Ground level
-- SDIOC		Input				SCCB clock
-- SDIOD		Input/Output	SCCB data
-- VSYNC		Output			Vertical synchronization
-- HREF		Output			Horizontal synchronization
-- PCLK		Output			Pixel clock
-- XCLK		Input				System clock
-- D0-D7		Output			Video parallel output
-- RESET		Input				Reset (Active low)
-- PWDN		Input				Power down (Active high)
---------------- OV7670 pins ----------------

entity main is
    Port ( clk_100MHz, reset : in  STD_LOGIC; 			 		-- FPGA's clock, FPGA's reset(Active Low)

-- OV7670 pins --
--			  ov_sdioc : out  STD_LOGIC;  					 	-- SCCB clock
--			  ov_sdiod : inout  STD_LOGIC;  					 	-- SCCB data
           ov_xclk, ov_reset, ov_pwdn : out  STD_LOGIC;  -- OV7670 clock, OV7670 reset(Active Low), OV7670 Power down(Active High)
           ov_pclk, ov_vsync, ov_href : in  STD_LOGIC;	-- Pixel clock, Vertical synchronization, Horizontal synchronization
           ov_data : in  STD_LOGIC_VECTOR (7 downto 0);	-- Video parallel input
-- OV7670 pins --

-- VGA pins --
			  vga_vsync, vga_hsync : out STD_LOGIC; 	 				-- VGA Vertical synchronization, VGA Horizontal synchronization
			  vga_red, vga_green, vga_blue : out STD_LOGIC_VECTOR(3 downto 0); -- VGA colors (4bits)
		--	  vga_red, vga_green, vga_blue : out STD_LOGIC; -- VGA colors (1bit)
-- VGA pins --

-- Check pins --
			  but : in STD_LOGIC_VECTOR(4 downto 0);
			  sw  : in STD_LOGIC_VECTOR(15 downto 0);
			  led : out STD_LOGIC_VECTOR(15 downto 0);
			  an : out STD_LOGIC_VECTOR(7 downto 0);
			  seg : out STD_LOGIC_VECTOR(6 downto 0)
-- Check pins --
			  );
end main;

architecture Behavioral of main is

begin
-- Pixel counter

-- Line counter

-- OV7670 module
	
-- Mem module

-- VGA module

-- 7 Segments module

end Behavioral;

