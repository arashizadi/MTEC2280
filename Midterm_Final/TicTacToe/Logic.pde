void enemyMove() {
  currentTime = millis();
  if (currentTime - savedTime > random(900, 1700))
  {
    if (turn != 0) {
      savedTime = currentTime;
      int block = int(random(1, squares.length));
      if (!playerTurn && pieces[block] == '.') {
        image(o, squares[block].x, squares[block].y);
        turn--;
        pieces[block] = 'E';
        enemyLastBlock = block;

        switch (block) {
        case 1: 
          if ((pieces[2]=='E' && pieces[3]=='E') || (pieces[4]=='E' && pieces[7]=='E') || (pieces[5]=='E' && pieces[9]=='E'))
            gameOver('L');
          break;
        case 2: 
          if ((pieces[1]=='E' && pieces[3]=='E') || (pieces[5]=='E' && pieces[8]=='E'))
            gameOver('L');
          break;
        case 3: 
          if ((pieces[1]=='E' && pieces[2]=='E') || (pieces[6]=='E' && pieces[9]=='E') || (pieces[5]=='E' && pieces[7]=='E'))
            gameOver('L');
          break;
        case 4: 
          if ((pieces[5]=='E' && pieces[6]=='E') || (pieces[1]=='E' && pieces[7]=='E'))
            gameOver('L');
          break;
        case 5: 
          if ((pieces[4]=='E' && pieces[6]=='E') || (pieces[2]=='E' && pieces[8]=='E') || (pieces[1]=='E' && pieces[9]=='E') || (pieces[3]=='E' && pieces[7]=='E'))
            gameOver('L');
          break;
        case 6: 
          if ((pieces[4]=='E' && pieces[5]=='E') || (pieces[3]=='E' && pieces[9]=='E'))
            gameOver('L');
          break;
        case 7: 
          if ((pieces[8]=='E' && pieces[9]=='E') || (pieces[1]=='E' && pieces[4]=='E') || (pieces[3]=='E' && pieces[5]=='E'))
            gameOver('L');
          break;
        case 8: 
          if ((pieces[7]=='E' && pieces[9]=='E') || (pieces[2]=='E' && pieces[5]=='E'))
            gameOver('L');
          break;
        case 9: 
          if ((pieces[7]=='E' && pieces[8]=='E') || (pieces[3]=='E' && pieces[6]=='E') || (pieces[1]=='E' && pieces[5]=='E'))
            gameOver('L');
          break;
        }
        playerTurn = !playerTurn;
      }
    }
  }
}

void playerMove() {
  if (turn != 0) {
    selectedBlock();
    highlightBlock();
    if (mousePressed && playerTurn && selectedBlock() != 0 && pieces[selectedBlock()] == '.') {
      turn--;
      playerPiecePlaced++;
      pieces[selectedBlock()] = 'F';

      switch (selectedBlock()) {
      case 1: 
        if ((pieces[2]=='F' && pieces[3]=='F') || (pieces[4]=='F' && pieces[7]=='F') || (pieces[5]=='F' && pieces[9]=='F'))
          gameOver('W');
        break;
      case 2: 
        if ((pieces[1]=='F' && pieces[3]=='F') || (pieces[5]=='F' && pieces[8]=='F'))
          gameOver('W');
        break;
      case 3: 
        if ((pieces[1]=='F' && pieces[2]=='F') || (pieces[6]=='F' && pieces[9]=='F') || (pieces[5]=='F' && pieces[7]=='F'))
          gameOver('W');
        break;
      case 4: 
        if ((pieces[5]=='F' && pieces[6]=='F') || (pieces[1]=='F' && pieces[7]=='F'))
          gameOver('W');
        break;
      case 5: 
        if ((pieces[4]=='F' && pieces[6]=='F') || (pieces[2]=='F' && pieces[8]=='F') || (pieces[1]=='F' && pieces[9]=='F') || (pieces[3]=='F' && pieces[7]=='F'))
          gameOver('W');
        break;
      case 6: 
        if ((pieces[4]=='F' && pieces[5]=='F') || (pieces[3]=='F' && pieces[9]=='F'))
          gameOver('W');
        break;
      case 7: 
        if ((pieces[8]=='F' && pieces[9]=='F') || (pieces[1]=='F' && pieces[4]=='F') || (pieces[3]=='F' && pieces[5]=='F'))
          gameOver('W');
        break;
      case 8: 
        if ((pieces[7]=='F' && pieces[9]=='F') || (pieces[2]=='F' && pieces[5]=='F'))
          gameOver('W');
        break;
      case 9: 
        if ((pieces[7]=='F' && pieces[8]=='F') || (pieces[3]=='F' && pieces[6]=='F') || (pieces[1]=='F' && pieces[5]=='F'))
          gameOver('W');
        break;
      }
      savedTime = currentTime;
      playerTurn = !playerTurn;
    }
  }
}

