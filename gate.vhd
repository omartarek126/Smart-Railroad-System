library ieee;
use ieee.std_logic_1164.all;

ENTITY gate IS

	PORT(clk, switch : IN STD_LOGIC;
		  pwm: OUT STD_LOGIC);
			
END gate;

ARCHITECTURE archGate OF gate IS

	constant clk_hz : real := 10.0e6; 
	constant pulse_hz : real := 50.0;
	constant min_pulse_us : real := 900.0;
	constant max_pulse_us : real := 2100.0; 
	constant step_count : positive := 256;
	signal position : integer range 0 to step_count - 1;
  
	COMPONENT servo 
		generic (
		 clk_hz : real;
		 pulse_hz : real; 
		 min_pulse_us : real;
		 max_pulse_us : real; 
		 step_count : positive 
	  );
		port (
		 clk : in std_logic;
		 rst : in std_logic;
		 position : in integer range 0 to step_count - 1;
		 pwm : out std_logic
	  );
	END COMPONENT;

BEGIN
	
	position <= 0 when switch = '1' else 255;

	ServoMapping : servo generic map (clk_hz,pulse_hz,min_pulse_us,max_pulse_us,step_count) port map (clk,'0',position,pwm);

END archGate;