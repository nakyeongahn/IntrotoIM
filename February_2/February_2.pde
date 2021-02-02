int index; //index used for small circle
boolean bigger; //check if the main circle needs to get bigger
boolean terminate=false; //check if the circle has reached its maximum radius
int[] x_array=new int[30]; //store x-coordinate for small circles in an array
int[] y_array=new int[30]; //store y-coordinate for small circles in an array

Me mainCircle=new Me(500, 500); //instantiate main circle
Others[] smallcs=new Others[30]; //instantiate small circles in an array


class Me { //define class for main circle
  int x, y, r; //x-pos,y-pos,radius
  Me(int xpos, int ypos) {
    x=xpos;
    y=ypos;
    r=50;
  }
  void display() { //define function for display of main circle
    frameRate(400000);
    background(255, 255, 245); 
    stroke(31, 27, 27);
    fill(255, 165, 165);
    circle(mouseX, mouseY, r); //circle follows your mouse
    x=mouseX;
    y=mouseY;
  };
  void large() { //radius of circle gets larger by 1
    r=r+1;
  };
  void end() { //if the radius reaches certain size, set terminate as true
    if (r>800) {
      terminate=true;
    };
  };
};

void createPos() { //create coordinates for small circles 
  int x, y;
  for (int i=0; i<30; i++) {
    x=int(random(-50, 850)); //randomly choose coordinates
    y=int(random(-50, 850));
    x_array[i]=x;
    y_array[i]=y;
    smallcs[i]=new Others(x, y); //initialize small circles
  };
};

class Others { //define class for small circles
  int x, y; //x_pos,y_pos
  boolean x_inc, y_inc; //check which direction the circle should move
  Others(int xpos, int ypos) {
    x=xpos;
    y=ypos;
  };
  void display() { //define function for display of the circle
    frameRate(5);
    int r=int(random(255)); //color is randomly chosen
    int g=int(random(255));
    int b=int(random(255));
    stroke(31, 27, 27);
    fill(r, g, b);
    circle(x, y, 30);
  };
  void check() { //check which direction the circle should move
    if (x<400) {
      x_inc=true;
    };
    if (y<400) {
      y_inc=true;
    };
  };
  void move() { //move the circles by +15/-15 both for x or y directions
    if (x_inc) {
      x=x+15;
      x_array[index]=x;
      if (x>800) {
        x_inc=false;
      };
    } else {
      x=x-15;
      x_array[index]=x;
      if (x<0) {
        x_inc=true;
      };
    };
    if (y_inc) {
      y=y+15;
      y_array[index]=y;
      if (y>800) {
        y_inc=false;
      };
    } else {
      y=y-15;
      y_array[index]=y;
      if (y<0) {
        y_inc=true;
      };
    };
  };
  void collision() { //check if the main circle has collided with other circles
    if (mouseX>x-30 && mouseX<x+30) {
      if (mouseY>y-30 && mouseX<y+30) {
        bigger=true; //if collision, set the bigger to true
      };
    };
  };
};

void setup() { 
  background(255, 255, 245);
  size(800, 800);
  createPos(); //create small circles
  for (int i=0; i<30; i++) {
    smallcs[i].check(); //check which direction they should move
  };
};

void draw() {
  mainCircle.display(); //display main circle
  for (int i=0; i<30; i++) {
    index=i;
    smallcs[i].display(); //display small circle
    smallcs[i].move(); //move the small circles
    smallcs[i].collision(); //check if collision occurred
    if (bigger==true) {
      mainCircle.large(); //if collision, increase the size of main circle
    };
  };
  mainCircle.end(); //check if the radius reached its maximum
  if (terminate) { //if terminate true
    stop(); //stop the motion
    String s = "The circle has reached itx maximum size. Needs diet!! Otherwise, he can't move:((";
    fill(50);
    textSize(20);
    text(s, 200, 200, 600, 600);
  };
};
