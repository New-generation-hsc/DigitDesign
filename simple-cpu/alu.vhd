-------------------------------
-- Design Unit : alu 
-- File Name : alu.vhd

-- Description : 
-- ALU stands for arithmetic logic unit.
-- It perform multiple operations according to the controls bits
-- alu is the main unit deal with operations

-- Author : huangshicai
-- mail : 1309508226@qq.com
-- Revision : Version 0.0 2017/12/14
---------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity alu is
	generic (
			size : integer := 32
		);
	port (
			Abus : in std_logic_vector((size - 1) downto 0);
			Bbus : in std_logic_vector((size - 1) downto 0);
			Sel : in std_logic_vector(3 downto 0); -- the select operation
			Result : out std_logic_vector((size - 1) downto 0);

			status : out std_logic_vector(2 downto 0)
			-- the status is the flag resgister
			-- status(2) : the carry out signal
			-- status(1) : the zero flag signal
			-- status(0) : overflow signal
		);
end alu;

architecture alu_arc of alu is
begin
	process(Abus, Bbus, Sel)
	begin
		case Sel is
			when "0000" => Result <= Abus + Bbus;
			when "0001" => Result <= Abus + (not Bbus) + 1;
			when "0010" => Result <= Abus + 1;
			when "0011" => Result <= Abus - 1;
			when "0100" => Result <= Bbus + 1;
			when "0101" => Result <= Bbus - 1;
			when "0110" => Result <= Abus;
			when "0111" => Result <= Bbus;
			when "1000" => Result <= not Abus;
			when "1001" => Result <= not Bbus;
			when "1010" => Result <= Abus and Bbus;
			when "1011" => Result <= Abus or Bbus;
			when "1100" => Result <= Abus nand Bbus;
			when "1101" => Result <= Abus nor Bbus;
			when "1110" => Result <= Abus xor Bbus;
			when "1111" => Result <= not (Aus xor Bbus);
			when others => Result <= "XXXX";
		end case;
	end process;
end alu_arc;