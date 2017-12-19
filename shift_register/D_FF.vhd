-------------------------------
-- Design Unit : D_FF 
-- File Name : D_FF.vhd

-- Description : 
-- This is just a simple part of the shift register
-- the simplest flip flop --> D flip flop
-- when the clock rising, then the output Q equals to the input D
-- plus asynchronous clear signal, effective when the clear signal is low

-- Author : huangshicai
-- mail : 1309508226@qq.com
-- Revision : Version 0.0 2017/12/14
---------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- for type conversions

entity D_FF is
	port (
		clock : in std_logic;
		D : in std_logic; -- the input signal

		clear : in std_logic;

		Q : out std_logic -- the output signal
	);
end D_FF;

architecture D_FF_arc of D_FF is
begin
	process(clock)
	begin
		if clear = '0' then -- the asynchronous clear signal
			Q <= '0';
		elsif clock'event and clock = '1' then
			Q <= D;
		end if;
	end process;
end D_FF_arc;

