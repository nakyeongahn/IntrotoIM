/* 
Intro to IM
Final Project: Smart Broom

This RC car with a broom attached at the end will clean your place!

This program codes for a display screen for the device.
You will be able to see how the RC car works and press the button to make it move.
Also, you can stop the car whenever you want by pressing the pause button or by exiting the program.
The information about whether the user wants to start or pause the RC car movements will be sent to the arduino.
When the RC car detects obstacles and make following movements, you will be able to see those details on the screen.

Written by Nakyeong Ahn
April 29, 2021
*/

import processing.serial.*; //import library for arduino
Serial myPort; //set port

String[] fontList = PFont.list();
PImage broom; //variables for images used
PImage car;

int x=0; //x position of the car image on the screen
int left=0; //variables to store the direction of the obstacles
int right=0;
int cnt_time; //variables to store time when the obstacle is detected

boolean scn_start = true; //variables to control the screen transition
boolean scn_menu = false;
boolean scn_main = false;
boolean running = false; //variables to check if the car is moving forward or not
boolean txt = false; //variable to check if the text is being displayed for changes of movements
int on = 0; //variable to control the start/pause movement of the car
boolean pause = false; 
int dir = 0; //direction of the obstacle


void setup() {
  size(700, 700);
  background(228, 214, 232);
  startscreen(); //display start screen
  String portname=Serial.list()[2]; //set portname
  println(portname);
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');
}

void draw() {
  if (scn_start) { //is start screen
    background(228, 214, 232);
    checkbtn1(); //check if the button was clicked
    startscreen(); //display screen
  }
  if (scn_menu) { //is menu screen
    background(228, 214, 232);
    checkbtn2(); //check if the button was clicked
    menuscreen(); //display screen
  }
  if (scn_main && txt==false) { //if main screen and no obstacle
    background(228, 214, 232);
    mainscreen(); //display screen
    if (pause) { //if the user clicks pause button
      //background(229,214,232);
      scn_pause(); //display paused screen
    }
  }
  if (txt) { //if main screen and obstacle detected
    background(228, 214, 232);
    scn_text(); //display following text
  }
}

void startscreen() { //start screen

  broom = loadImage("broom.png");
  imageMode(CENTER);
  image(broom, width/2, height/2-30, 200, 250);

  PFont text = createFont("THEFACESHOP", 30); //texts
  textFont(text, 60);  
  color white = color(255, 255, 255);
  fill(white);
  textAlign(CENTER);
  text("Smart Broom", width/2, 150);
  textAlign(LEFT);
  textFont(text, 30);
  text("Instruction", width/2-140, height/2+160);
  textFont(text, 40);
  text("Exit", width/2+60, height/2+160);

  stroke(255, 255, 255); //button shape
  strokeWeight(2);
  noFill();
  rect(width/2-150, height/2+120, 120, 60, 20);
  rect(width/2+30, height/2+120, 120, 60, 20);
}

void checkbtn1() { //check if the button was clicked
  if (mouseX>width/2-150 && mouseX<width/2-30) { //if the mouse is hovering the button
    if (mouseY>height/2+120 && mouseY<height/2+180) {
      stroke(255, 255, 255);
      strokeWeight(2);
      fill(255, 255, 255, 127); //change the color of the button
      rect(width/2-150, height/2+120, 120, 60, 20);
      if (mousePressed) { //if the button was clicked
        scn_start = false; //changed the following variables
        menuscreen();
        scn_menu = true;
      }
    }
  }
  if (mouseX>width/2+30 && mouseX<width/2+150) { //same done for another button
    if (mouseY>height/2+120 && mouseY<height/2+180) {
      stroke(255, 255, 255);
      strokeWeight(2);
      fill(255, 255, 255, 127);
      rect(width/2+30, height/2+120, 120, 60, 20);
      if (mousePressed) {
        scn_start = false;
        exit();
      }
    }
  }
}

void menuscreen() { //menu screen
  PFont text = createFont("THEFACESHOP", 50); //text
  textFont(text, 50);  
  color white = color(255, 255, 255);
  fill(white);
  textAlign(CENTER);
  text("How It Works", width/2, 70);
  stroke(white);
  strokeWeight(4);
  line(230, 90, 480, 90);
  textFont(text, 30);
  textAlign(LEFT);
  PFont inst = createFont("THEFACESHOP", 40);
  textFont(inst, 40);  
  color blue = color(2, 160, 233, 255);
  fill(blue);
  text("sensor", 600, 380);
  text("broom", 30, 310);
  text("wheel", 540, 510);
  text("arduino board", 200, 150);
  textFont(inst, 30);  
  text("(avoid obstacles)", 530, 410);

  car=loadImage("RCcar.png");
  image(car, 350, 350, 380, 280); //display image

  PImage arrow1=loadImage("arrow1.png");
  PImage arrow2=loadImage("arrow2.png");
  PImage arrow4=loadImage("arrow4.png");
  //image(arrow2, 600, 300, 200, 100);
  pushMatrix();
  rotate(PI/3.0);
  image(arrow1, 380, 80, 130, 100);
  popMatrix();
  image(arrow2, 600, 300, 200, 100); //display arrow image
  image(arrow2, 460, 470, 200, 100);
  image(arrow4, 250, 220, 70, 120);

  textAlign(LEFT);
  fill(white);
  textFont(text, 40);
  text("Start", width/2-125, height/2+200); //text for button
  text("Exit", width/2+60, height/2+200);

  stroke(255, 255, 255);
  strokeWeight(2);
  noFill();
  rect(width/2-150, height/2+160, 120, 60, 20); //button shapes
  rect(width/2+30, height/2+160, 120, 60, 20);
  textAlign(LEFT);
}

