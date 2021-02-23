# WHACK-A-MOLE

### February 18, 2021 : Brainstorm ###
I plant to make a game "Whack-a-mole," where moles randomly pop up in the screen and the user need to hit the mole with a hammer.

##### Possible Ideas #####
1. The user will earn 5 points every time the hit each mole and 10 points for hitting the mole with a hat on.
2. The user will lose 10 points if they hit a flower with a hammer.
3. The speed of the game will be faster as the user reaches higher points.
4. The design of a hammer will get more sophisticated every ten points gained.
5. Reaching 99 points total, the user wins!

##### Research #####
I looked up various illustrations and images for whack-a-mole and chose one image that I liked the most. I will refer to this image for desgining the game.
<p align="center">
  Model Illustration can be found here:
  https://www.urbanbrush.net<br>
  <img src="img/model.png" width="500" height="500">
</p>

### February 20, 2021 : Create Images Needed ###
I created the images needed for the start screen and the instructions. Referring the model illustration, I used RGB picker website (https://imagecolorpicker.com/en) to find out the color codes used for the illustration.

##### Background #####
The background image I created (using Procreate on ipad):
<p align="center">
  <img src="img/background.jpg" width="500" height="500">
</p>

##### Start Screen #####
The start screen I created (using Powerpoint to insert the text):
<p align="center">
  <img src="img/start.png" width="500" height="500">
</p>

##### Instruction Screen #####
The Instruction screen I created (using Powerpoint to insert the text):
<p align="center">
  <img src="img/instruction.png" width="500" height="500">
</p>

##### Images for Moles #####
The images of moles I created (using Procreate on ipad):
<p align="center">
  <img src="img/mole1.png" width="100" height="150">
  <img src="img/mole2.png" width="100" height="150">
  <img src="img/mole3.png" width="100" height="150">
  <img src="img/mole4.png" width="100" height="150">
  <img src="img/mole5.png" width="100" height="150">
</p>

### February 21, 2021 : Display Images and Create Buttons ###
##### Display Images #####
I created a function for displaying images for the first few screens. It first loads the first screen and when the user clicks the "Instruction" or "Start" button, the screen changes. To check whether the buttom in clicked and control the action, I created boolean variables btn_start and btn_inst.
```
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
```
This is how the button works:
<p align="center">
  <img src="btn.gif" width="500" height="500">
</p>

### February 22, 2021 : Create Classes for Moles and Display Moles ###
After the user clicks the start button, the screen changes to the game screen. I first created a function called createMoles() in order to create an array of class for moles and assign its position using for loop.
```
Mole[] moles = new Mole[9];
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
```
I also created a class of moles called "Mole." The class Mole has various attributes including coordinates of the mole, index (numbering), coordinates of its hole, boolean variable for its visibility, etc.
```
  int hole_x, hole_y, hole_cnt;
  PImage img_mole;
  String img_nm;
  int mole_num;
  int visible=int(random(2));
  int mole_x, mole_y;
  int time_cnt=int(random(1,6));
  ```
 Under the class Moles, I made a function to display hole. It simply draws the ellipse on the coordinates stored by the variable hole_x and hole_y.
 This is the result:
 This is how the button works:
<p align="center">
  <img src="img/hole.png" width="500" height="500">
</p>