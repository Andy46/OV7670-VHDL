----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:24:58 11/12/2013 
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
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA is
    Port ( clk100MHz, reset : std_logic;
			   colRed, colGreen, colBlue : in std_logic_vector(3 downto 0);
				mode : in std_logic_vector(1 downto 0);
            Hsync, Vsync : out std_logic;
            vgaRed, vgaGreen, vgaBlue : out std_logic_vector(3 downto 0));
end VGA;

architecture Behavioral of VGA is

--Divisor de frecuencia
--Constantes
--Componentes
component Divisor50MHz is
    Port ( clk_in, reset : in std_logic;
           clk_out : out std_logic);
end component;
--Señales
signal clk50MHz : std_logic;
 
--Contadores vertical y horizontal
--Constantes
constant UNO : std_logic_vector(15 downto 0) := "0000000000000001";
--Componentes
component FullAdder16bits is
		port ( clk, reset : std_logic; 
			 a, b : in std_logic_vector(15 downto 0);
			 cin : in std_logic;
			 sum : out std_logic_vector(15 downto 0);
			 cout : out std_logic);
end component;
--Señales
signal Vcount, Vcount_next : std_logic_vector(15 downto 0);
signal Hcount, Hcount_next : std_logic_vector(15 downto 0);

signal auxRed, auxGreen, auxBlue : std_logic_vector(3 downto 0);
begin

--Asignar colores
process(clk100MHz, reset, Vcount, Hcount, auxRed, auxGreen, auxBlue)
begin
	if (Vcount >= std_logic_vector(to_unsigned(0, 16)) and Vcount <= std_logic_vector(to_unsigned(799, 16)) and
				Hcount >= std_logic_vector(to_unsigned(0, 16)) and Hcount <= std_logic_vector(to_unsigned(799, 16))) then
		vgaRed 	<= auxRed; --colRed;
		vgaGreen <= auxGreen; --colGreen;
		vgaBlue 	<= auxBlue; --colBlue;
	else
		vgaRed 	<= (others => '0');
		vgaGreen <= (others => '0');
		vgaBlue 	<= (others => '0');
	end if;
	
	if reset <= '0' then
		auxRed 	<= (others => '1');
		auxGreen <= (others => '1');
		auxBlue 	<= (others => '1');
	elsif clk100MHz'event and clk100MHz = '1' then
		case mode is
			when "00" =>
				auxRed 	<= colRed;
				auxGreen <= colGreen;
				auxBlue 	<= colBlue;
			when "01" =>
				auxRed 	<= Hcount(7 downto 4);
				auxGreen <= (others => '0');
				auxBlue 	<= Vcount(7 downto 4);
			when "10" =>
				auxRed 	<= Hcount(7 downto 4);
				auxGreen <= Vcount(7 downto 4);
				auxBlue 	<= (others => '0');
			when "11" =>
				if hcount < std_logic_vector(to_unsigned(100, 16)) then
					auxRed 	<= (others => '0');
					auxGreen <= (others => '0');
					auxBlue 	<= (others => '0');
				elsif hcount < std_logic_vector(to_unsigned(200, 16)) then
					auxRed 	<= (others => '0');
					auxGreen <= (others => '0');
					auxBlue 	<= (others => '1');
				elsif hcount < std_logic_vector(to_unsigned(300, 16)) then
					auxRed 	<= (others => '1');
					auxGreen <= (others => '0');
					auxBlue 	<= (others => '0');
				elsif hcount < std_logic_vector(to_unsigned(400, 16)) then
					auxRed 	<= (others => '1');
					auxGreen <= (others => '0');
					auxBlue 	<= (others => '1');
				elsif hcount < std_logic_vector(to_unsigned(500, 16)) then
					auxRed 	<= (others => '0');
					auxGreen <= (others => '1');
					auxBlue 	<= (others => '0');
				elsif hcount < std_logic_vector(to_unsigned(600, 16)) then
					auxRed 	<= (others => '0');
					auxGreen <= (others => '1');
					auxBlue 	<= (others => '1');
				elsif hcount < std_logic_vector(to_unsigned(700, 16)) then
					auxRed 	<= (others => '1');
					auxGreen <= (others => '1');
					auxBlue 	<= (others => '0');
				else
					auxRed 	<= (others => '1');
					auxGreen <= (others => '1');
					auxBlue 	<= (others => '1');
				end if;
			when others => null;
		end case;
		
	end if;
end process;

Div_VGA: Divisor50MHz port map(clk_in => clk100MHz, reset => reset, clk_out => clk50MHz);

--Process VSYNC
FA_Vsync: FullAdder16bits port map(clk => clk100MHz, reset => reset, a => Vcount, b => std_logic_vector(to_unsigned(1, 16)),
												cin => '0', sum => Vcount_next);
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
FA_Hsync: FullAdder16bits port map(clk => clk100MHz, reset => reset, a => Hcount, b => UNO,
												cin => '0', sum => Hcount_next);
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