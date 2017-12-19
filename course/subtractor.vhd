
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- for type conversions

entity subtractor is
	port (
			A, B, C: in std_logic;
			S, Cout : out std_logic
		);
end subtractor;

architecture subtractor_arc of subtractor is
begin
	S <= A xor B xor C;
	Cout <= ((not A) and (B xor C)) or (B and C); 
end subtractor_arc;
