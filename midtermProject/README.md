# WHACK-A-MOLE
Moles randomly pop up among 9 holes! Try to hit the mole with a hammer by clicking them and earn points!

### Motivation
I decided to create this game since I had good memories playing whack-a-mole with the machin in the streets with my friends. By making a digitalized version of the game, I thought I could add my taste through color choices, images of mole, etc. It means a lot to me to recreate this game, which is one of my favorite childhood memories.<br>

<p align="center">
  This is how the whack-a-mole game machine looks like: <br>
  <img src="memories.jpg" width="400" height="400">
</p>

### Instruction
I created this game based on classic rules of the original game. But I added different types of moles, which will give you different score when hitting them. Also, if you hit the flower, you will lose 10 points.

Simply, you win by reaching 100 points. You lose if the score reaches -30!

<p align="center">
  Below is the picture for detailed instruction: <br>
  <img src="img/instruction.png" width="500" height="500">
</p>

### How Does It Look Like
1. If you start running the program, you will be able to see the start screen with two buttons: instruction and start.
Just click the instruction button to see the instruction or click the start button to start the game.<br>

<p align="center">
  <img src="btn.gif" width="500" height="500">
  <img src="start.gif" width="500" height="500">
</p>

2. Once you start the game, the moles and flower will randomly appear among 9 holes. There are total 5 different types of moles and 1 type of flower. The images will be randomly chosen. <br>
  <p align="center">
  <img src="img/mole1.png" width="100" height="150">
  <img src="img/mole2.png" width="100" height="150">
  <img src="img/mole3.png" width="100" height="150">
  <img src="img/mole4.png" width="100" height="150">
  <img src="img/mole5.png" width="100" height="150"><br>
  <img src="img/mole6.png" width="100" height="150">
</p>

3. The hammer will follow your mouse and you will be able to hit the moles or flowers by clicking them with a hammer. If you click the objects, the score will be updated according to what you clicked.<br>
<p align="center">
  If you hit the mole with a hat: <br>
  <img src="hit_molehat.gif" width="500" height="500"><br><br>
  If you hit the mole without a hat: <br>
  <img src="hit_mole.gif" width="500" height="500"><br><br>
  If you hit the flower: <br>
  <img src="hit_flower.gif" width="500" height="500"><br><br>
</p>
  
3. The game will get faster as you earn more points. Every 20 points you earned, the mole will move upward faster, and also the color of the hammer changes.
<p align="center">
  <img src="img/hammer1.png" width="125" height="80">
  <img src="img/hammer2.png" width="125" height="80">
  <img src="img/hammer3.png" width="125" height="80">
  <img src="img/hammer4.png" width="125" height="80">
  <img src="img/hammer5.png" width="125" height="80">
</p>


4. If you reach -30 points by hitting the flower repeatedly, you will lose the game and the game will stop. The endscreen will be displayed, on which you can click the buttons to restart the game or quit.<br>
<p align="center">
  <img src="game_lose.gif" width="500" height="500">
</p>

If you earn 100 points by hitting the flower repeatedly, you will win the game and the game will stop. The endscreen will be displayed, on which you can click the buttons to restart the game or quit. On the endscreen, the time taken for you to reach 100 points will be shown, along with the best score.<br>
<p align="center">
  <img src="game_win.gif" width="500" height="500">
</p>

### Major Problems and Modifications
1. When I first created class for hammer, I loaded the image everytime the function was called to display the hammer according to the score. However, using loadImage() everytime when displaying hammer made the response of image to the movement of cursor very slow. The image followed the cursore, but it was lagging. So, what I did was to remove the class for hammer as I only needed mouseX, mouseY for the hammer, and changed the way to load image for hammer. Instead of checking score everytime the draw() function is called, I made a condition to load new image for hammer when the current score % 20 = 0 or 5. It means that the score just went over 20, 40, 60, or 80. And these are the only times to change the speed or image of the hammer. After making modifications, the lagging time decreased and now the hammer follows the cursor pretty quickly!
<br>
2. At first, I just planned to make the winning condition for earning 100 points. However, when I actually created the game, it seemed dull. So, I added a timer which counts seconds it took for the user to complete the game and compare it with the best record. When you run the program and play it for the first time there is no best record yet. However, after restarting the game, the best record will be stored and the users can now compare their speed with the best record while playing the game.<br>
  To make this possible I used millis() function. I first stored the start time using millis() to the variable and subtracted it from the millis() when the   game ended. I also converted the time unit from milliseconds to seconds, and the total time taken for game to be completed in seconds would be (millis()-start_sec)/1000.
