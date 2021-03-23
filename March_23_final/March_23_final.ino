/* 
Intro to IM
Arduino Assignment 1_Make a puzzle with led lights and switches

I used 4 led lights (red, blue, yellow, green) and 4 switches to make a puzzle.
To start the game, you can push any of switches.
Then the light will turn on in the way which users should try to achieve.
You will have a chance to push all switches to find out which led light it turns on.

HINT:
1. Which two colors mix up to make one color?
2. Use you chance to find out what color each switches light up and click according switches three times!

Written by Nakyeong Ahn
March 23, 2021
 */
boolean start = false; //variable for starting the game

const int r_led = 13; //variables for led lights
const int b_led = 11;
const int y_led = 9;
const int g_led = 7;

const int r_btn = A0; //variables for switches
const int b_btn = A1;
const int y_btn = A2;
const int g_btn = A5;

int r_cnt = 0; //count how many times each lights are turned on
int b_cnt = -1;
int y_cnt = -2;
int g_cnt = 0;

boolean g_chance_by_y = false; //variables to check if green led is ready to be turned on
boolean g_chance_by_b = false;

boolean halfway = false; //check if the game is halfway done

boolean y_on = false; //check if each led light is turned on
boolean g_on = false;
boolean r_on = false;
boolean b_on = false;

void setup() {
  //set outputs as led lights
  pinMode(r_led, OUTPUT); 
  pinMode(b_led, OUTPUT);
  pinMode(y_led, OUTPUT);
  pinMode(g_led, OUTPUT);

  //set inputs as switches
  pinMode(r_btn, INPUT);
  pinMode(b_btn, INPUT);
  pinMode(y_btn, INPUT);
  pinMode(g_btn, INPUT);
}

void loop() {
  
  //set variables for reading the voltage in led lights
  int r_read = digitalRead(A0);
  int b_read = digitalRead(A1);
  int y_read = digitalRead(A2);
  int g_read = digitalRead(A5);
  
  if (start == false) { //before the game begins
    if (r_read == HIGH or b_read == HIGH or y_read == HIGH or g_read == HIGH) { //if any of switches are pushed
      start = true; //game starts

      for (int i = 0; i < 3; i++) { //turn on all the lights and off three times
        digitalWrite(r_led, HIGH);
        digitalWrite(b_led, HIGH);
        digitalWrite(y_led, HIGH);
        digitalWrite(g_led, HIGH);

        delay(200);

        digitalWrite(r_led, LOW);
        digitalWrite(b_led, LOW);
        digitalWrite(y_led, LOW);
        digitalWrite(g_led, LOW);

        delay(200);
      }
    }
  } else { //if game starts

    //green led turns on if yellow and blue lights are turned on right after each other
    
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

    //set which switch turns on which light
    
    if (r_read == HIGH and y_on == false) { //r_switch turns on yellow if yellow is still off
      r_cnt = r_cnt + 1;
      digitalWrite(y_led, HIGH);
      delay(100);
      digitalWrite(y_led, LOW);
      delay(100);
      if (r_cnt > 1 and g_on == false and g_chance_by_y == false) { //turn on the chance
        g_chance_by_y = true;
      }
      if (g_on == true) { //after green is on, count how many time yellow is turned on
        y_cnt = y_cnt + 1;
      }
    }
    if (b_read == HIGH and g_on == false) { //if blue switch is pushed and no lights are turned on yet
      digitalWrite(g_led, HIGH); //turn on green light
      delay(100);
      digitalWrite(g_led, LOW);
      delay(100);
    }

    if (b_read == HIGH and g_on == true) { //if blue switch is pushed and green light is on
      if (y_on == false) { //if yellow is off
        digitalWrite(y_led, HIGH); //turn on yellow
        delay(100);
        digitalWrite(y_led, LOW);
        delay(100);
        y_cnt = y_cnt + 1; //count how many times yellow is turned on
      }
    }

    if (y_read == HIGH and halfway == false) { //if yellow switch is turned on before half of lights are turned on
      digitalWrite(r_led, HIGH); //turn on red light
      delay(100);
      digitalWrite(r_led, LOW);
      delay(100);
    }
    
    if (g_read == HIGH and halfway == false) { //if green switch is turned on before half of lights are turned on
      g_cnt = g_cnt + 1; //update g_cnt
      digitalWrite(b_led, HIGH); //turn on blue light
      delay(100);
      digitalWrite(b_led, LOW);
      delay(100);
      if (g_cnt > 1 and g_on == false and g_chance_by_y == false) { //turn on change for green light
        g_chance_by_b = true;
      }
    }
    
    if (y_cnt > 2) { //if y_cnt is pushed 3 times
      y_on = true; //turn on yellow led
      digitalWrite(y_led, HIGH);
      halfway = true;
    }
    if (b_cnt > 2) { //if b_cnt is pushed 3 times
      b_on = true; //turn on blue led
      digitalWrite(b_led, HIGH);
    }
    if (halfway) { //after half of lights are turned on
      if (b_on == false) { //and blue led is off
        if (r_read == HIGH or b_read == HIGH or y_read == HIGH) { //set the colors again each switch can light up
          digitalWrite(r_led, HIGH);
          delay(100);
          digitalWrite(r_led, LOW);
          delay(100);
        }
      }
      if (g_read == HIGH and b_on == false) { //if green switch is pushed
        digitalWrite(b_led, HIGH); //turn on blue light momentarily
        delay(100);
        digitalWrite(b_led, LOW);
        delay(100);
        b_cnt = b_cnt + 1; //update b_cnt
        r_cnt = -2; //set r_cnt
      }
      if (b_on == true and r_on == false) { //if blue led is on and red is still off
        if (y_read == HIGH or b_read == HIGH) { //set the color each switch can light up again
          digitalWrite(r_led, HIGH);
          delay(100);
          digitalWrite(r_led, LOW);
          delay(100);
          r_cnt += 1; //update r_cnt
        }
        if (r_cnt > 2) { //if red light is turned on momentarily for three times
          r_on = true; //turn on red
          digitalWrite(r_led, HIGH);
        }
      }
    }
  }
}
