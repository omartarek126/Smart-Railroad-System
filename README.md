
# Smart Railroad System

The idea behind this project is to implement a smart traffic light at an intersection between a road and a railway. Essentially, the green traffic light is always on and cars are free to come and go until a train is detected by an IR sensor. When the sensor detects a train, the yellow traffic light turns on and a countdown starts on the FPGA 7-segment display for 5 seconds. Then, the red traffic light turns on and the gate is closed, until the train is detected by a sensor further down on the other side of the road, which indicates that the train has fully crossed, and the green traffic light turns back on and the process is repeated.

## Technologies Used

- VHDL
- ModelSim
- Intel Quartus Prime

## Components Used

- Altera MAX10 FPGA Board
- Infrared obstacle avoidance sensors
- Micro Servo motor (FS90MG)
- Mini LEDs
- Jumper Cables
- Breadboard
- Toy train, cars, gates...etc

## Entities

- Test Entity => Contains the main code
- Gate Entity => Contains the code for controlling the gate using the servo motor
- Servo Entity => Contains the code for controlling servo motor using PWM

## Preview Video

https://user-images.githubusercontent.com/61099815/156923230-b98f2b27-9166-4e5b-a3a2-0aa69043614c.MOV

## Circuit Connections

![Project Report](https://user-images.githubusercontent.com/61099815/156923315-acaa4671-dd48-4a0d-8301-a77927242969.jpg)