String lineAnimationPath(){
  if (pieces[1]=='F' && pieces[2]=='F' && pieces[3]=='F' || pieces[1]=='E' && pieces[2]=='E' && pieces[3]=='E')
  return "13";
  else if (pieces[4]=='F' && pieces[5]=='F' && pieces[6]=='F' || pieces[4]=='E' && pieces[5]=='E' && pieces[6]=='E')
  return "46";
  else if (pieces[7]=='F' && pieces[8]=='F' && pieces[9]=='F' || pieces[7]=='E' && pieces[8]=='E' && pieces[9]=='E')
  return "79";
  else if (pieces[1]=='F' && pieces[4]=='F' && pieces[7]=='F' || pieces[1]=='E' && pieces[4]=='E' && pieces[7]=='E')
  return "17";
  else if (pieces[2]=='F' && pieces[5]=='F' && pieces[8]=='F' || pieces[2]=='E' && pieces[5]=='E' && pieces[8]=='E')
  return "28";
  else if (pieces[3]=='F' && pieces[6]=='F' && pieces[9]=='F' || pieces[3]=='E' && pieces[6]=='E' && pieces[9]=='E')
  return "39";
  else if (pieces[1]=='F' && pieces[5]=='F' && pieces[9]=='F' || pieces[1]=='E' && pieces[5]=='E' && pieces[9]=='E')
  return "19";
  else if (pieces[3]=='F' && pieces[5]=='F' && pieces[7]=='F' || pieces[3]=='E' && pieces[5]=='E' && pieces[7]=='E')
  return "73";
  else
  return "";
}

boolean rngPlayerAssignment() {
  float rng = random(10);
  if (int(rng) % 2 == 0)
    return true;
  else
    return false;
}

int selectedBlock() {
  int blockNumber = 0;
  if (mouseX > 0 && mouseX < 200 && mouseY > 0 && mouseY < 200)
    blockNumber = 1;
  else if (mouseX > 200 && mouseX < 400 && mouseY > 0 && mouseY < 200)
    blockNumber = 2;
  else if (mouseX > 400 && mouseX < 600 && mouseY > 0 && mouseY < 200)
    blockNumber = 3;
  else if (mouseX > 0 && mouseX < 200 && mouseY > 200 && mouseY < 400)
    blockNumber = 4;
  else if (mouseX > 200 && mouseX < 400 && mouseY > 200 && mouseY < 400)
    blockNumber = 5;
  else if (mouseX > 400 && mouseX < 600 && mouseY > 200 && mouseY < 400)
    blockNumber = 6;
  else if (mouseX > 0 && mouseX < 200 && mouseY > 400 && mouseY < 600)
    blockNumber = 7;
  else if (mouseX > 200 && mouseX < 400 && mouseY > 400 && mouseY < 600)
    blockNumber = 8;
  else if (mouseX > 400 && mouseX < 600 && mouseY > 400 && mouseY < 600)
    blockNumber = 9;
  return blockNumber;
}

void nextLevel() {
  gameOverBool = false;
  resetBool = false;
  turn = 6;
  lineAnimation = 0;
  enemyLastBlock = 0;
  playerPiecePlaced = 0;
  squares = new PVector[10]; //Eligible coordinates for pieces to move into 
  pieces = new char[10]; // '.' = Empty, 'E' = Enemy, 'F' = Friendly
  playerStarts = false;
  playerTurn = false;
  result = '.';
  gameOverAccentColor = color(255);
  savedTime = millis();
  setup();
  lineAnimationPath();
}

void drawScoreBoard() {
  textAlign(CORNER);
  setGradient(xGradient, 0, width, height, color(102, 102, 153), color(153, 51, 77));
  setGradient(xGradient + width, 0, width, height, color(153, 51, 77), color(102, 102, 153));
  setGradient(xGradient + width * 2, 0, width, height, color(102, 102, 153), color(153, 51, 77));
  xGradient--;
  if (xGradient <= width * -2)
    xGradient = 0;
  if (playerNameTextInputBool && !leaderBoardBool)
  {
    fill(255);
    textSize(18);
    text("Type your name and press ENTER to Continue", 120, 280);

    translate(width/2, height/2);
    textSize(14);
    rect(0 - 100, 0 - 20, 200, 40);
    fill(0);
    textSize(16);
    text(textInput, -90, 5);
    if (currentTime - savedTime > 500) {
      showCaret = !showCaret;
      savedTime = currentTime;
    }
    if (showCaret) {
      stroke(0);
      line (-90 + textWidth(textInput), -10, -90 + textWidth(textInput), 10);
    }
    translate(-width/2, -height/2);
  } else if (leaderBoardBool) {
    fill(255);
    textAlign(CENTER);
    textSize(24);
    text("LEADERBOARD", width/2, 100);
    textSize(14);
    text("Press any key to Main Menu", width/2, 120);
    textSize(16);
    if (xGradient <= width * -2)
      xGradient = 0;
    xml = loadXML("ScoreBoard.xml");
    children = xml.getChildren("Record");
    String[] orderedScores = new String[children.length];
    String[] originalScores = new String[children.length];
    String[] names = new String[children.length];
    int[] orderIndexScores = new int[children.length];

    for (int i = 0; i < children.length; i++) {
      originalScores[i] = children[i].getChild("Score").getContent();
      orderedScores[i] = children[i].getChild("Score").getContent();
      names[i] = children[i].getChild("Name").getContent();
    }
    orderedScores = reverse(orderedScores);
    for (int i = 0; i < orderedScores.length; i++)
    {
      for (int j = 0; j < originalScores.length; j++)
      {
        if (originalScores[j] == orderedScores[i])
          orderIndexScores[i] = j;
      }
    }

    for (int i = 0; i < orderedScores.length; i++) {
      fill(255);
      textAlign(LEFT);
      text(names[orderIndexScores[i]], 180, (height/4) + 50 + i * 20);
      textAlign(RIGHT);
      text(orderedScores[i], 180  + (width/2 - 60), (height/4) + 50 + i * 20);
    }
  }
}

