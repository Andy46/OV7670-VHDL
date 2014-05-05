----------------------------------------------------------------------------------
-- Company: *
-- Engineer: Andres Gamboa
-- 
-- Create Date:    09:50:50 10/11/2013 
-- Design Name: 
-- Module Name:    sevseg - Behavioral 
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

entity mod_bcd is
port (  bcd : in std_logic_vector(3 downto 0); 
		g : in std_logic;
        segment7 : out std_logic_vector(6 downto 0));
end mod_bcd;

architecture Behavioral of mod_bcd is

begin

process(bcd, g)
begin

	if g = '0' then
		segment7 <= "0111111"; -- '-'
	else
		case  bcd is
			when "0000"=> segment7 <="1000000";  -- '0'
			when "0001"=> segment7 <="1111001";  -- '1'
			when "0010"=> segment7 <="0100100";  -- '2'
			when "0011"=> segment7 <="0110000";  -- '3'
			when "0100"=> segment7 <="0011001";  -- '4'
			when "0101"=> segment7 <="0010010";  -- '5'
			when "0110"=> segment7 <="0000010";  -- '6'
			when "0111"=> segment7 <="1111000";  -- '7'
			when "1000"=> segment7 <="0000000";  -- '8'
			when "1001"=> segment7 <="0010000";  -- '9'
			when "1010"=> segment7 <="0001000";  -- 'A'
			when "1011"=> segment7 <="0000011";  -- 'B'
			when "1100"=> segment7 <="1000110";  -- 'C'
			when "1101"=> segment7 <="0100001";  -- 'D'
			when "1110"=> segment7 <="0000110";  -- 'E'
			when "1111"=> segment7 <="0001110";  -- 'F'
			when others=> segment7 <="0111111";  -- '-'
		end case;
	end if;
	
end process;

end Behavioral;