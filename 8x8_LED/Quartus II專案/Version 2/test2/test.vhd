Library IEEE;
USE ieee.std_logic_1164.all;

Entity test is
	port(
		CLK:in std_logic;
		RESET:in std_logic;
		FRAME_NUMBER:in integer range 0 to 3;
		C	: out std_logic_vector(1 to 8);
		R	: out std_logic_vector(1 to 8)
	);
end test;

Architecture ar of test is
	Type ROM_table8x8 is array (0 to 7) of std_logic_vector(0 to 7);
	Constant FRAME_0 : ROM_table8x8 := (	("00111100"),
														("01000010"),
														("01000010"),
														("01000010"),
														("01000010"),
														("01000010"),
														("01000010"),
														("00111100"));
	
	Constant FRAME_1 : ROM_table8x8 := (	("00001000"),
														("00011000"),
														("00001000"),
														("00001000"),
														("00001000"),
														("00001000"),
														("00001000"),
														("11111111"));
														
	Constant FRAME_2 : ROM_table8x8 := (	("00111100"),
														("00000010"),
														("00000010"),
														("10000100"),
														("01001000"),
														("01010000"),
														("00100000"),
														("01111110"));
														
	Constant FRAME_3 : ROM_table8x8 := (	("00111100"),
														("01000010"),
														("00000010"),
														("10011100"),
														("01000010"),
														("01100010"),
														("00100010"),
														("00111100"));
														
	
	
	signal rowRoter : std_logic_vector(0 to 7) :="10000000";
	signal rowCounter : integer range 0 to 7 :=0;
	signal frame : ROM_table8x8;
	
	begin		
		with FRAME_NUMBER select
			frame <=	FRAME_0 when 0,
						FRAME_1 when 1,
						FRAME_2 when 2,
						FRAME_3 when others;
						
	process (CLK, RESET) is
		begin
			if(RESET = '1')then
			rowCounter <= 0;
			rowRoter <= "10000000";
			elsif(rising_edge(CLK)) then
				c <= not frame(rowCounter);
				R <= rowRoter;
				rowRoter <= rowRoter(7) & rowRoter(0 to 6);
				rowCounter <= rowCounter + 1;
			end if;
	end process;
	
end Architecture;