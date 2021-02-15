# Top 50 Google Searches in 2020
I created a little animation where the 50 keywords that were searched the most on Google in 2020. The most searched word appears first with the biggest size and greatest opacity. As its rank goes down, the size of the text and opacity decreases. 

The top 50 Google searches were found here:
https://www.semrush.com/blog/most-searched-keywords-google/#header3

I expected to have a lot of keywords related to pandemic and Covid-19. However, most words were the name of social media, weather, and translators in English, Spanish, and Russian. For me, at least, the top 50 searches in 2020 were quite surprising.

#### Process & Code ####
* I first made a csv file of top 50 Google searches in 2020. The keywords are separated by ",".
<p align="center">
  <img src="csv_img.png" width="500" height="300">
</p>

* Then I started to work on coding part in Processing. I first loaded the text from a csv file and split the text by ",". The keywords were then stored in an array of strings.
```
String strings[]; //array for loading csv file
String data[]; //store data of texts

void loaddata() { //function to load csv file
  strings = loadStrings("2020search.csv");
  data= split(strings[0], ","); //split text into ","
};
```

* After loading the text, I created another function to display the text. Here, I set the font as "DejaVuSans-BoldOblique". The color was chosen randomly, and the size of text keeps decreasing as the rank for keywords goes down.

```
void display() { //function for display
  int r=int(random(0, 192));  //choose random colors
  int g=int(random(0, 192));
  int b=int(random(0, 192));

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
```
* In the setup(), frameRate was set as 3.

* By calling these two function inside the draw(), the 50 keywords were displayed. In the draw(), the index for keywords, the x and y position of texts, fontsize, and opacity were controlled.

```
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
```

#### Difficulties ####
* The place for assigning variables are imporatant. I realized that the assignments for variables for in the function, it resets every time the draw() calls the function. Therefore, controlling the variables inside the function along with the assignments for variables would be meaningless.
* To find the coordinates for texts not to go over the size of the window was the one of the hardest job. Since the font size varies for each keyword, it was hard to check whether any keywords would stay in the window.

#### What I enjoyed creating this ####
I used the fourth parameter in the color() for the first time, trying to control the opacity. I really liked the results with various opacities!
Moreover, it was an interesting process to come up with an efficient way to display the data I have. I am still not sure whether this animation shows the data efficiently as the way I wanted to express. What I intended to to is that the keywords which was searched more than others should be emphasized more in the animation.

#### What I couldn't finish ####
I really wanted to make the keywords not overlap with each other so that all 50 words are readable. However, I couldn't achieve this part since all the randomness I used in this animation makes this part harder. 

#### Result ####
1st trial:<br>
<p align="center">
<img src="February_16(1).gif" width="700" height="400">
</p>

2nd trial:<br>
<p align="center">
<img src="February_16(2).gif" width="700" height="400">
</p>


