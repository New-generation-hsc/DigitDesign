-------------------------------
-- Design Unit : memory 
-- File Name : memory.vhd

-- Description : 
-- this is the memory module
-- the main storage of the computer
-- permanent store

--       Main Memory
-- ---------------------
-- |  0 word * 16 bit  |
-- ---------------------
-- |  1 word * 16 bit  |
-- ---------------------
-- |         -         |
-- |         -         |
-- |         -         |
-- ---------------------
-- | 255 word * 16 bit |
-- ---------------------  

-- Author : huangshicai
-- mail : 1309508226@qq.com
-- Revision : Version 0.0 2017/12/19
---------------------------------

entity memory is
	port (
		clock : in std_logic;

		address : in std_logic_vector(7 downto 0); -- the memory address, locate the memory
		we : in std_logic; -- write enable signal
		Din : in std_logic_vector(15 downto 0); -- data input

		Dout : out std_logic_vector(15 downto 0) -- data output
	);
end memory;

architecture dataflow of memory is
	type main_memory is array(0 to 255) of std_logic_vector(15 downto 0);

	signal memory : main_memory := 
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