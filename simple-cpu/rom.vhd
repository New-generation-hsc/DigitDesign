-------------------------------
-- Design Unit : rom 
-- File Name : rom.vhd

-- Description : 
-- rom is the read-only memory that is part the memory
-- the instruction memory is assumed to be Read only memory

-- Author : huangshicai
-- mail : 1309508226@qq.com
-- Revision : Version 0.0 2017/12/19
---------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port (
			address : in std_logic_vector(3 downto 0); -- the rom register number is 16
			instruction : out std_logic_vector((15) downto 0)
		);
end rom;

architecture dataflow of rom is
	type rom_memory is array(0 to 15) of std_logic_vector(15 downto 0);

	-- ======================
	-- |  Read Only Memory  |
	-- ======================

	-- inital the instruction 
	constant memory : rom_memory := 
		(
			0 => "0000" & "0000" & "0001" & "0000", -- LD R0, R1, 0000
			1 => "0001" & "0000" & "0001" & "0000", -- ST R0, R1, 0000
			2 => "0010" & "0000" & "0001" & "0010", -- ADD R0, R1, R2
			3 => "0011" & "0000" & "0001" & "0010", -- SUB R0, R1, R2
			4 => "0100" & "0000" & "0010" & "0000", -- NOT R0, R1, 0000
			5 => "0101" & "0000" & "0001" & "0010", -- AND R0, R1, R2
			6 => "0110" & "0000" & "0010" & "0010", -- OR R0, R1, R2
			7 => "0111" & "0000" & "0010" & "0010", -- XOR R0, R1, R2
			8 => "1000" & "0000" & "0010" & "0000", -- LDI R0, R1, 0000 load data from main memory
			9 => "1001" & "0000" & "0010" & "0000", -- STI R0, R1, 0000 store data to main memory
			others => "1111111111111111"
		)
begin
	instruction <= memory(to_integer(unsigned(address)));
end dataflow;
