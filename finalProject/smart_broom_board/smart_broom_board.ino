/* 
Intro to IM
Final Project: Smart Broom

This RC car with a broom attached at the end will clean your place!

This program codes for a RC car which avoids obstacles automatically using an ultrasonic sensor.
Ultrasonic sensor detects obstacles from 40 to 140 (angle) and the rotation happen with the help of a servo motor.
Once it receives a signal from Processing program, the RC car starts moving as coded.
Along with its movements, the relevant information is being written on the port.

Written by Nakyeong Ahn
April 29, 2021
*/

#define TRIG 2 //used for ultrasonic sensor
#define ECHO 3

#include <Servo.h> //import library for servo motor
Servo myservo;

const int ain1Pin = 13; //set variables for DC motors
const int ain2Pin = 12;
const int pwmAPin = 11;

const int bin1Pin = 8; //set variables for DC motors
const int bin2Pin = 9;
const int pwmBPin = 10;

int angle = 90; //variable used to set angle for servo motor
int echotime;
float distance; //variable to store distance for the ultrasonic sensor
int state = 10; //variable for angle used to rotate the servo motor

int on = 0; //variable used to receive info from processing
int back = 0; //variable to check if it detected obstacles
int left = 0; //variable to check in which angle the obstacle was detected
int right = 0;

void setup() {

  Serial.begin(9600); 

  pinMode(ain1Pin, OUTPUT); //set DC motors as output
  pinMode(ain2Pin, OUTPUT);
  pinMode(pwmAPin, OUTPUT);

  pinMode(bin1Pin, OUTPUT);
  pinMode(bin2Pin, OUTPUT);
  pinMode(pwmBPin, OUTPUT);

  myservo.attach(6); //set the servomotor

  pinMode(TRIG, OUTPUT); //set the ultrasonic sensor
  pinMode(ECHO, INPUT);

}

void loop() {
  
  Serial.print(0); //to send the initial information to processing
  Serial.print(",");
  Serial.print(0);
  Serial.print(",");
  Serial.println(0);
  
  while (Serial.available()) {
    on = Serial.parseInt();
    if (Serial.read() == '\n') {
      if (on == 1) { //if the processing sends this value, the movement will start
        myservo.write(angle); //set servomotor to 90 degree angle (front)
        delay(50);

        digitalWrite(TRIG, HIGH); //to make the ultrasonic detect obstacles
        delayMicroseconds(10);
        digitalWrite(TRIG, LOW);

        echotime = pulseIn (ECHO, HIGH);
        distance = echotime * (17.0 / 1000); //calculate the distance of obstacles.

        if (distance > 0 && distance < 15) { //if the distance is smaller than 15cm
          movePattern();
          moveForward();
        }
        if (distance > 15) { //if the distance is greater than 15cm
          back = 0; //reset the variables for checking the presence of obstacles
          left = 0;
          right = 0;
          moveForward();
        }

        if (angle == 140) state = -10; //to make the servomotor rotate
        else if (angle == 40) state = 10;
        angle += state;
        delay(100);

        Serial.print(back); //send the information of obstacles to processing
        Serial.print(",");
        Serial.print(left);
        Serial.print(",");
        Serial.println(right);
      }
      if (on == 0){ //if the processing says to pause
        analogWrite(pwmAPin, 0); //the speed of the motor will be 0
        analogWrite(pwmBPin, 0);
      }
    }
  }
}


void moveForward() { //this fuction codes for the car to move forward at full speed

  analogWrite(pwmAPin, 255);
  digitalWrite(ain1Pin, HIGH);
  digitalWrite(ain2Pin, LOW);

  analogWrite(pwmBPin, 255);
  digitalWrite(bin1Pin, HIGH);
  digitalWrite(bin2Pin, LOW);

}

void moveBackward() { //this function codes for the car to move backward at full speed
  back = 1;
  analogWrite(pwmAPin, 255);
  digitalWrite(ain1Pin, LOW);
  digitalWrite(ain2Pin, HIGH);

  analogWrite(pwmBPin, 255);
  digitalWrite(bin1Pin, LOW);
  digitalWrite(bin2Pin, HIGH);
}


void movePattern() { //if the car detects obstacles
  moveBackward(); //move backward
  delay(500);
  if (angle >= 90) { //if the obstacle is at the right side, turn left
    analogWrite(pwmAPin, 255);  
    digitalWrite(ain1Pin, HIGH);
    digitalWrite(ain2Pin, LOW);

    analogWrite(pwmBPin, 255);
    digitalWrite(bin1Pin, LOW);
    digitalWrite(bin2Pin, HIGH);

    right = 1;
    left = 0;

    delay(500);
  }
  else {
    analogWrite(pwmAPin, 255); //if the obstacle is at the left side, turn left
    digitalWrite(ain1Pin, LOW);
    digitalWrite(ain2Pin, HIGH);

    analogWrite(pwmBPin, 255);
    digitalWrite(bin1Pin, HIGH);
    digitalWrite(bin2Pin, LOW);

    delay(500);

    left = 1;
    right = 0;
  }

  angle = 90; //change the direction the servo motor rotates
  if (state = 10) {
    state = -10;
  } else if (state = -10){
    state = 10;
  }
  myservo.write(angle);
  delay(100);
}
