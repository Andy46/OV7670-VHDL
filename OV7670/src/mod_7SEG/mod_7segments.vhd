----------------------------------------------------------------------------------
-- Company: *
-- Engineer: Andres Gamboa
-- 
-- Create Date:    08:52:16 10/15/2013 
-- Design Name: 
-- Module Name:    four7seg - Behavioral 
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

entity mod_7segments is
	port ( clk_8KHz, reset : in std_logic; 															-- Entrada clk 8 KHZ, reset
			 dig0, dig1, dig2, dig3, dig4, dig5, dig6, dig7 : in std_logic_vector(3 downto 0);  -- Entrada digitos binario
			 g : in std_logic_vector(7 downto 0);												-- Entrada habilitar 7 segmentos
			 an : out std_logic_vector(7 downto 0); 											-- Salida seleccion 7 segmentos
			 segments : out std_logic_vector(6 downto 0) 										-- Salida 7 segmentos
			 );
end mod_7segments;

architecture Behavioral of mod_7segments is

	component mod_bcd
		port (  bcd : in std_logic_vector(3 downto 0); 
				  g : in std_logic;
				  segment7 : out std_logic_vector(6 downto 0));
	end component;
	
	signal seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7 : std_logic_vector(6 downto 0);
	signal estado, estado_sig : std_logic_vector(2 downto 0);
		
begin

	bcd0: mod_bcd port map( bcd => dig0, g => g(0), segment7 => seg0);
	bcd1: mod_bcd port map( bcd => dig1, g => g(1), segment7 => seg1);
	bcd2: mod_bcd port map( bcd => dig2, g => g(2), segment7 => seg2);
	bcd3: mod_bcd port map( bcd => dig3, g => g(3), segment7 => seg3);
	bcd4: mod_bcd port map( bcd => dig4, g => g(4), segment7 => seg4);
	bcd5: mod_bcd port map( bcd => dig5, g => g(5), segment7 => seg5);
	bcd6: mod_bcd port map( bcd => dig6, g => g(6), segment7 => seg6);
	bcd7: mod_bcd port map( bcd => dig7, g => g(7), segment7 => seg7);	
	
	process (clk, reset, seg1, seg2, seg3, seg4)
	begin
	
		if reset='0' then
			segments <= "0111111";
			an <= "00000000";
			estado <= "000";
			estado_sig <= "000";
		elsif clk'event and clk = '1' then
			estado <= estado_sig;
			case estado is
				when "000" =>
					estado_sig <= "001";
					an <= "11111110";
					segments <= seg0;
				when "001" =>
					estado_sig <= "010";
					an <= "11111101";
					segments <= seg1;
				when "010" =>
					estado_sig <= "011";
					an <= "11111011";
					segments <= seg2;
				when "011" =>
					estado_sig <= "100";
					an <= "11110111";
					segments <= seg3;
				when "100" =>
					estado_sig <= "101";
					an <= "11101111";
					segments <= seg4;
				when "101" =>
					estado_sig <= "110";
					an <= "11011111";
					segments <= seg5;
				when "110" =>
					estado_sig <= "111";
					an <= "10111111";
					segments <= seg6;
				when "111" =>
					estado_sig <= "000";
					an <= "01111111";
					segments <= seg7;
				when others => 
					estado_sig <= "000";
					an <= "00000000";
					segments <= "0111111";
			end case;
			
		end if;
		
	end process;
	

end Behavioral;

