----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:49:51 01/08/2014 
-- Design Name: 
-- Module Name:    contador10bits - Behavioral 
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

entity contador10bits is
    Port ( A : in  STD_LOGIC_VECTOR (9 downto 0);
           A_next : out  STD_LOGIC_VECTOR (9 downto 0));
end contador10bits;

architecture Behavioral of contador10bits is

begin
	
process(A)
begin	
	A_next(0) <= not A(0);
	
	if A(0) = '1' then
		A_next(1) <= not A(1);
	else
		A_next(1) <= A(1);
	end if;
	
	if A(1 downto 0) = "11" then
		A_next(2) <= not A(2);
	else
		A_next(2) <= A(2);
	end if;
	
	if A(2 downto 0) = "111" then
		A_next(3) <= not A(3);
	else
		A_next(3) <= A(3);
	end if;
	
	if A(3 downto 0) = "1111" then
		A_next(4) <= not A(4);
	else
		A_next(4) <= A(4);
	end if;
	
	if A(4 downto 0) = "11111" then
		A_next(5) <= not A(5);
	else
		A_next(5) <= A(5);
	end if;
	
	if A(5 downto 0) = "111111" then
		A_next(6) <= not A(6);
	else
		A_next(6) <= A(6);
	end if;
	
	if A(6 downto 0) = "1111111" then
		A_next(7) <= not A(7);
	else
		A_next(7) <= A(7);
	end if;
	
	if A(7 downto 0) = "11111111" then
		A_next(8) <= not A(8);
	else
		A_next(8) <= A(8);
	end if;
	
	if A(8 downto 0) = "111111111" then
		A_next(9) <= not A(9);
	else
		A_next(9) <= A(9);
	end if;
	
	
	
end process;

end Behavioral;

