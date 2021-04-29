# Smart Broom
This RC car with a broom attached at the end will clean your place!

This program codes for a RC car which avoids obstacles automatically using an ultrasonic sensor.
Ultrasonic sensor detects obstacles from 40 to 140 (angle) and the rotation happen with the help of a servo motor.
Once it receives a signal from Processing program, the RC car starts moving as coded.
Along with its movements, the relevant information is being written on the port. This information is read from processing and displays how the car is moving and where the obstacles were detected. You can also control the movement of the car by pressing the pause button.

This is the link to the video: https://youtu.be/j66K3WvLUWU

### Motivation
I wanted to make a vehicle using motors as I enjoyed controlling the movment of the motor. Then, I suddenly remembered the robot vacuum cleaner in my home. My mom bought it several years ago but she hasn't really used it. She told me it is pretty uncomfortable as there is no way to see whether it is working properly remotely. So, I decided to make this RC car with a broom which can be controlled by the screen on laptop. <br>

### Model
<p align="center">
  This is how I first designed the RC car: <br>
  <img src="model.jpg" width="600" height="400">
</p>

### Schematic
<p align="center">
  This is the scheme of this device: <br>
  <img src="scheme.jpg" width="600" height="400">
</p>

1. Ultransonic Sensor: <br> used to detect obstacles
2. Servo Motor: <br> responsible for rotating the ultrasonic sensor
3. DC motor: <br> responsible for wheels' movements

### Device
First, I made a normal RC car with an ultrasonic sensor and a servo motor. And I attached a small broom at the end. I had to cut some part off to adjust the size of the broom.

<p align="center">
  This is how the broom looks like befor cutting some part off: <br>
  <img src="broom.jpeg" width="400" height="400">
</p>

<p align="center">
  <img src="car1.jpg" width="600" height="400">
</p>
<p align="center">
  <img src="car2.jpg" width="600" height="400">
</p>
<p align="center">
  <img src="car3.jpg" width="600" height="400">
</p>

### How Does Arduino and Processing Interact / How It Works
1. After uploading .ino file to the Arduino board, play the processing file. Then the start screen will display.<br>

<p align="center">
  <img src="start.png" width="500" height="500">
</p>

2. If you click the button "Instructions," the new screen will show you the components of the device. <br>
  <p align="center">
<img src="menu.png" width="500" height="500">
</p>

3. Click the start button, then the screen will change and also the device will start moving forward. If the ultrasonic sensor does not detect obstacle within 15 cm, the following screen will be shown. <br>
<p align="center">
<img src="running.png" width="500" height="500">
</p>
  
3. If the obstacle is detected from the left sight, the car will move backward and then turn right. The following screen will be shown.
<p align="center">
<img src="left.png" width="500" height="500">
</p>


4. If the obstacle is detected from the right sight, the car will move backward and then turn left. The following screen will be shown.
<p align="center">
<img src="right.png" width="500" height="500">
</p>

5. If you click the button on the top right "pause," the car will pause its movments and the following screen will be shown. <br>
<p align="center">
<img src="pause.png" width="500" height="500">
</p>

### CODE
1. Arduino<br>
  i) When it receives signal from the processing, it starts working. Otherwise, the speed of the wheel is set as 0.<br>
  ii) Three functions are made: moveForward(), moveBackward(), movePattern(). movePattern() is to move the device accordingly when the obstacle is spotted. If the obstacle is at left, turn right. Otherwise, turn left.<br>
  ```
  void movePattern() { //if the car detects obstacles
  moveBackward(); //move backward
  delay(500);
  if (angle >= 90) { //if the obstacle is at the right side, turn left
    analogWrite(pwmAPin, 255);  
    digitalWrite(ain1Pin, HIGH);
    digitalWrite(ain2Pin, LOW);

    analogWrite(pwmBPin, 255);
    digitalWrite(bin1Pin, LOW);
    digitalWrite(bin2Pin, HIGH);

    right = 1;
    left = 0;

    delay(500);
  }
  else {
    analogWrite(pwmAPin, 255); //if the obstacle is at the left side, turn left
    digitalWrite(ain1Pin, LOW);
    digitalWrite(ain2Pin, HIGH);

    analogWrite(pwmBPin, 255);
    digitalWrite(bin1Pin, HIGH);
    digitalWrite(bin2Pin, LOW);

    delay(500);

    left = 1;
    right = 0;
  }

  angle = 90; //change the direction the servo motor rotates
  if (state = 10) {
    state = -10;
  } else if (state = -10){
    state = 10;
  }
  myservo.write(angle);
  delay(100);
}
```
  iii) Servomotor is rotating by rewriting the angle. The angle changes by 10 degree.<br>
  ```
  if (angle == 140) state = -10; //to make the servomotor rotate
        else if (angle == 40) state = 10;
        angle += state;
        delay(100);
  ```

2. Processing
  i) The start and instruction screen were made using texts, rectangle, and image for the broom. Separate functions were used to check if the buttons were pressed for each screen. <br>
  ii) Based on the information written on the port, the main screen shows different texts according to the movement of the car. Also it sends information to the board to turn on/off the device.
  ```
  void serialEvent(Serial myPort) { //send information to arduino board
  String s=myPort.readStringUntil('\n'); //read the string from the port
  s=trim(s);
  if (s!=null) {
    println(s);
    int values[]=int(split(s, ',')); //split the string read from the port
    if (values.length==3) {
      if (values [0] == 1) {
        running = false;
        if (values [1] == 1) {
          left = 1;
          right = 0;
        }
        if (values [2] == 1) {
          right = 1;
          left = 0;
        }
      }
      if (values[0] == 0) {
        running = true;
        left = 0;
        right = 0;
      }
    }
  }
  myPort.write(on+"\n"); //send the information to the board about "on" variable
}
```

### Major Problems and Modifications
1. 
