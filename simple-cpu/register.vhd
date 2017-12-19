-------------------------------
-- Design Unit : register 
-- File Name : register.vhd

-- Description : 
-- register is the generic register
-- computer uses this register to store temporary variable value
-- registers can transfer data with each others
-- register can transfer data with main memory

-- Author : huangshicai
-- mail : 1309508226@qq.com
-- Revision : Version 0.0 2017/12/19
---------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- for type conversions

entity register is
	port (
			clock : in std_logic; 
			address : in std_logic_vector(3 downto 0); -- the register address, use it to choose the register
			we : in std_logic; -- write enable signal
			Din : in std_logic_vector(15 downto 0); -- data input

			Dout : out std_logic_vector(15 downto 0) -- data output
		);
end register;


architecture dataflow of register is
	type register_memory is array(0 to 15) of std_logic_vector(15 downto 0);

	signal memory : register_memory := 
		(
			others => (others => '0')
		);
begin
	-- =========================
	-- |   Register for write  |
	-- =========================
	write_proc : process(clock) is
	begin
		if rising_edge(clock) then
			if we = '1' then
				memory(to_integer(unsigned(address))) <= Din;
			end if;
		end if;
	end process;

	--- ===================
	--  |   Data Output   |
	--  ===================
	
	Dout <= memory(to_integer(unsigned(address)));

end dataflow;