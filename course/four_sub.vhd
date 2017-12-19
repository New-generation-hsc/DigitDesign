
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- for type conversions

entity four_sub is
	port (
			A, B : in std_logic_vector(3 downto 0);
			C : in std_logic;

			S : out std_logic_vector(3 downto 0);
			Cout : out std_logic
		);
end four_sub;

architecture four_sub_arc of four_sub is
component subtractor
	port (
			A, B, C: in std_logic;
			S, Cout : out std_logic
		);
end component;
signal cout0, cout1, cout2 : std_logic;
begin
	proc0 : subtractor port map(A(0), B(0), C, S(0), cout0);
	proc1 : subtractor port map(A(1), B(1), cout0, S(1), cout1);
	proc2 : subtractor port map(A(2), B(2), cout1, S(2), cout2);
	proc3 : subtractor port map(A(3), B(3), cout2, S(3), Cout);
end four_sub_arc;

