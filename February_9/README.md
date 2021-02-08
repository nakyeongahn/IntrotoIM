# Food Falling from the Sky
I created a little game where the main character eats food falling from the sky. I got this idea from the movie "Cloudy with a Chance of Meatball," which I enjoyed watching in my childhood. I added my personal taste of food and changed some elements that come out in the movie. I miss Korean food a lot these days, and since lunar new year is this friday, I decided to choose Korean food and a character wearing Hanbok, Korean traditional clothes. 
<p align="center">
  Poster of "Cloudy with a Chance of Meatball": <br>
  <img src="img/movie.jpg" width="500" height="500">
</p>

#### Process ####
* I first drew the background with my ipad. I tried to describe sky, trees, and the ground by using various watercolors. I felt that this can give more simplicity in the background than drawing the actual elements *
<p align="center">
  <img src="img/background.png" width="500" height="300">
</p>
* Then I constructed a class for food and made an array of classes for food. I collected the image for korean food and then processed to remove the background and set the pixel size. *
<p float="left" align="center">
  <img src="img/food1.png" width="100" height="100">
  <img src="img/food2.png" width="100" height="100">
  <img src="img/food3.png" width="100" height="100">
  <img src="img/food4.png" width="100" height="100">
  <img src="img/food5.png" width="100" height="100">
  <img src="img/food6.png" width="100" height="100">
  <img src="img/food7.png" width="100" height="100">
</p>


#### Code ####
* I used object oriented programming(OOP) using two classes, one for main circle and one for small circles, and functions.
* I used for loop to generate the coordinates for small circles and when applying functions for each of small circles.
* The information of small circles were stored in an array of integers, and an array of class for small circles I created.

#### Difficulties ####
* It took some time for me to find out how the loop and animation works in the draw() function. As the draw functions are keep repeated, I had to be careful using loops in functions for other classes. Otherwise, the motion of circles and change in colors would go so fast and looked very unorganized.
* While I tried to create an array of instaces of the class I created, I found it little difficult to use the syntax. There were some important things to keep in mind to use an array for the class. <br>
***ClassName[] ArrayName = new ClassName [int];<br>***
***ArrayName[index]=new ClassName (parameters);<br>***

#### What I enjoyed creating this ####
I enjoyed adding the interactive element to this work so that users can control the pathway of circle. I found that there are so many ways to apply one function and it would appear very different depending on how you use it. I loved how setting variables and conditions for variables can make the program more sophisticated and realize what I wanted to describe easily.

#### Result ####
<p align="center">
<img src="na2450_Week2_Assignment.gif" width="750" height="750">
</p>

