/* --------------- LIBRARIES AND VARIABLES  --------------- */

import processing.serial.*;
import controlP5.*;
import java.util.Arrays;
Serial myPort;
ControlP5 cp5;

// game variables
int newScore = 0;
boolean in_game = false;
int game_time = 0;

/* --------------- SETUP  --------------- */

void setup() {

  // communicate with arduino
   myPort = new Serial(this, Serial.list()[0], 9600);
  
  // cp5
  cp5 = new ControlP5(this);
  cp5.setFont(createFont("Verdana", 15));
  
  // create all buttons
  
  // Play button
  cp5.addButton("Play")
    .setPosition(width/2-75, height/3)
    .setSize(150, 50);
  
  // HighScores button
  cp5.addButton("HighScores")
    .setPosition(width/2-75, height*2/3)
    .setSize(150, 50);
    
  // Back button (to home)
  cp5.addButton("Back")
    .setPosition(width/2-75, height*7/8)
    .setSize(150, 25);
    
  // PlayAgain button
  cp5.addButton("PlayAgain")
    .setPosition(width/2-100, height*4/9)
    .setSize(200, 50);

  // Name button (to input to high scores)
  cp5.addTextfield("Name")
    .setPosition(width/2-100, height*4.6/9)
    .setSize(200, 50)
    .setAutoClear(false);
  
  // Submit button (to input to high scores)
  cp5.addButton("Submit")
    .setPosition(width/2-75, height*6.5/9)
    .setSize(150, 50);

  // draw home page
  size(500, 500);
  Display_home();}

/* --------------- DRAW  --------------- */

void draw() {
  if (in_game == true) {
    
    // clear screen
    background(0);
     
    // display time
    textSize(70);
    textAlign(CENTER, CENTER);
    String strSeconds;
    String strMinutes;
    String strMilsecs;
    strMilsecs = str(millis()%1000);
    if (strMilsecs.length() < 2) {strMilsecs = "0" + strMilsecs;}
    else if (strMilsecs.length() > 2) {strMilsecs = strMilsecs.substring(0, 2);}
    int seconds = ((millis() - game_time) / 1000) % 60;
    if (seconds < 10) {strSeconds = "0" + str(seconds);} else {strSeconds = str(seconds);}
    int minutes = int((millis() - game_time) / 1000) / 60;
    if (minutes < 10) {strMinutes = "0" + str(minutes);} else {strMinutes = str(minutes);}
    text(strMinutes + ":" + strSeconds + ":" + strMilsecs,width/2,height/2);
    
    // if Arduino detects ball in hole, end game
    if (myPort.available() > 0) {
      String val = myPort.readStringUntil('\n');
      if (val != null) {
        win_game();
      }
    }
  }
}
