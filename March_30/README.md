# Arduino Assignment 2: Blinks and Blushes

I wanted to express how our eyes and cheeks response under different intensity of light.

Based on the intensity of light the photosensor captures, the speed of the eye blinking motion and the redness of blush changes. The stronger lights will make eyes blink faster and stronger red the blush will be, as humans are under the strong lights.

As photosensor captures the stronger light, 
the eyes (blue lights) will blink faster and cheeks will get blush in a stronger red lights.

While you push the blue switch, 
the eye will be closed (blue lights) will be turned off and blushes will also get dimmer.

While you push the yellow switch, 
the eye will open up (blue lights) will be turned on strongly and blushes will also get stronger.

Materials Used:<br>
2 Blue LEDs<br>
2 Red LEDs<br>
2 Swithces<br>
Photosensor<br>

### Circuit
<p align="center">
  This is how my scheme looks like: <br>
  <img src="schematic.jpg" width="800" height="600"><br>
  This is how my board looks like: <br>
  <img src="circuit.png" width="500" height="600"><br>
</p>

### How to Play
1. As programs are uploaded, the eyes will blink and cheeks will show the red light with intensity corresponding to the environment.
  <p align="center">
  <img src="normal.gif" width="400" height="600"><br>
  </p>
2. If I cover the photosensor with my finger, the sensor detects the light of less intensity. The blinking motion will get slower and the blush will be dimmer. <br>
  <p align="center">
  <img src="dark.gif" width="400" height="600"><br>
  </p>
3. If the board is placed under the strong light, the blue lights will blink faster and cheeks will present a stronger red light. <br>
  <p align="center">
  <img src="brighter.gif" width="400" height="600"><br>
  </p>
4. While blue switch is pushed, the eyes will be closed, expressed as blue lights being turned off. And cheeks will also get dimmer. <br>
  <p align="center">
  <img src="blue_btn.gif" width="400" height="600"><br>
  </p>
5. While yellow switch is pushed, the eyes will be open, expressed as blue lights being turned on. And cheeks will also get brighter. <br>
  <p align="center">
  <img src="yellow_btn.gif" width="400" height="600"><br>
  </p>

### Code
I first made const int variables for following numbers for switches and LED lights.
```
const int led1 = 5; //variables for blue lights
const int led2 = 3;
const int LDRPIN = A2; //variable for photosensor
const int btn1 = A4; //variables for switches
const int btn2 = A5;
const int led3 = 11; //variables for red lights
const int led4 = 9;
```

The intensity of light from photosensor and the voltage from switch is read from following lines.
```
int sensorValue = analogRead(LDRPIN); //read from photosensor
int btnread1 = digitalRead(btn1); //read from switches
int btnread2 = digitalRead(btn2);
```
If the blue switch is pushed, the motions are controlled by following lines.
```
if (btnread1 == HIGH) { //if blue switch is pushed
    digitalWrite(led1, LOW); //turn off blue lights
    digitalWrite(led2, LOW);
    analogWrite(led3, 5); //make red lights dimmer
    analogWrite(led4, 5);
    delay(30);
}
```

If the yellow switch is pushed, the motions are controlled by following lines.
```
else if (btnread2 == HIGH) { //if yellow switch is pushed
    digitalWrite(led1, HIGH); //turn on red blue lights
    digitalWrite(led2, HIGH);
    analogWrite(led3, 255); //make red lights stronger
    analogWrite(led4, 255); 
    delay(30);
}
```
When no switch is being pushed, the motions are controlled by following lines.
```
else { //if no switch is pushed, blinking motion
    digitalWrite(led1, HIGH); //turn on
    digitalWrite(led2, HIGH);
    delay(v); //spped of delay is influenced by the intensity of light

    digitalWrite(led1, LOW); //turn off
    digitalWrite(led2, LOW);
    delay(v); //delay

    analogWrite(led3, brightness); //brightness of red lights is influenced by the intensity of light
    analogWrite(led4, brightness);
    delay(20);
}
```

### Difficulties
I was not really familiar with the whole concept of circuit and how to build it, so it took quite a bit of time to build the circuit with 4 switches and 4 LED lights.The wire part of resistor and LED lights are so sharp and I hurt my hands:( Also, I had accidentally pulled one wire, which made me build the whole circuit again. <br><br>

For the programming part, everything was pretty smooth except that there were new functions or methods I wasn't really familiar with.
The hardest part for programming was when turning on the green LED. Red and green switches should be pushed consecutively, regardless of order, so I had to calculate various cases and control them by giving them conditions.

```
if (g_chance_by_y == true) { //check if chances for a green light are on by a yellow light
      if (g_read == HIGH) { //if a blue lights is turned on (g_btn turns on blue)
        g_on = true; //turn on green (yellow + blue)
        digitalWrite(g_led, HIGH);
      }
      if (r_read == HIGH or b_read == HIGH or y_read == HIGH) { //if any other switches are pushed 
        g_chance_by_y = false; //chance is gone again
      }
    }
    if (g_chance_by_b == true) { //check if chances for a green light are on by a blue light
      if (r_read == HIGH) { //if a yellow light is turned on (r_btn turns on yellow)
        g_on = true; //turn on green (blue + yello)
        digitalWrite(g_led, HIGH);
      }
      if (g_read == HIGH or b_read == HIGH or y_read == HIGH) { //if any other switches are pushed
        g_chance_by_y = false; //chance is gone againe
      }
    }
```