void checkbtn2() { //check if the button was clicked
  if (mouseX>width/2-150 && mouseX<width/2-30) {
    if (mouseY>height/2+160 && mouseY<height/2+220) { //if mouse is hovering on the button
      stroke(255, 255, 255);
      strokeWeight(2);
      fill(255, 255, 255, 127); //change the color of the button
      rect(width/2-150, height/2+160, 120, 60, 20);
      if (mousePressed) { //if the button was pressed
        scn_menu = false; //change the following variable
        scn_main = true;
        on = 1;
        running = true;
      }
    }
  }
  if (mouseX>width/2+30 && mouseX<width/2+150) { //same done for another button
    if (mouseY>height/2+160 && mouseY<height/2+220) {
      stroke(255, 255, 255);
      strokeWeight(2);
      fill(255, 255, 255, 127);
      rect(width/2+30, height/2+160, 120, 60, 20);
      if (mousePressed) {
        exit();
        scn_menu = false;
      }
    }
  }
}

void mainscreen() { //main screen
  image(car, 0+x, 500, 150, 100); //display car image
  PFont text = createFont("THEFACESHOP", 30);
  textAlign(LEFT);
  color white = color(255, 255, 255);
  fill(white);
  textFont(text, 30);
  text("Exit", 640, 40); //texts for buttons
  text("Pause", 560, 40);
  stroke(255, 255, 255);
  strokeWeight(2);
  noFill();
  rect(633, 10, 55, 40, 20); //button shape
  rect(553, 10, 70, 40, 20);

  if (mouseX>633 && mouseX<688) { //check if the button is clicked
    if (mouseY>10 && mouseY<50) {
      stroke(255, 255, 255);
      strokeWeight(2);
      fill(255, 255, 255, 127);//change the color of the button if the mouse is hovering
      rect(633, 10, 55, 40, 20);
      if (mousePressed) {
        scn_main = false; //change the following variable if the button is clicked
        on = 0;
        exit();
      }
    }
  }

  if (mouseX>560 && mouseX<630) {//check if the button is clicked
    if (mouseY>10 && mouseY<50) {
      stroke(255, 255, 255);
      strokeWeight(2);
      fill(255, 255, 255, 127);//change the color of the button if the mouse is hovering
      rect(553, 10, 70, 40, 20);
      if (mousePressed) {
        on = 0;
        pause = true;//change the following variable if the button is clicked
      }
    }
  }

  if (running && (on == 1) ) { //if the car is moving forward without obstacles
    if (x<750) { //car image on the screen also moves
      x+=3;
    } else {
      x=0;
    }
    textAlign(CENTER);
    textFont(text, 50);
    text("Running", width/2, 300); //text displayed
  }
  if (running == false) { //if the car faces obstacles
    if (left ==1){ //if the obstacle is at left side
      dir = 1;
    } else if (right ==1) {//if the obstacle is at right side
      dir = 2;
    }
    cnt_time = millis(); //store the curren time when the obstacle is detected
    txt = true;
    
  }
}

void scn_text() { //display text when obstacle is detected
  image(car, 0+x, 500, 150, 100);
  PFont text = createFont("THEFACESHOP", 30);
  textAlign(CENTER);
  textFont(text, 50);

  if (dir == 1) { //if the obstacle is at left side
    text("Obstacle Detected: Left Side ", width/2, 280);
    text("Turn Right", width/2, 340);
  } 
  if (dir ==2) {//if the obstacle is at right side
    text("Obstacle Detected: Right Side ", width/2, 280);
    text("Turn Left", width/2, 340);
  }
  if (millis()>cnt_time+700) { //display text for longer time (not to make it disappear after 0.1 sec)
    txt=false;
    dir = 0;
  }
}

void scn_pause() { //when the pause button was pressed
  stroke(255, 255, 255);
  strokeWeight(2);
  fill(255, 255, 255, 30);
  rect(200, 250, 300, 200, 50);
  rect(200, 250, 300, 200, 50);
  fill(255, 255, 255);
  rect(330, 300, 10, 50);
  rect(360, 300, 10, 50);
  PFont text = createFont("THEFACESHOP", 30);
  textAlign(LEFT);
  color white = color(255, 255, 255);
  fill(white);
  textFont(text, 30);
  text("Resume", 275, 400); //display other buttons
  text("Exit", 370, 400);
  noFill();
  rect(270, 367, 80, 40, 20);
  rect(360, 367, 60, 40, 20);
  if (mouseX>270 && mouseX<350) {
    if (mouseY>367 && mouseY<407) {
      stroke(255, 255, 255);
      strokeWeight(2);
      fill(255, 255, 255, 127);
      rect(270, 367, 80, 40, 20);
      if (mousePressed) {
        on = 1;
        pause = false; //make the following change when the button is pushed
      }
    }
  }
  if (mouseX>360 && mouseX<420) {
    if (mouseY>367 && mouseY<407) {
      stroke(255, 255, 255);
      strokeWeight(2);
      fill(255, 255, 255, 127);
      rect(360, 367, 60, 40, 20);
      if (mousePressed) {
        on = 0;
        exit(); //make the following change when the button is pushed
      }
    }
  }
}

void serialEvent(Serial myPort) { //send information to arduino board
  String s=myPort.readStringUntil('\n'); //read the string from the port
  s=trim(s);
  if (s!=null) {
    println(s);
    int values[]=int(split(s, ',')); //split the string read from the port
    if (values.length==3) {
      if (values [0] == 1) {
        running = false;
        if (values [1] == 1) {
          left = 1;
          right = 0;
        }
        if (values [2] == 1) {
          right = 1;
          left = 0;
        }
      }
      if (values[0] == 0) {
        running = true;
        left = 0;
        right = 0;
      }
    }
  }
  myPort.write(on+"\n"); //send the information to the board about "on" variable
}
