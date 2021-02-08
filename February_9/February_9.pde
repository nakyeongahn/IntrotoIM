class Food { //class for food
  int type; // determine types of food
  int x, y; // the coordinate of food
  int size; //size of food
  int speed; //how fast the food is falling
  boolean visible=true; 
  Food(int num) { //constructor
    type=num+1; //prevent error
    x=int(random(900)); //randomize x position of food
    y=-50;
    size=100;
    speed=int(random(1, 10)); //randomize the spped of food falling
  }
  void display() {
    String imgname="img/food"+str(type)+".png"; //generate img name for food
    PImage img;
    if (visible) {
      img=loadImage(imgname);
      image(img, x, y, size, size); //load image for food
    };
  };
  void move() {
    y=y+speed; //food falling
  };
  void collision() {
    if (y>=600) { //if food collides with the ground
      y=-100; //it rains from the sky again
      x=int(random(100, 900)); //reset x position and speed
      speed=int(random(1, 10));
    };
  };
  void eatFood() { //check if the food collides with the caracter
    if (x>girlx+3 && x<girlx+97) {
      if (y>girly && y<girly+190) {
        score-=5; //if collided, the hunger-=5
        y=-100; //reset the food position
        x=int(random(100, 900));
        speed=int(random(1, 10));

      };
    };
  };

};

class Girl { //class for character
  int x, y; //position
  Girl() { //constructor
    x=500; 
    girlx=x; //store value to check the collision later
    y=450; 
    girly=y;
  };
  void display() {
    PImage img; //load img for the character
    img=loadImage("img/character.png");
    image(img, x, y, 100, 200);
  };
  void move() { //determines the direction of the character from keyboard and if it goes out of the window
    if (left && x>0) {
      x=x-5;
      girlx=x;
    }
    if (right && x<900) {
      x=x+5;
      girlx=x;
    }
    if (up && y>350) {
      y=y-5;
      girly=y;
    };
    if (up==false && y<450) {
      y=y+5;
      girly=y;
    }
  };
};

void randFood(Food[] array) { //initialize instances for food
  for (int i=0; i<7; i++) {
    array[i]=new Food(i);
  };
};

void redrawbg() { //redraw background every time the object is moving
  image(bg, 0, 0);
  text("Hunger "+score+"%", 10, 20);
};

void keyPressed() { //check if key is pressed and change the following boolean variable
  if (full==false) {
    if (keyCode == LEFT) {
      left=true;
    };
    if (keyCode== RIGHT) {
      right=true;
    };
    if (keyCode==UP) {
      up=true;
    };
  };
};

void keyReleased() { //check if key is pressed and change the following boolean variable
  if (keyCode == LEFT) {
    left=false;
  };
  if (keyCode== RIGHT) {
    right=false;
  };
  if (keyCode==UP) {
    up=false;
  };
};

Food[] foods = new Food[7]; //array of foods
Girl main = new Girl(); 
PImage bg; //img for background
boolean left=false; //boolean variables for direction
boolean right=false;
boolean up=false;
int score=100; //set initial score
int girlx, girly; //coordinates of main character
boolean full=false; //check if the game is end

void setup() {
  size(1000, 700);
  bg = loadImage("img/background.png");
  textSize(16); 
  text("Hunger "+score+"%", 10, 20); //score is appeared
  image(bg, 0, 0);

  randFood(foods);
};

void draw() {

  redrawbg(); //reset background
  if (score==0) { //if score becomes 0
    full=true; //change variable to full
    text("I am so full, I can't move anymore", 10, 50);
  };
  for (int i=0; i<7; i++) { //responsible for food moving
    foods[i].display();
    foods[i].collision();
    foods[i].move();
    if (!full){
      foods[i].eatFood(); //only eatfood when full is false
    };
  };
  main.display(); //responsible for the main character motion
  main.move();
};
