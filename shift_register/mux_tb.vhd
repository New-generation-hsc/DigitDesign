library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- for type conversions

entity mux_tb is
end mux_tb;

architecture mux_tb_arc of mux_tb is
component mux
	port (
		s : in std_logic_vector(1 downto 0); -- select signal

		hold, left, right, data : in std_logic; -- the 4 selected items

		sout : out std_logic -- selected output
	);
end component;

signal ihold, ileft, iright, idata, cout: std_logic := '0';
signal si : std_logic_vector(1 downto 0) := "00";
begin
	proc : mux port map(s => si, hold => ihold, left => ileft, right => iright, data => idata, sout => cout);

	proc1 : process
	begin

		wait for 20 ns;

		ihold <= '1';
		wait for 20 ns;

		ihold <= '0';
		ileft <= '1';
		si <= "01";
		wait for 20 ns;

		ileft <= '0';
		iright <= '1';
		si <= "10";
		wait for 20 ns;

		iright <= '0';
		idata <= '1';
		si <= "11";
		wait for 20 ns;
		
		assert false report "end of test" severity note;
	end process;

end mux_tb_arc;