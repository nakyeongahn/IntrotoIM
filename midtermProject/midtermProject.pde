/*
This is my midterm project for Intro to IM
Assignment: Whack-a-Mole

This is a game, "Whack-a-Mole." The user should try to hit a mole to gain points. 

Instruction:
If the user hits the mole with a hat, the user can take 10 points. 
Hitting the regular mole, the user will gain 5 points.
Hitting the flower will make the user lose 10 points.

Reach 100 points, you will win!
Reach -30 points, you will lose!

The font used is "JalnanOTF".
This program was written by Nakyeong Ahn
3 March 2021
*/
import processing.sound.*; //import Sound library
SoundFile aud_bg;
SoundFile aud_mole;
SoundFile aud_flower;

boolean btn_inst=false; //variables for start screens
boolean btn_start=false;
boolean btn_ok=false;
boolean endscreen = false; //variables for the endscreen
boolean hit=false; //check if the collision happened

PImage img_bg; //background image
PImage img_hm; //hammer image

String[] fontList = PFont.list();
String img_nm; //name of the image

int score=0; //score
int start_fc; //start framecount for collision
int score_change=0; //update score
float y_change=2; //speed of the mole going upward
int phase=25; //moving motions of moles
int sec=0; //current second
int best_sec=-1; //best record

int start_sec; //initial time

void score_display() { //display score on the top of the screen with the best record

  PFont score_text = createFont("JalnanOTF", 30);
  textFont(score_text, 30);  
  color white = color(255, 255, 255);
  fill(white);
  textAlign(LEFT);
  
  text("SCORE: "+str(score), 50, 80); //score
  text("Time Passed: "+str((millis()-start_sec)/1000)+" sec", 430, 80); //display time passed after starting the game
  if (best_sec!=-1) {
    text("Best Record: "+str(best_sec)+" sec", 430, 120); //display best record so far
  } else {
    text("Best Record: - sec", 430, 120);
  }
};

void start_display() { //start screens
  int x=mouseX; 
  int y=mouseY;

  PImage img_start;  //start screen
  img_start=loadImage("img/start.png");

  PImage img_inst; //instruction screen
  img_inst=loadImage("img/instruction.png");

  if (btn_inst == false && btn_start == false && endscreen==false) { //check variables (click status)
    image(img_start, 0, 0, 800, 800);
    if (mousePressed) { //if the button clicked change according variables
      if (x>=260 && x<=530 && y>=400 && y<=480) {
        btn_inst=true;
      };
      if (mouseX>=325 && mouseX<=455 && mouseY>=490 && mouseY<=560) {
        btn_start=true;
        start_sec=millis(); //check the time the game started
      };
    };
  };
  if (btn_inst==true) { 
    image(img_inst, 0, 0, 800, 800);
    rectMode(LEFT);
    if (mousePressed) {
      if (x>=370 && x<=450 && y>=680 && y<=730) {
        btn_inst=false;
      };
    };
  };
};

void createMoles(Mole[] array) { //create moles randomly
  int x_pos=200; //initial position assigned
  int y_pos=200;

  for (int i=0; i<9; i++) { //creates an array of 9 moles
    array[i]=new Mole(x_pos, y_pos, i);
    if (i%3!=2) {
      x_pos+=200; //position assigned where the holes are drawn
    } else {
      y_pos+=200;
      x_pos=200;
    }
  };
};

void notification() { //function for notification when the score is updated
  textAlign(CENTER);
  color blue = color(53, 122, 161);
  //println(frameCount-start_fc);
  if (frameCount-start_fc<7) { //make texts appear for 7 framecounts
    if (score_change==10) { //display text according to the score change
      fill(blue);
      text("YAYYY +10!", width/2, 720);
    } else if (score_change==5) {
      fill(blue);
      text("+5!", width/2, 720);
    } else if (score_change==-10) {
      color orange = color(224, 121, 70);
      fill(orange);
      text("Don't kill the flower :( -10!", width/2, 720);
    }
  }
};

void hammer_change() { //change the image of hammer and speed of the mole based on the score
  if (score<20) {
    img_nm="img/hammer1.png";
    y_change=2;
    phase=int(50/y_change);
  } else if (score<40) {
    img_nm="img/hammer2.png";
    y_change=2.4;
    phase=int(50/y_change);
  } else if (score<60) {
    img_nm="img/hammer3.png";
    y_change=2.8;
    phase=int(50/y_change);
  } else if (score<80) {
    img_nm="img/hammer4.png";
    y_change=3.2;
    phase=int(50/y_change);
  } else if (score<100) {
    img_nm="img/hammer5.png";
    y_change=3.6;
    phase=int(50/y_change);
  }
  img_hm=loadImage(img_nm);
  hit=false;
};

