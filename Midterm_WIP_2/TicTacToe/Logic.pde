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
}

void loadScreen(){
imageMode(CORNER);
  image(loadingTop, 0, -(height/2) + yTransition1);
  image(loadingBottom, 0, 650 + yTransition2);
  imageMode(CENTER);

  if (transition == "T1") {
    yTransition1 += yTransitionSpeed;
    yTransition2 -= yTransitionSpeed;
    if (yTransition1 > 325 && yTransition2 < -325 && transition == "T1") {
      if (page == "MainMenu") {
        mainMenuBool = true;
        winCounter = 0; 
        loseCounter = 0;
        drawCounter = 0;
      } else if (page == "Game") {
        mainMenuBool = false;
        nextLevel();
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
      page = "MainMenu";
    }
  }
  translate(-width/2, -height/2);
}
