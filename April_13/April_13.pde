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

import processing.serial.*; //import library for arduino
Serial myPort;

int h; //the height of the flower
int grow=0; //how much the height is changed
boolean game=true; //check if the game reached the end
int flower_x; //x coordinate of the flower
Boolean collision=false; //check the collision
int win; //check win or lose
int left; //variables for switches
int right;
int light; //variable for the photosensor
boolean onOff=false; //variable for LED lights
boolean onOff2=false;
int time;

class Plant { //class for a plant

  int delta_x; //how much x coordinate has moved
  PImage pot_img;
  PImage flower_img;


  Plant() { //constructor
    delta_x=0;
    h=300; //initial height
  };

  void display() {
    pot_img=loadImage("pot.png");
    flower_img=loadImage("flower.png");
    stroke(0, 0, 0);
    fill(115, 195, 108);
    rect(295+delta_x, h+80-grow, 10, 100+grow); //draw stem
    image(pot_img, 230+delta_x, 450, 140, 150); //display image for the pot and flower
    image(flower_img, 250+delta_x, h-grow, 100, 100);
  };

  void update() { //move the flower based on the value read from switches
    if (left==1) {
      if (delta_x>-230) {
        delta_x+=-5;
      };
    };
    if (right==1) {
      if (delta_x<230) {
        delta_x+=5;
      };
    };
    flower_x=250+delta_x;
  };
};

class Food { //class for food
  int index; //types of food
  PImage food_img;
  int delta_y=0;
  int x=int(random(100, 500)); //random variable for x coordinate of the food
  boolean collision=false;
  int y_pos=0;

  Food(int i) { //parameter determines the type of food
    index=i;
  };
  void display() {
    if (index==0) { //display image based on its type
      food_img=loadImage("bug.png");
    } else if (index==1) {
      food_img=loadImage("raindrop.png");
      y_pos=-50;
    };
    image(food_img, x, y_pos+delta_y, 70, 70);
  };
  void update() {
    if (y_pos+delta_y<600) { //food drops
      delta_y+=5;
    };
    if (y_pos+delta_y>=450) { //if the food dropped until where the pot is, reset the values
      delta_y=0;
      x=int(random(100, 500));
    };
    if (y_pos+delta_y>=h-grow-50) { //if the food collided with the flower, call check function

      if (x>flower_x && x<flower_x+100) {
        delta_y=-80;
        x=int(random(100, 500));
        check();
      }
    }
  }
  void check() { //make the height adjustments based on the type of the food
    if (index==0) {
      grow-=10;
      onOff=true; //set the variable for the switch
      time=millis(); //store the current time (later used to turn off the switch)
    };
    if (index==1) {
      grow+=10;
      onOff2=true;
      time=millis();
    };
    if (100+grow<10) { //if the height is less than 10, a player loses
      game=false;
      win=0;
    };
    if (100+grow>200) { //if the height is greater than 200, a player wins
      game=false;
      win=1;
    };
    collision=false; 
  }
};

class Sun { //class for sun
  PImage sun_img;
  int x;
  int y;
  Sun() {
    x=0;
    y=0;
  }
  void display() { //display image for sun
    sun_img=loadImage("sun.png");
    image(sun_img, 0, 0, 100, 100);
  }
}

void bg() { //draw windows
  stroke(131, 105, 83);
  fill(131, 105, 83);
  rect(75, 100, 200, 200);
  rect(325, 100, 200, 200);
  fill(149, 195, 219);
  rect(90, 115, 170, 170);
  rect(340, 115, 170, 170);
  fill(131, 105, 83);
  rect(75, 195, 200, 10);
  rect(325, 195, 200, 10);
  rect(170, 100, 10, 200);
  rect(420, 100, 10, 200);
}


Plant main = new Plant(); //instantialize classes
Food bug = new Food(0);
Food raindrop = new Food(1);
Sun sun = new Sun();

void setup() {
  size(600, 600); //set up windows and colors
  background(235, 222, 207);
  printArray(Serial.list()); //set the board connected to processing
  String portname=Serial.list()[2];
  println(portname);
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');
};

void draw() {
  background(235, 222, 207); //reset background
  bg();
  sun.display(); //display classes and update the movements
  main.update();
  main.display();
  bug.display();
  bug.update();
  raindrop.display();
  raindrop.update();
  stroke(0, 0, 0); //for adjusting the brightess of the screen
  fill(0, 0, 0, light);
  rect(0, 0, 600, 600);
  if (millis()-time>500) { //if the LED is turned on for certain time, turn it off
    onOff=onOff2=false;
  }
  if (game==false) { //if game is ended, display texts
    if (win==0) {
      textSize(60);
      fill(0, 0, 0);
      text("LOSE", 10, 60);
    } else {
      text("WIN", 10, 60);
    }
    noLoop(); //stop the game
  }
};

void serialEvent(Serial myPort) {
  String s=myPort.readStringUntil('\n'); //read the string from the port
  s=trim(s);
  if (s!=null) {
    println(s);
    int values[]=int(split(s, ','));
    if (values.length==3) {
      light=(int)map(values[0], 0, 1023, 255, 0); //from the photosensor
      left=values[1]; //from switch (left)
      right=values[2];//from switch (right)
    }
  }
  myPort.write(int(onOff)+","+int(onOff2)+"\n"); //give info about controlling LED lights to the board
}
