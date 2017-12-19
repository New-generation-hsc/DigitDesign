-------------------------------
-- Design Unit : counter 
-- File Name : counter.vhd

-- Description : 
-- the count circuit
-- count the wrong attempt times, once the password is wrong, then counter add 1

-- Author : huangshicai
-- mail : 1309508226@qq.com
-- Revision : Version 0.0 2017/12/17
---------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity counter is
	port (
			attempt : in std_logic; -- the password worng attempt
			clear : in std_logic; -- the asynchronous clear signal

			alert : out std_logic -- the alert signal, give the user a tip that you have try 3 times
		);
end counter;

architecture counter_arc of counter is
begin
	process(attempt, clear)
	variable count : integer range 0 to 10;
	begin
		if clear = '1' then 
			count := 0; -- clear the count, restart to count
			alert <= '0'; -- close the alert signal
		elsif attempt'event and attempt = '1' then
			if count = 2 then
				alert <= '1';
			else
				count := count + 1;
				alert <= '0';
			end if;
		end if;
	end process;
end counter_arc;

