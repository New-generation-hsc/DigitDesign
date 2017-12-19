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
-- |   000  |     A     |
-- |   001  |     B     |
-- |   010  |   A + B   |
-- |   011  |   A - B   |
-- |   100  |     !A    |
-- |   101  |   A and B |
-- |   110  |   A or B  |
-- |   111  |   A xor B |
-- ======================

-- ==========================
-- |      ALU operations    |
-- ==========================
-- |   sel  |       Y       |
-- --------------------------
-- |   0000  |     HALT     |
-- |   0001  |     LDA X    |
-- |   0010  |     STA X    |
-- |   0011  |     ADD X    |
-- |   0100  |     SUB X    |
-- |   0101  |     AND X    |
-- |   0110  |     OR  X    |
-- |   0111  |     NOT X    |
-- |   1000  |     XOR X    |
-- |   1001  |     JMP X    |
-- |   1010  |     JZ  X    |
-- |   1011  |     SHR X    |
-- ==========================

-- Author : huangshicai
-- mail : 1309508226@qq.com
-- Revision : Version 0.1 2017/12/19
---------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	port (
			sel : in std_logic_vector(3 downto 0); -- the operaion code
			a : in std_logic_vector(15 downto 0); -- a bus, first operand
			b : in std_logic_vector(15 downto 0); -- b bus, second operand

			cf : out std_logic; -- the carry flag
			zf : out std_logic; -- the zero flag
			ov : out std_logic; -- the overflow flag
			sf : out std_logic; -- the sign flag

			y : out std_logic_vector(15 downto 0) -- the operation result
		);
end alu;

architecture alu_arc of alu is
signal a_bus, b_bus : unsigned(15 downto 0);  -- proper operation
signal arith_out : unsigned(16 downto 0); -- the arithmetic tempory result
signal logic_out : std_logic_vector(15 downto 0); -- the logic result
signal result : std_logic_vector(15 downto 0);
begin
	
	-- extension
	a_bus <= unsigned(a);
	b_bus <= unsigned(b);

	-- the opcode(2) discriminates logic vs arithmetic
	result <= logic_out when sel(2) else std_logic_vector(arith_out(15 downto 0));

	-- ==================
	-- | ALU Arithmetic |
	-- ==================

	arith_op : process(sel, a_bus, b_bus) is
	begin
		case sel is
			when "0011" => arith_out <= ('0' & a_bus) + b_bus;
			when "0100" => arith_out <= ('0' & a_bus) - b_bus;
			when others => null;
		end case;
	end process;

	-- ===============
	-- |  ALU logic  |
	-- ===============

	logic_op : process(sel, a, b) is
	begin
		case sel(1 downto 0) is
			when "0101" => logic_out <= a and b;
			when "0110" => logic_out <= a or b;
			when "0111" => logic_out <= not a;
			when "1000" => logic_out <= a xor b;
			when others => null;
		end case;
	end process;

	-- ===========
	-- |  Ouput  |
	-- ===========

	y <= result;

	-- Carry out flag
	cf <= arith_out(16);

	-- Overflow flag
	-- overflow condition
	-- 1. When two signed 2's complement numbers are added, the over flow is detected if:
    --        * both operands are positive and the result is negative, or
    --        * both operands are negative and the result is positive
    -- 2. When two unsigned numbers are added, the overflow occurrs if
    --        * there is a carry out of the left most bit

  	with sel select
  		ov <= ((a_bus(15) and b_bus(15) and not arith_out(15))
  			or (a_bus(15) nor b_bus(15) and arith_out(15)) when "010",

  			((not a_bus(15) and b_bus(15) and arith_out(15)) or
  			 (a_bus(15) and not b_bus(15) and not arith_out(15)) when "011",

  			'0' when others;

  	-- sign flag
  	sf <= arith_out(15);

  	-- zero flag
  	zf <= '1' when result = (result'range >= '0') else '0';

end alu_arc;