-------------------------------
-- Design Unit : number 
-- File Name : number.vhd

-- Description : 
--display the last four number of student number
-- for me, it is 4521

-- Author : huangshicai
-- mail : 1309508226@qq.com
-- Revision : Version 0.0 2017/12/17
---------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity number is
	port (
			num0, num1, num2, num3 : in std_logic_vector(3 downto 0);
			dpy0, dpy1, dpy2, dpy3 : out std_logic_vector(6 downto 0)
		);
end number;

architecture number_arc of number is
component display
	port (
		a : in std_logic_vector(3 downto 0);
		z : out std_logic_vector(6 downto 0)
	);
end component;
begin
	proc0 : display port map(num0, dpy0);
	proc1 : display port map(num1, dpy1);
	proc2 : display port map(num2, dpy2);
	proc3 : display port map(num3, dpy3);
end number_arc;