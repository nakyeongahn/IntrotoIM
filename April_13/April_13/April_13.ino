/* 
Intro to IM
Arduino Assignment 4_Grow Your Plant
This is a game where you can push switches on the arduino to control the movement of the pot to catch raindrops or an insect.

If the flower catches raindrops, the flower will grow and the green light will turn on. 
If the flower encounters an insect, the height of the flower will decrease and the red light will turn on.

THe brightness of the flower will be determined by the photosensor of the arduino board. The brighter light the sensor captures, the brighter the screen will be.

* If the height of the flower becomes negligible, you die!*
* If the height of the flower is over 200, you win!*

Written by Nakyeong Ahn
April 15, 2021
*/

int lose=0; //variable for lights
int gain=0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println("0,0");
  pinMode(2,OUTPUT); //set LED lights as outputs
  pinMode(5,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
    while (Serial.available()) { //when there is something written in the port
    lose = Serial.parseInt();
    gain = Serial.parseInt();
    if (Serial.read() == '\n') { //read what's written
      digitalWrite(2, gain); //turn on or off LED lights based on the info read
      digitalWrite(5, lose);
      int sensor = analogRead(A1); //get values from sensors and switches
      delay(1);
      int left = digitalRead(A2);
      delay(1);
      int right = digitalRead(A4);
      delay(1);
      Serial.print(sensor); //write values from sensors on the port
      Serial.print(',');
      Serial.print(left);
      Serial.print(',');
      Serial.println(right);
    }
  }
}
