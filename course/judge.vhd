-------------------------------
-- Design Unit : judge 
-- File Name : judge.vhd

-- Description : 
-- the judge circuit
-- judge the input digit num whether the same as the password
-- if true, then the output is 1
-- else, the output is 0

-- Author : huangshicai
-- mail : 1309508226@qq.com
-- Revision : Version 0.0 2017/12/17
---------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity judge is
	port (
			enable : in std_logic;
			num0, num1, num2, num3 : std_logic_vector(3 downto 0);

			green_led, red_led : out std_logic
		);
end judge;

architecture judge_arc of judge is
begin
	process(enable, num0, num1, num2, num3)
	begin
		if enable = '1' then
			if num0 = "0001" and num1 = "0010" and num2 = "0101" and num3 = "0100" then
				green_led <= '1';
				red_led <= '0';
			else
				green_led <= '0';
				red_led <= '1';
			end if;
		else 
			green_led <= '0';
			red_led <= '0';
		end if;
	end process;
end judge_arc;