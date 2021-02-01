Me mainCircle=new Me(500, 500);
int[] x_array=new int[30];
int[] y_array=new int[30];
Others[] smallcs=new Others[30];
int index;
boolean bigger;
boolean terminate=false;

class Me {
  int x, y, r;
  Me(int xpos, int ypos) {
    x=xpos;
    y=ypos;
    r=50;
  }
  void display() {
    frameRate(400000);
    background(255, 255, 245);
    stroke(31, 27, 27);
    fill(255, 165, 165);
    circle(mouseX, mouseY, r);
    x=mouseX;
    y=mouseY;
  };
  void large() {
    r=r+1;
  };
  void end() {
    if (r>800) {
      terminate=true;
    };
  };
};

void createPos() {
  int x, y;
  for (int i=0; i<30; i++) {
    x=int(random(-50, 850));
    y=int(random(-50, 850));
    x_array[i]=x;
    y_array[i]=y;
    smallcs[i]=new Others(x, y);
  };
};

class Others {
  int x, y;
  boolean x_inc, y_inc;
  Others(int xpos, int ypos) {
    x=xpos;
    y=ypos;
  };
  void display() {
    frameRate(5);
    int r=int(random(255));
    int g=int(random(255));
    int b=int(random(255));
    stroke(31, 27, 27);
    fill(r, g, b);
    circle(x, y, 30);
  };
  void check() {
    if (x<400) {
      x_inc=true;
    };
    if (y<400) {
      y_inc=true;
    };
  };
  void move() {
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
  void collision() {
    if (mouseX>x-30 && mouseX<x+30) {
      if (mouseY>y-30 && mouseX<y+30) {
        bigger=true;
        print("je");
      };
    };
  };
};

void setup() {
  background(255, 255, 245);
  size(800, 800);
  createPos();
  for (int i=0; i<30; i++) {
    smallcs[i].check();
  };
};

void draw() {
  mainCircle.display(); 
  for (int i=0; i<30; i++) {
    index=i;
    smallcs[i].display();
    smallcs[i].move();
    smallcs[i].collision();
    if (bigger==true) {
      mainCircle.large();
    };
  };
  mainCircle.end();
  if (terminate) {
    stop();
    String s = "The circle has reached itx maximum size. Needs diet!! Otherwise, he can't move:((";
    fill(50);
    textSize(20);
    text(s, 200, 200, 600, 600);
  };
};