void win_stop() { //if score>100 display the screen for winners
  image(img_bg, 0, 0, 800, 800);
  textAlign(CENTER);
  color white = color(255, 255, 255);
  fill(white);
  text("You reached 100 points!", width/2, 250);
  stroke(255, 255, 255);
  strokeWeight(3);
  line(210, 260, 590, 260);

  text("You: "+str(sec)+" sec", width/2, 350);
  if (best_sec!=-1) {
    text("Best Score: "+str(best_sec)+" sec", width/2, 400);
    if (best_sec>sec) {
      text("This is a new BEST score!", width/2, 450); //update best score
      best_sec=sec;
    } else if (best_sec==sec) {
      text("Good Job! A Tie Record!", width/2, 450);
    } else {
      text("Try again to earn the best record!", width/2, 450);
    }
  } else {
    text("Best Score: - sec", width/2, 400);
    text("This is a new BEST score!", width/2, 450); //update best score
    best_sec=sec;
  }  
  color blue = color(53, 122, 161);
  fill(blue);
  text("Restart", width/2-100, 600); //button for restart
  text("Quit", width/2+100, 600); //button for exit
  rectMode(LEFT);
};

void btns() { //control buttons for endscreen
  if (mousePressed) {
    if (mouseX>450 && mouseX<550 && mouseY>565 && mouseY<615) {
      println("exit"); //close the window
      exit();
    }
    if (mouseX>230 && mouseX<370 && mouseY>565 && mouseY<615) {
      println("restart");
      endscreen=false; //reset the variables needed for a new game
      score=0;
      y_change=2;
      phase=25;
      sec=0;
      Mole[] moles = new Mole[9];
      createMoles(moles);
      frameCount=0;
      score_change=0;
      start_sec=millis();
      btn_start=true;
    }
  }
};

void lose_stop() { //display screen for losers
  image(img_bg, 0, 0, 800, 800);
  textAlign(CENTER);
  color white = color(255, 255, 255);
  fill(white);
  text("You LOSE!", width/2, 250);
  stroke(255, 255, 255);
  strokeWeight(3);
  line(320, 260, 490, 260);
  color orange = color(224, 121, 70);
  fill(orange);
  text("Do not kill flowers.", width/2, 370); 
  fill(white);
  text("Otherwise, you will lose 10 points.", width/2, 420);
  color blue = color(53, 122, 161);
  fill(blue);
  text("Restart", width/2-100, 600); //display buttons for restart and quit
  text("Quit", width/2+100, 600);
};

Mole[] moles = new Mole[9]; //initiate the array of moles

void setup() {
  size(800, 800); //size of window
  background(175, 219, 211, 255);
  createMoles(moles); //create objects of moles
  img_bg=loadImage("img/background.jpg"); //load images needed
  img_hm=loadImage("img/hammer1.png");
  aud_bg = new SoundFile(this, "audio/bg.mp3"); //load audio files needed
  aud_mole = new SoundFile(this, "audio/mole.mp3");
  aud_flower = new SoundFile(this, "audio/flower.mp3");
  aud_bg.play();
};

void draw() {
  start_display(); //display start screen
  if (aud_bg.isPlaying()==false) { //keep playing background music
    aud_bg.play();
  }
  if (btn_start==true) { //if the game starts
    image(img_bg, 0, 0, 800, 800);
    for (int i=0; i<9; i++) { //call functions for moles
      moles[i].hole_display();
      moles[i].mole_update();
      moles[i].mole_display();
      moles[i].mole_hit();
    };
    image(img_hm, mouseX-20, mouseY-80, 125, 75); //display hammer along the mouse
    score_display(); //display score
    notification(); //display texts when the score is updated
    if (score>=100) { //if the user wins
      sec=(millis()-start_sec)/1000; //calculate the time spent for winning the game
      btn_start=false; //end the game
      endscreen=true; //display endscreen
      noLoop(); //stop the loop
      win_stop(); //display the endscreen for winners
    }
    if (score<=-30) { //if the user loses
      btn_start=false; //end the game
      endscreen=true; //display the endscreen
      noLoop();//stop the loop
      lose_stop();//display the endscreen for losers
    }
  };
  if (endscreen) { //if endscreen is displayed
    loop(); //resume the loop
    btns(); //check if the buttons are clicked
  }
};
