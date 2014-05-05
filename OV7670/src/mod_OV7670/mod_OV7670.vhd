----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:23:02 05/05/2014 
-- Design Name: 
-- Module Name:    mod_OV7670 - Behavioral 
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

entity mod_OV7670 is
    Port ( clk_100, reset : in  STD_LOGIC; 			 		-- FPGA's clock, FPGA's reset(Active Low)

-- OV7670 pins --
--			  ov_sdioc : out  STD_LOGIC;  					 	-- SCCB clock
--			  ov_sdiod : inout  STD_LOGIC;  					 	-- SCCB data
           ov_xclk, ov_reset, ov_pwdn : out  STD_LOGIC;  -- OV7670 clock, OV7670 reset(Active Low), OV7670 Power down(Active High)
           ov_pclk, ov_vsync, ov_href : in  STD_LOGIC;	-- Pixel clock, Vertical synchronization, Horizontal synchronization
           ov_data : in  STD_LOGIC_VECTOR (7 downto 0)	-- Video parallel input
-- OV7670 pins --

			);
end mod_OV7670;

architecture Behavioral of mod_OV7670 is

begin


end Behavioral;

