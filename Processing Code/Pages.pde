/* --------------- PAGES --------------- */

public void Display_home() {
  
  // clear screen
  background(0);
  hideAllButtons();
    
  // show Play and HighScores buttons
  cp5.getController("Play").show();
  cp5.getController("HighScores").show();
}

public void Display_play() {
  
  // clear screen
  background(0);
  hideAllButtons();
  
  // start game
  myPort.clear();
  in_game = true;
  game_time = millis();
  
}

public void Display_highscores() {
  
  // clear screen
  background(0);
  hideAllButtons();
  
  // print high score title
  textSize(25);
  textAlign(CENTER, CENTER);
  text("High Scores", width/2, 50);
  
  // set text properties
  textSize(20);
  textAlign(LEFT, CENTER);
  
  // load and print highscores
  String[] highscores = loadStrings("highscores.txt");
  for (int i = 0; i <= 9; i++) {text(i+1, 100, i*25+150);}
  for (int i = 0; i < highscores.length; i++) {
    String[] line = split(highscores[i], ',');
    text(line[0], 150, i*25+150);
    text(line[1], 350, i*25+150);
  }
  
  // show Back button
  cp5.getController("Back").show();
}

public void Display_score(int score) {
  
  // clear screen
  background(0);
  hideAllButtons();
  
  // set text properties
  fill(255);
  textSize(50);
  textAlign(CENTER, CENTER);
  
  // display score
  text("Your score: " + score, width/2, height*2.75/9);
  
  // if score is higher than normal, display congrats, enter into high score
  String[] highscores = loadStrings("highscores.txt");
  if (highscores.length < 10 || score > int(split(highscores[highscores.length-1],',')[1])) {
    textSize(12);
    text("Congratulations, this is a high score!!!  Please enter your name below", 
      width/2, height*3.75/9);
    cp5.getController("Name").show();
    cp5.getController("Submit").show();
  }
  else {
    cp5.getController("PlayAgain").show();
    cp5.getController("Back").show();
  }
  
  textSize(12);
  
}