//SOURCE: https://www.javatpoint.com/how-to-remove-last-character-from-string-in-java#:~:text=%20There%20are%20four%20ways%20to%20remove%20the,%28%29%20Method%204%20Using%20Regular%20Expression%20More%20
String removeLastCharacter(String str)   
{  
  return (str == null) ? null : str.replaceAll(".$", "");
}  

void loadScreen() {
  imageMode(CORNER);
  image(loadingTop, 0, -(height/2) + yTransition1);
  image(loadingBottom, 0, 650 + yTransition2);
  imageMode(CENTER);

  if (transition == "T1") {
    yTransition1 += yTransitionSpeed;
    yTransition2 -= yTransitionSpeed;
    if (yTransition1 > 325 && yTransition2 < -325 && transition == "T1") {
      if (page == "MainMenu") {
        leaderBoardBool = false;
        mainMenuBool = true;
        lineAnimation = 0;
        winCounter = 0; 
        loseCounter = 0;
        drawCounter = 0;
      } else if (page == "Game") {
        mainMenuBool = false;
        nextLevel();
      } else if (page == "ScoreBoard") {
        playerNameTextInputBool = true;
      } else if (page == "Exit")
        exit();
      transition = "T2";
    }
  } 
  if (transition == "T2") {
    yTransition1 -= yTransitionSpeed;
    yTransition2 += yTransitionSpeed;
    if (yTransition1 < -10 && yTransition2 > 10) {
      yTransition1 = 0;
      yTransition2 = 0;
      transition = "T0";
    }
  }
}

void mouseReleased() {
  if (mainMenuBool && transition == "T0") {
    translate(width/2, height/2);
    //Start Game click event
    if (mouseX - (width/2) >= -100 && mouseX - (width/2) <= 100 && mouseY - (height/2) >= 0 && mouseY - (height/2) <= 60) {
      transition = "T1";
      page = "Game";
    }  //Option click event
    else if (mouseX - (width/2) >= -100 && mouseX - (width/2) <= 100 && mouseY - (height/2) >= 100 && mouseY - (height/2) <= 160) {
    }  //Exit click event
    else if (mouseX - (width/2) >= -100 && mouseX - (width/2) <= 100 && mouseY - (height/2) >= 200 && mouseY - (height/2) <= 260) {
      transition = "T1";
      page = "Exit";
    }
    translate(-width/2, -height/2);
  } else if (gameOverBool && transition == "T0") {
    translate(width/2, height/2);
    //Continue event click
    if (turn == 0 && mouseX - (width/2) >= 50 - (width/2) && mouseX - (width/2) <= (50 - (width/2) + 200) && mouseY - (height/2) >= 32 && mouseY - (height/2) <= 32 + 60)
      resetBool = true;
    //Main Menu click event
    else if (mouseX - (width/2) >= 50 && mouseX - (width/2) <= (50 + 200) && mouseY - (height/2) >= 32 && mouseY - (height/2) <= 32 + 60) {
      transition = "T1";
      page = "ScoreBoard";
    }
      translate(-width/2, -height/2);
 //<>//
  }
}

void keyTyped() {
  if (playerNameTextInputBool && !leaderBoardBool && transition == "T0") {
    if (key == BACKSPACE) {
      textInput = removeLastCharacter(textInput);
    } else if (key == ENTER) {
      playerName = textInput;
      XML newRecord = xml.addChild("Record");
      XML newName = newRecord.addChild("Name");
      XML newScore = newRecord.addChild("Score");
      newName.setContent(textInput);
      newScore.setContent(nf(playerScore, 4));
      saveXML(xml, "/data/ScoreBoard.xml");
      leaderBoardBool = true;
      playerNameTextInputBool = false;
    } else if (textWidth(textInput) < 178.0625) {
      charInput = key;
      textInput += str(charInput);
    }
  } else if ((gameOverBool && transition == "T0" && leaderBoardBool)) {
    page = "MainMenu";
    transition = "T1";
  }
}
