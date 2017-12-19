-------------------------------
-- Design Unit : alu 
-- File Name : alu.vhd

-- Description : 
-- ALU stands for arithmetic logic unit.
-- It perform multiple operations according to the controls bits
-- alu is the main unit deal with arithmetic and logic operations

-- ======================
-- |   ALU operations   |
-- ======================
-- |   sel  |     Y     |
-- ----------------------
-- |   000  |     0     |
-- |   001  |     A     |
-- |   010  |   A - B   |
-- |   011  |   A - B   |
-- |   100  |     !A    |
-- |   101  |   A and B |
-- |   110  |   A or B  |
-- |   111  |   A xor B |
-- ======================

-- Author : huangshicai
-- mail : 1309508226@qq.com
-- Revision : Version 0.1 2017/12/19
---------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	generic (
			size : integer := 8
		);
	port (
			sel : in std_logic_vector(2 downto 0); -- the operaion code
			a : in std_logic_vector((size - 1) downto 0); -- a bus, first operand
			b : in std_logic_vector((size - 1) downto 0); -- b bus, second operand

			cf : out std_logic; -- the carry flag
			zf : out std_logic; -- the zero flag
			ov : out std_logic; -- the overflow flag
			sf : out std_logic; -- the sign flag

			y : out std_logic_vector((size - 1) downto 0) -- the operation result
		);
end alu;

architecture alu_arc of alu is
signal a_bus, b_bus : unsigned((size - 1) downto 0);  -- proper operation
signal arith_out : unsigned(size downto 0); -- the arithmetic tempory result
signal logic_out : std_logic_vector((size - 1) downto 0); -- the logic result
signal result : std_logic_vector((size - 1) downto 0);
begin
	
	-- extension
	a_bus <= unsigned(a);
	b_bus <= unsigned(b);

	-- the opcode(2) discriminates logic vs arithmetic
	result <= logic_out when sel(2) else std_logic_vector(arith_out((size - 1) downto 0));

	-- ==================
	-- | ALU Arithmetic |
	-- ==================

	arith_op : process(sel(1 downto 0), a_bus, b_bus) is
	begin
		case sel(1 downto 0) is
			when "00" => arith_out <= (arith_out'range => '0');
			when "01" => arith_out <= ('0' & a_bus);
			when "10" => arith_out <= ('0' & a_bus) + b_bus;
			when "11" => arith_out <= ('0' & a_bus) - b_bus;
			when others => null;
		end case;
	end process;

	-- ===============
	-- |  ALU logic  |
	-- ===============

	logic_op : process(sel(1 downto 0), a, b) is
	begin
		case sel(1 downto 0) is
			when "00" => logic_out <= not a;
			when "01" => logic_out <= a and b;
			when "10" => logic_out <= a or b;
			when "11" => logic_out <= a xor b;
			when others => null;
		end case;
	end process;

	-- ===========
	-- |  Ouput  |
	-- ===========

	y <= result;

	-- Carry out flag
	cf <= arith_out(size);

	-- Overflow flag
	-- overflow condition
	-- 1. When two signed 2's complement numbers are added, the over flow is detected if:
    --        * both operands are positive and the result is negative, or
    --        * both operands are negative and the result is positive
    -- 2. When two unsigned numbers are added, the overflow occurrs if
    --        * there is a carry out of the left most bit

  	with sel select
  		ov <= ((a_bus(size - 1) and b_bus(size - 1) and not arith_out(size - 1))
  			or (a_bus(size - 1) nor b_bus(size - 1) and arith_out(size - 1)) when "010",

  			((not a_bus(size - 1) and b_bus(size - 1) and arith_out(size - 1)) or
  			 (a_bus(size - 1) and not b_bus(size - 1) and not arith_out(size - 1)) when "011",

  			'0' when others;

  	-- sign flag
  	sf <= arith_out(size - 1);

  	-- zero flag
  	zf <= '1' when result = (result'range >= '0') else '0';

end alu_arc;