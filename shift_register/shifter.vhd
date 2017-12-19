-------------------------------
-- Design Unit : shifter 
-- File Name : shifter.vhd

-- Description : 
-- the is the main part of the shift register
-- LSI : shift left serial input --> the right padding signal
-- RSI : shift right serial input --> the left padding signal

-- Author : huangshicai
-- mail : 1309508226@qq.com
-- Revision : Version 0.0 2017/12/14
---------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- for type conversions

entity shifter is
	port (
		clock : in std_logic;
		clear : in std_logic;

		D : in std_logic_vector(3 downto 0); -- parallel load data
		s : in std_logic_vector(1 downto 0);
		LSI : in std_logic;
		RSI : in std_logic;

		Q : out std_logic_vector(3 downto 0)
	);
end shifter;

architecture behavioral of shifter is
component D_FF
	port (
		clock : in std_logic;
		D : in std_logic; -- the input signal

		clear : in std_logic;

		Q : out std_logic -- the output signal
	);
end component;

component mux
	port (
		s : in std_logic_vector(1 downto 0); -- select signal

		hold, lt, rt, data : in std_logic; -- the 4 selected items

		sout : out std_logic -- selected output
	);
end component;

signal muxout : std_logic_vector(3 downto 0) := "0000";
signal dffout : std_logic_vector(3 downto 0) := "0000";

begin
	proc0 : mux port map(s, dffout(0), LSI, dffout(1), D(0), muxout(0));
	proc1 : mux port map(s, dffout(1), dffout(0), dffout(2), D(1), muxout(1));
	proc2 : mux port map(s, dffout(2), dffout(1), dffout(3), D(2), muxout(2));
	proc3 : mux port map(s, dffout(3), dffout(2), RSI, D(3), muxout(3));

	proc4 : D_FF port map(clock, muxout(0), clear, dffout(0));
	proc5 : D_FF port map(clock, muxout(1), clear, dffout(1));
	proc6 : D_FF port map(clock, muxout(2), clear, dffout(2));
	proc7 : D_FF port map(clock, muxout(3), clear, dffout(3));

	Q <= dffout;

end behavioral;