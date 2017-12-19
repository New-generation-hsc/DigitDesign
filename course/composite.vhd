-------------------------------
-- Design Unit : composite 
-- File Name : composite.vhd

-- Description : 
-- the composite circuit
-- combine the counter component and judge component
-- finish a complement password circuit

-- Author : huangshicai
-- mail : 1309508226@qq.com
-- Revision : Version 0.0 2017/12/17
---------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity composite is
	port (
			confirm : in std_logic; -- the confirm signal, represent the input finish
			restart : in std_logic;

			num0, num1, num2, num3 : std_logic_vector(3 downto 0); -- the input password

			green_led, red_led : out std_logic; -- if the input match the password, then green led lighting, or the red led lighting
			alert : out std_logic -- the alert signal
		);
end composite;

architecture composite_arc of composite is
component judge
	port (
			enable : in std_logic;
			num0, num1, num2, num3 : std_logic_vector(3 downto 0);

			green_led, red_led : out std_logic
		);
end component;

component counter
	port (
			attempt : in std_logic; -- the password worng attempt
			clear : in std_logic; -- the asynchronous clear signal

			alert : out std_logic -- the alert signal, give the user a tip that you have try 3 times
		);
end component;

signal red : std_logic ;
begin
	proc0 : judge port map(confirm, num0, num1, num2, num3, green_led, red);
	proc1 : counter port map(red, restart, alert);
	red_led <= red;
end composite_arc;