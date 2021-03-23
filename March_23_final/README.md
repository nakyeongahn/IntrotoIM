# Arduino Assignment 1: Puzzle with Momentary Switches and LEDs
Try pushing switches and turn all the lights on!

I used 4 led lights (red, blue, yellow, green) and 4 switches to make a puzzle.
To start the game, you can push any of switches.
Then the light will turn on in the way which users should try to achieve.
You will have a chance to push all switches to find out which led light it turns on.

HINT:
1. Which two colors mix up to make one color?
2. Use you chance to find out what color each switches light up and click according switches three times!

### Circuit
<p align="center">
  This is how my scheme looks like: <br>
  <img src="circuit.png" width="600" height="400"><br>
  This is how my board looks like: <br>
  <img src="board.jpg" width="400" height="400"><br>
</p>

### How to Play/Answers
1. You can start playing this game by pushing any of the switches. <br>Then it will turn on all the lights and off three times. It shows you need to aim for turning all the lights.<br>
  <p align="center">
  <img src="start.gif" width="600" height="400"><br>
  </p>
2. Try pushing switches to find out which color of LED each switch turns on. <br>
  <p align="center">
  <img src="trial1.gif" width="600" height="400"><br>
  </p>
3. As yellow and blue mix up to green, you need to push switches that turn on yellow and blue lights. <br>Push red and green switches consecutively!
  <p align="center">
  <img src="green.gif" width="600" height="400"><br>
  </p>
4. After green turns on, try pushing switches to find out which color of LED each switch turns on. <br>
  <p align="center">
  <img src="trial2.gif" width="600" height="400"><br>
  </p>
5. Whereas yellow and green turn on red and blue LED respectively, both red and blue switches turn on yellow LED. This gives a hint that yellow should be turned on next. <br>Try pushing switches that turn on yellow LED three times.
  <p align="center">
  <img src="yellow.gif" width="600" height="400"><br>
  </p>
6. After yellow turns on, try pushing switches to find out which color of LED each switch turns on. <br>
  <p align="center">
  <img src="trial3.gif" width="600" height="400"><br>
  </p>
7. Only the green switch turns on blue and all other switches turn on red. This time it implies that blue should be turned on next. <br>Try pushing the green switch for three times to turn on blue LED.
  <p align="center">
  <img src="blue.gif" width="600" height="400"><br>
  </p>
8. After blue turns on, try pushing switches to find out which color of LED each switch turns on. <br>
  <p align="center">
  <img src="trial4.gif" width="600" height="400"><br>
  </p>
9. Blue and yellow switches turn on red LED whereas other two switches turn on no LED at all. It implies that red should be turned on next. <br> Try pushing switches that turn on red LED for three times.
  <p align="center">
  <img src="red.gif" width="600" height="400"><br>
  </p>
