-------------------------------
-- Design Unit : display 
-- File Name : display.vhd

-- Description : 
-- this is the circuit that display the digit using the seven segment decode cube
-- from bcd code to 7 bits

-- Author : huangshicai
-- mail : 1309508226@qq.com
-- Revision : Version 0.0 2017/12/17
---------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity display is
	port (
		a : in std_logic_vector(3 downto 0);
		z : out std_logic_vector(6 downto 0)
	);
end display;

architecture display_arc of display is
begin
	with a select
		z <= "1110111" when "0000",
			 "0010010" when "0001",
			 "1011101" when "0010",
			 "1011011" when "0011",
			 "0111010" when "0100",
			 "1101011" when "0101",
			 "1101111" when "0110",
			 "1010010" when "0111",
			 "1111111" when "1000",
			 "1111011" when "1001",
			 "1101101" when "1010" | "1011" | "1100" | "1101" | "1110" | "1111",
			 "0000000" when others;
end display_arc;
