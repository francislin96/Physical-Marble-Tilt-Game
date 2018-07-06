/* --------------- HELPER FUNCTIONS --------------- */

void hideAllButtons() {
  cp5.getController("Play").hide();
  cp5.getController("HighScores").hide();
  cp5.getController("Back").hide();
  cp5.getController("PlayAgain").hide();
  cp5.getController("Name").hide();
  cp5.getController("Submit").hide();
}

void win_game() {
  game_time = millis() - game_time;
  in_game = false;
  newScore = int(15000*exp(-0.0000358351893846*game_time));
  Display_score(newScore);
}

void addHighScore() {
  String[] highscores = loadStrings("highscores.txt");
  int place_num = highscores.length;
  
  if (highscores.length < 10) {
    
    // add new line
    highscores = append(highscores, ".");
    
    // find place of newscore
    for (int i = highscores.length-2; i >= 0; i--) {
      int tempScore = int(split(highscores[i],',')[1]);
      if (newScore > tempScore) {
        place_num = i;
      }
    }

    // insert newscore
    for (int i = highscores.length-1; i >= place_num+1; i--) {
      highscores[i] = highscores[i-1];
    }
    highscores[place_num] = cp5.get(Textfield.class,"Name").getText() + ',' + str(newScore);
    
    // save new highscores
    saveStrings("highscores.txt", highscores);
  }
  else {
    // find place of newscore
    for (int i = 9; i >= 0; i--) {
      int tempScore = int(split(highscores[i],',')[1]);
      if (newScore > tempScore) {
        place_num = i;
      }
    }
    // insert newscore
    for (int i = 9; i >= place_num+1; i--) {
      highscores[i] = highscores[i-1];
    }
    highscores[place_num] = cp5.get(Textfield.class,"Name").getText() + ',' + str(newScore);

    // save new highscores
    saveStrings("highscores.txt", highscores);
  }
}
