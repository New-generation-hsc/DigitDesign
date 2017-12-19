-- package for opertion code
-- the operation code include 4 bits that can contain 16 kinds of operations
-- but in this instrunction set, we just list 12 opertions

library ieee;
use ieee.std_logic_1164.all;

package opcode_pkg is

	constant SUB : std_logic_vector(3 downto 0) := "0000";
	constant LDA : std_logic_vector(3 downto 0) := "0001";
	constant STA : std_logic_vector(3 downto 0) := "0010";
	constant ADD : std_logic_vector(3 downto 0) := "0011";
	constant SUB : std_logic_vector(3 downto 0) := "0100";
	constant AND : std_logic_vector(3 downto 0) := "0101";
	constant OR  : std_logic_vector(3 downto 0) := "0110";
	constant NOT : std_logic_vector(3 downto 0) := "0111";
	constant XOR : std_logic_vector(3 downto 0) := "1000";
	constant JMP : std_logic_vector(3 downto 0) := "1001";
	constant JZ  : std_logic_vector(3 downto 0) := "1010";
	constant SHR : std_logic_vector(3 downto 0) := "1011";

end package opcode_pkg;
