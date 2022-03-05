library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY test IS

	PORT(clk, sensorOpen,sensorClose: IN STD_LOGIC;
		  pwm, lightgo,lightstop,lightyellow: OUT STD_LOGIC;
		  signLabel: OUT STD_LOGIC_VECTOR(47 DOWNTO 0));
	
END test;

ARCHITECTURE archTest OF test IS

	SIGNAL openGate: std_logic := '1';
	SIGNAL delayedOpenGate: std_logic := '1';
	SIGNAL pulse: std_LOGIC := '0';
	SIGNAL count: integer range 0 to 50000000 := 0;
	SIGNAL countdown: integer range -1 to 15 := 0;
	SIGNAL stopcounting: std_logic := '1';
	
	COMPONENT gate
		PORT(clk, switch : IN STD_LOGIC;
		  pwm: OUT STD_LOGIC);
	END COMPONENT;

BEGIN

	PROCESS(sensorOpen,sensorClose,clk)
	BEGIN
			IF clk'event and clk = '1' then
				IF openGate = '0' AND stopcounting = '0' then
					IF count = 5000000 then
						count <= 0;
						countdown <= countdown + 1;
						pulse <= not pulse;
					ELSE
						count <= count + 1;
					END IF;
					
					IF countdown = 10 then
						delayedOpenGate <= '0';
						pulse <= '0';
						count <= 0;
						stopcounting <= '1';
						countdown <= -1;
					END IF;
				END IF;
			END IF;
			
			IF sensorOpen = '0' THEN
				openGate <= '1';
				delayedOpenGate <= '1';
				stopcounting <= '0';
				countdown <= 0;
			ELSIF sensorClose'EVENT AND sensorClose = '0' THEN
				openGate <= '0';
			END IF;
	END PROCESS;
	
	gateMapping: gate port map(clk,delayedOpenGate,pwm);
	
	lightgo <= delayedOpenGate AND openGate;
	lightstop <= NOT delayedOpenGate;
	lightyellow <= pulse AND (NOT openGate) AND delayedOpenGate;
	WITH countdown SELECT
							signLabel <= "011111110111111111000000110100000111111101111111" WHEN 0,
											 "011111110111111101111111100010110111111101111111" WHEN 1,
											 "011111110111111101111111100010110111111101111111" WHEN 2,
											 "011111110111111101111111100001100111111101111111" WHEN 3,
											 "011111110111111101111111100001100111111101111111" WHEN 4,
											 "011111110111111101111111101001000111111101111111" WHEN 5,
											 "011111110111111101111111101001000111111101111111" WHEN 6,
											 "011111110111111101111111110011110111111101111111" WHEN 7,
											 "011111110111111101111111110011110111111101111111" WHEN 8,
											 "011111111010000111000000101110001001001001111111" WHEN OTHERS;
											 
END archTest;