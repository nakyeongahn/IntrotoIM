/*
Thia is my weekly assignment for Intro to IM
Assignment: Generative Text

This program is showing a text of the 50 most searched keywords on google in 2020.
The most searched word appears in the greatest size and 100% opacity. 
As its rank gets down, font size and opacity decreases.
Each of 50 words appear once in 3 frames.

The color of the text is chosen randomly, and the position of text is partially random. 
The font used is "DejaVuSans-BoldOblique".

This program was written by Nakyeong Ahn
16 February 2021
*/

String strings[]; //array for loading csv file
String data[]; //store data of texts
int index=0; //index used for texts
int fontsize=100; //fontsize
int x=500; //coordinates of text
int y=0;
int opacity=255;

void loaddata() { //function to load csv file
  strings = loadStrings("2020search.csv");
  data= split(strings[0], ","); //split text into ","
  //for (int i=0; i<50; i++) {
  //  println(data[i]);
  //};
};

void display() { //function for display
  int r=int(random(0, 192));  //choose random colors
  int g=int(random(0, 192));
  int b=int(random(0, 192));

  //String[] fontList = PFont.list();
  //printArray(fontList);
  PFont f = createFont("DejaVuSans-BoldOblique", 32); //create fonts
  textFont(f, fontsize);

  color textcolor = color(r, g, b, opacity); //create color
  fill(textcolor);  
  if (index==0) { //set text align
    textAlign(CENTER);
  } else {
    textAlign(LEFT);
  }
  text(data[index], x, y); //write text on the screen
};

void setup() {
  frameRate(3); //control frameRate
  size(1400, 800); //size of the window
  background(255, 255, 255); //white background
};


void draw() {
  loaddata(); //call function
  if (index<50) { //there are only 50 words in csv file
    display(); //display text
    index++; //increase index
    fontsize-=1; //control variables for fontsize, opacity
    opacity-=5;
    if (index%2==0) { //control x and y coordinates of text, so that it doesn't go out of the window.
      x+=int(random(50, 500));
    } else {
      x-=int(random(50, 300));
    }
    if (x<0){x+=200;}
    if (x>600) {x-=100;}
    y+=50;
    if (y>=800){
      y=400;
    };
  };
};
