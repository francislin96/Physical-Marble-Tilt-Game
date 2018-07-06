/* --------------- BUTTON FUNCTIONS --------------- */

public void Play() {
  Display_play(); 
}

public void HighScores() {
  Display_highscores(); 
}

public void Back() {
  Display_home();
}

public void PlayAgain() {
  Display_play(); 
}

public void Submit() {
  addHighScore();
  Display_highscores();
}
