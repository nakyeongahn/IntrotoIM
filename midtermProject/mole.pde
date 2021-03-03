class Mole { //class for mole

  int hole_x, hole_y, hole_cnt; //the position and index of the hole the mole is coming from
  PImage img_mole;
  String img_nm;
  int mole_num; //index of the mole
  int visible=int(random(2)); //randomly choose visibility
  int mole_x, mole_y; //position of the mole
  int time_cnt=int(random(1, 20)); //randomly choose the phase of the mole's movements

  Mole(int x, int y, int i) { //constructor
    hole_x=x; //initiate the variables
    hole_y=y;
    hole_cnt=i;
    mole_x=hole_x-25;
    mole_y=hole_y-55;
    mole_num=int(random(1, 7));
    img_nm="img/mole"+str(mole_num)+".png"; //create image name
    img_mole=loadImage(img_nm);
  };

  void hole_display() { //display the hole
    if (btn_start==true) {
      stroke(0, 0, 0);
      strokeWeight(2.5);
      fill(0, 0, 0, 165);
      ellipse(hole_x, hole_y, 100, 50);
    };
  };

  void mole_display() { //display the mole
    if (visible==1) {

      image(img_mole, mole_x, mole_y, 45, 88);
    };
  };

  void mole_update() { //for upward motion of the mole
    mole_y-=y_change;
    time_cnt+=1;

    if (time_cnt>=phase) {
      moles[hole_cnt]=new Mole(hole_x, hole_y, hole_cnt); //if the mole moved 50 pixels upward, reset the mole
    };
  };

  void mole_hit() { //check the collisions
    int x=mouseX-20; 
    int y=mouseY-80;
    
    PFont score_text = createFont("JalnanOTF", 50); //display text
    textFont(score_text, 50);
    color black = color(255, 255, 255);
    fill(black);
    textAlign(CENTER);

    if (x+45>mole_x && x<mole_x+45 && y+75>mole_y && y<mole_y+88 && mousePressed && visible==1) { //if the hammer hits the mole
      hit=true;

      if (score%20==0 || score%20==5) { //change hammer if score reaches every 20 points
        hammer_change();
      };
      start_fc=frameCount;
      if (mole_num==4) { //if it hits the mole with a hat
        score+=10;
        score_change=10;
        aud_mole.play();
      } else if (mole_num==6) { //if it hits the flower
        score-=10;
        score_change=-10;
        aud_flower.play();
      } else { //if it hits the regular mole
        score+=5;
        score_change=5;
        aud_mole.play();
      }
      moles[hole_cnt]=new Mole(hole_x, hole_y, hole_cnt); //if the mole was hit, mole is being reset
    }
  };
};
