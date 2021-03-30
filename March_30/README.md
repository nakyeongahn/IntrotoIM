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
2. If I cover the photosensor with my finger, the sensor detects the light of less intensity <br>
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
const int r_led = 13; //variables for led lights
const int b_led = 11;
const int y_led = 9;
const int g_led = 7;

const int r_btn = A0; //variables for switches
const int b_btn = A1;
const int y_btn = A2;
const int g_btn = A5;
```

Since my game is to turn on all lights permanently, I also added boolean variables to check if each light is on.
```
boolean y_on = false; //check if each led light is turned on
boolean g_on = false;
boolean r_on = false;
boolean b_on = false;
```
In the loop(), I used a lot of if conditions to check if the switch was pushed and make the following responses by the LED lights.

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

