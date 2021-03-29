/* 
Intro to IM
Arduino Assignment 2_Blinks and Blushes

As photosensor captures the stronger light, 
the eyes (blue lights) will blink faster and cheeks will get blush in a stronger red lights.

While you push the blue switch, 
the eye will be closed (blue lights) will be turned off and blushes will also get dimmer.

While you push the yellow switch, 
the eye will open up (blue lights) will be turned on strongly and blushes will also get stronger.

2 Blue LEDs
2 Red LEDs
2 Swithces
Photosensor

Written by Nakyeong Ahn
March 30, 2021
 */

const int led1 = 5; //variables for blue lights
const int led2 = 3;
const int LDRPIN = A2; //variable for photosensor
const int btn1 = A4; //variables for switches
const int btn2 = A5;
const int led3 = 11; //variables for red lights
const int led4 = 9;

void setup() {
  // put your setup code here, to run once:
  pinMode(led1, OUTPUT); //set blue lights as outputs
  pinMode(led2, OUTPUT);
  pinMode(btn1, INPUT); //set swithces as inputs
  pinMode(btn2, INPUT);
  
  Serial.begin(9600);
}

void loop() {
  
  int sensorValue = analogRead(LDRPIN); //read from photosensor
  int btnread1 = digitalRead(btn1); //read from switches
  int btnread2 = digitalRead(btn2);
  int v = map(sensorValue, 0, 1023, 700, 100); //map sensorValue into a delay speed from 100 to 700 for a blinking speed
  int brightness = map (sensorValue, 0, 1023, 0, 200); //map sensorValue into a brightness for cheeks

  if (btnread1 == HIGH) { //if blue switch is pushed
    digitalWrite(led1, LOW); //turn off blue lights
    digitalWrite(led2, LOW);
    analogWrite(led3, 5); //make red lights dimmer
    analogWrite(led4, 5);
    delay(30);

  } else if (btnread2 == HIGH) { //if yellow switch is pushed
    digitalWrite(led1, HIGH); //turn on red blue lights
    digitalWrite(led2, HIGH);
    analogWrite(led3, 255); //make red lights stronger
    analogWrite(led4, 255); 
    delay(30);
  } else { //if no switch is pushed, blinking motion
    digitalWrite(led1, HIGH); //turn on
    digitalWrite(led2, HIGH);
    delay(v); //spped of delay is influenced by the intensity of light

    digitalWrite(led1, LOW); //turn off
    digitalWrite(led2, LOW);
    delay(v); //delay

    analogWrite(led3, brightness); //cbrightness of red lights is influenced by the intensity of light
    analogWrite(led4, brightness);
    delay(20);

  }


}
