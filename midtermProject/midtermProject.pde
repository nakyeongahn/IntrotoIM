boolean btn_inst=false;
boolean btn_start=false;
boolean btn_ok=false;
int cnt=0;
PImage img_bg;

void start_display() {
  int x=mouseX; 
  int y=mouseY;

  PImage img_start;  
  img_start=loadImage("img/start.png");

  PImage img_inst;
  img_inst=loadImage("img/instruction.png");

  if (btn_inst == false && btn_start == false) {
    image(img_start, 0, 0, 800, 800);
    if (mousePressed) {
      if (x>=260 && x<=530 && y>=400 && y<=480) {
        btn_inst=true;
      };
      if (mouseX>=325 && mouseX<=455 && mouseY>=490 && mouseY<=560) {
        btn_start=true;
      };
    };
  };

  if (btn_inst==true) {
    image(img_inst, 0, 0, 800, 800);
    //rect(350, 680, 100, 80);

    if (mousePressed) {
      if (x>=350 && x<=450 && y>=680 && y<=760) {
        btn_inst=false;
      };
    };
  };
};

void createMoles(Mole[] array) {
  int x_pos=200; 
  int y_pos=200;

  for (int i=0; i<9; i++) {
    array[i]=new Mole(x_pos, y_pos, i);
    if (i%3!=2) {
      x_pos+=200;
    } else {
      y_pos+=200;
      x_pos=200;
    }
  };
};

class Mole {

  int hole_x, hole_y, hole_cnt;

  PImage img_mole;
  String img_nm;
  int mole_num;
  int visible=int(random(2));
  int mole_x, mole_y;
  int time_cnt=int(random(1,6));

  Mole(int x, int y, int i) {
    hole_x=x;
    hole_y=y;
    hole_cnt=i;
    mole_x=hole_x-25;
    mole_y=hole_y-55;
    mole_num=int(random(1, 6));
    img_nm="img/mole"+str(mole_num)+".png";
    img_mole=loadImage(img_nm);
  };

  void hole_display() {
    if (btn_start==true) {
      stroke(0, 0, 0);
      strokeWeight(2.5);
      fill(0, 0, 0, 165);
      ellipse(hole_x, hole_y, 100, 50);
    };
  };

  void mole_display() {
    if (visible==1) {

      image(img_mole, mole_x, mole_y);
      //println("here");
    };
  };

  void mole_update() {
    mole_y-=10;
    time_cnt+=1;

    if (time_cnt>=5) {
      moles[hole_cnt]=new Mole(hole_x, hole_y, hole_cnt);
    };
  };
};


Mole[] moles = new Mole[9];

void setup() {
  size(800, 800);
  background(175, 219, 211, 255);
  createMoles(moles);
};

void draw() {
  start_display();
  if (btn_start==true) {
    img_bg=loadImage("img/background.jpg");
    image(img_bg, 0, 0, 800, 800);

    for (int i=0; i<9; i++) {
      moles[i].hole_display();
      moles[i].mole_update();
      moles[i].mole_display();
    };
  };
  //for (int i=0; i<9; i++) {
  //  moles[i].hole_display();
  //  moles[i].mole_display();
  //  moles[i].mole_update();
  //};
};
