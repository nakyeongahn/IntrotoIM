#include "pitches.h"
#include <Servo.h>

Servo myservo;  // create servo object to control a servo

int pos = 0;

const int C = A0;
const int D = A2;
const int E = A4;

int melody[] = {
  NOTE_E, NOTE_D, NOTE_C, NOTE_D, NOTE_E, NOTE_E, NOTE_E, NOTE_D, NOTE_D, NOTE_D, NOTE_E, NOTE_E, NOTE_E,
  NOTE_E, NOTE_D, NOTE_C, NOTE_D, NOTE_E, NOTE_E, NOTE_E, NOTE_D, NOTE_D, NOTE_E, NOTE_D, NOTE_C
};

int rhythm[] = {
  10, 6, 8, 8, 8, 8, 4, 8, 8, 4, 8, 8, 4,
  10, 6, 8, 8, 8, 8, 4, 8, 8, 10, 6, 2
};

void setup() {
  // put your setup code here, to run once:

  for (int thisNote = 0; thisNote < 25; thisNote++) {
    int rhythmDuration = 1000 / rhythm[thisNote];
    tone(8, melody[thisNote], rhythmDuration);
    int pauseBetweenNotes = rhythmDuration * 2.00;
    delay(pauseBetweenNotes);
    noTone(8);
  }
  pinMode(INPUT, C);
  pinMode(INPUT, D);
  pinMode(INPUT, E);

  myservo.attach(9);
}

void loop() {
  //   put your main code here, to run repeatedly:
  int C_read = digitalRead(C);
  int D_read = digitalRead(D);
  int E_read = digitalRead(E);

  if (C_read == HIGH) {
    tone(8, NOTE_C, 1000 / 8);
  }
  if (D_read == HIGH) {
    tone(8, NOTE_D, 1000 / 8);
  }
  if (E_read == HIGH) {
    tone(8, NOTE_E, 1000 / 8);
  }
  if (E_read == HIGH || D_read == HIGH || C_read == HIGH) {
    for (pos = 0; pos <= 180; pos += 1) {
      myservo.write(pos);
//      delay(5);
    }
    for (pos = 180; pos >= 0; pos -= 1) {
      myservo.write(pos);
//      delay(5);
    }
  }
}
