/* 
Intro to IM
Arduino Assignment 3_Musical Instrument-Mini Piano
I made a mini piano with a buzzer and switches. There are three switches, each of which plays C or D or E note. 
If you start the program, the melody for "Mary Little Lamb" will be played, 
the song you can play with the three notes that switches play through the buzzer. 
While you push the switch to make a sound, the lamb (attached to the servo motor) will make moves. 

The link to the video of this work: https://youtu.be/SLZtUJMa43A

Materials Used:
3 Switches
1 Buzzer
1 Servo Motor

Written by Nakyeong Ahn
April 10, 2021
 */

#include "pitches.h" //notes are defined in this file
#include <Servo.h> //for usage of servo motor

Servo myservo;  // create servo object to control a servo

int pos = 0; //variable for position of motor

const int C = A0; //variable for switches
const int D = A2;
const int E = A4;

int melody[] = { //list of notes for melody
  NOTE_E, NOTE_D, NOTE_C, NOTE_D, NOTE_E, NOTE_E, NOTE_E, NOTE_D, NOTE_D, NOTE_D, NOTE_E, NOTE_E, NOTE_E,
  NOTE_E, NOTE_D, NOTE_C, NOTE_D, NOTE_E, NOTE_E, NOTE_E, NOTE_D, NOTE_D, NOTE_E, NOTE_D, NOTE_C
};

int rhythm[] = { //list of rhythm for melody
  10, 6, 8, 8, 8, 8, 4, 8, 8, 4, 8, 8, 4,
  10, 6, 8, 8, 8, 8, 4, 8, 8, 10, 6, 2
};

void setup() {

  for (int thisNote = 0; thisNote < 25; thisNote++) { //play the melody for once
    int rhythmDuration = 1000 / rhythm[thisNote];
    tone(8, melody[thisNote], rhythmDuration);
    int pauseBetweenNotes = rhythmDuration * 2.00;
    delay(pauseBetweenNotes); //pause between notes
    noTone(8);
  }
  pinMode(INPUT, C); //set switches as input
  pinMode(INPUT, D);
  pinMode(INPUT, E);

  myservo.attach(9); //set servomotor
}

void loop() {

  int C_read = digitalRead(C); //read the voltage from switches
  int D_read = digitalRead(D);
  int E_read = digitalRead(E);

  if (C_read == HIGH) { //if the switch is pushed
    tone(8, NOTE_C, 1000 / 8); //play the following note
  }
  if (D_read == HIGH) {
    tone(8, NOTE_D, 1000 / 8);
  }
  if (E_read == HIGH) {
    tone(8, NOTE_E, 1000 / 8);
  }
  if (E_read == HIGH || D_read == HIGH || C_read == HIGH) { //if any of the switches are pushed
    for (pos = 0; pos <= 180; pos += 1) { //move the servo motor
      myservo.write(pos);
    }
    for (pos = 180; pos >= 0; pos -= 1) {
      myservo.write(pos);
    }
  }
}
