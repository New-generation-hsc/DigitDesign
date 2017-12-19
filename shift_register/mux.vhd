-------------------------------
-- Design Unit : mux 
-- File Name : mux.vhd

-- Description : 
-- This is just a simple part of the shift register
-- a 4-bit multiplexer choose one of the four choice

-- input : s1, s0 -- > select signal
-- s1, s0 : 00 -> remain unchanged (hold)
-- s1, s0 : 01 -> left shift
-- s1, s0 : 10 -> right shift
-- s1, s0 : 11 -> load data

-- Author : huangshicai
-- mail : 1309508226@qq.com
-- Revision : Version 0.0 2017/12/14
---------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- for type conversions

entity mux is
	port (
		s : in std_logic_vector(1 downto 0); -- select signal

		hold, lt, rt, data : in std_logic; -- the 4 selected items

		sout : out std_logic -- selected output
	);
end mux;

architecture multiplexer of mux is
begin
	with s select
		sout <= hold when "00",
				lt when "01",
				rt when "10",
				data when "11",
				'X' when others;
end multiplexer;