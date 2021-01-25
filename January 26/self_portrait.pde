/*
Thia is my first homework for Intro to IM
Assignment: self-portrait

This program was written by Nakyeong Ahn
21 January 2021
*/

size(300,300);
background(213, 227, 215);

//face
int faceWidth=80;
int faceHeight=90;
stroke(51,17,2);
fill(51,17,2);
rectMode(CENTER);
rect(150,90,faceWidth,faceHeight-30);

stroke(232, 221,204);
fill(232, 221,204);
ellipse(width/2,height/4, faceWidth, faceHeight);

//neck
rect(width/2,height/2-25,30,35,7);

//body
rect(width/2,height/2+50,faceWidth+20,125,7);

//arm
translate(width/2, height/2); 
rotate(PI/8.0);
rect(-37, 65, 30, 110,7); //left arm
ellipse(-38,125,30,25); //left hand

rotate(PI/-4.0);
rect(37, 65, 30, 110,7); //right arm
ellipse(38,125,30,25); //left hand

//clothes
resetMatrix(); //reset rotation
translate(width/2, height/2);

stroke(183,218,236); //skyblue
fill(183,218,236);

rect(-30, 5, 10, 40,7); //the straps of the top
rect(30, 5, 10, 40,7);

rect(0,68,faceWidth+20,85,7); //main part of the top

rotate(PI/8.0); //recolor arms that was hiddent by the top
stroke(232, 221,204);
fill(232, 221,204);
rect(-37, 65, 30, 55,7);
rotate(PI/-4.0);
rect(37, 65, 30, 55,7);

stroke(255,255,255); //white circle for the flower
fill(255,255,255);
ellipse(-20, 60, 15, 15);

stroke(252,242,131); //yellow leaves for the flower
fill(252,242,131);
ellipse(-18, 50, 15, 15);
ellipse(-33, 55, 15, 15);
ellipse(-30, 70, 15, 15);
ellipse(-15, 70, 15, 15);
ellipse(-9, 60, 15, 15);

//skirt
resetMatrix(); //reset rotation
stroke(14, 30,64);
fill(14, 30,64);
quad(105,250,90,300,210,300,195,250);

strokeWeight(2);
stroke(255,255,255);
line(102,260,198,260);
circle(150,255,10);

//face
strokeWeight(1);
stroke(0,0,0);
fill(232, 221,204);
ellipse(133,73,17,9); //eyes
ellipse(168,73,17,9);
fill(0,0,0);
circle(133,73,7);
circle(168,73,7);

stroke(232,201,160); //nose
fill(232,201,160);
ellipse(150,90,10,5);

stroke(240,215,211); //blush
fill(240,215,211);
ellipse(130,90,10,10);
ellipse(170,90,10,10);

stroke(217,65,121);//lip
noFill();
arc(150, 95, 20, 20, QUARTER_PI, PI-QUARTER_PI);

stroke(0,0,0); //eyebrows
arc(133, 73, 20, 20, PI+QUARTER_PI, TWO_PI-QUARTER_PI);
arc(168, 73, 20, 20, PI+QUARTER_PI, TWO_PI-QUARTER_PI);

//hair
stroke(51,17,2);
fill(51,17,2);
arc(150, 70, 80, 80, PI, TWO_PI-HALF_PI, CHORD);
arc(150, 70, 80, 80, TWO_PI-HALF_PI, TWO_PI, CHORD);
