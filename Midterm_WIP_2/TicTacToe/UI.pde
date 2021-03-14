void drawMainMenu() {
  setGradient(xGradient, 0, width, height, color(102, 102, 153), color(153, 51, 77));
  setGradient(xGradient + width, 0, width, height, color(153, 51, 77), color(102, 102, 153));
  setGradient(xGradient + width * 2, 0, width, height, color(102, 102, 153), color(153, 51, 77));
  xGradient--;
  if (xGradient <= width * -2)
    xGradient = 0;
  textAlign(CENTER);
  textSize(64);
  fill(255);
  text("Tic Tac Toe", width/2, height/2 - ((height/2)/2));
  textSize(16);
  text("Arash Izadi's", width/2, height/4 - ((height/3)/3));
  textSize(8);
  text("Ver. " + ver, width/2 + 150, height/2 - ((height/2)/2.5) - 15);
  translate(width/2, height/2);
  noFill();
  rect(-100, 0, 200, 60);
  rect(-100, 100, 200, 60);
  rect(-100, 200, 200, 60);

  //Start Game button mouseover
  if (mouseX - (width/2) >= -100 && mouseX - (width/2) <= 100 && mouseY - (height/2) >= 0 && mouseY - (height/2) <= 60) {
    fill(255, 100);
  rect(-100, 0, 200, 60);
    fill(255);
  }  //Option button mouseover
  else if (mouseX - (width/2) >= -100 && mouseX - (width/2) <= 100 && mouseY - (height/2) >= 100 && mouseY - (height/2) <= 160) {
    fill(255, 100);
  rect(-100, 100, 200, 60);
    fill(255);
  }  //Exit button mouseover
  else if (mouseX - (width/2) >= -100 && mouseX - (width/2) <= 100 && mouseY - (height/2) >= 200 && mouseY - (height/2) <= 260) {
    fill(255, 100);
  rect(-100, 200, 200, 60);
    fill(255);
  }

  textSize(24);
  text("Start Game", 0, 37.5);
  text("Sound: OFF", 0, 137.5);
  text("Exit", 0, 237.5);
  translate(-width/2, -height/2);
}

void drawBoard() {
  stroke(200);
  fill(40);
  for (int i = 0; i < width; i+=200)
    for (int j = 0; j < _height; j+=200)
      rect(i, j, i+200, j+200);
}

void drawStatusBar() {
  if (!playerTurn && !gameOverBool)
    status = "Enemy is thinking...";
  else if (enemyLastBlock == 0 && !gameOverBool)
    status = "Your turn.";
  else if (enemyLastBlock > 0 && !gameOverBool)
    status = "Your turn. Enemy moved to block #" + enemyLastBlock + ".";
  else
    status = "Game over.";  
  textAlign(CORNER);

  fill(50, 102, 102);
  rect(0, _height, width, height - _height);

  if (playerTurn || gameOverBool) {
    setGradient(xGradient, _height, width, height - _height, color(102, 102, 153), color(153, 51, 77));
    setGradient(xGradient + width, _height, width, height - _height, color(153, 51, 77), color(102, 102, 153));
    setGradient(xGradient + width * 2, _height, width, height - _height, color(102, 102, 153), color(153, 51, 77));
  } else {
    setGradient(xGradient, _height, width, height - _height, color(102, 102, 153, 100), color(153, 51, 77, 100));
    setGradient(xGradient + width, _height, width, height - _height, color(153, 51, 77, 100), color(102, 102, 153, 100));
    setGradient(xGradient + width * 2, _height, width, height - _height, color(102, 102, 153, 100), color(153, 51, 77, 100));
  }

  xGradient -= 5;
  if (xGradient <= width * -2)
    xGradient = 0;

  textAlign(CORNER);
  fill(255);
  textSize(26);
  text(status, 20, height - 15);
  textAlign(CENTER);

  for (int i = 25; i <= 75 - (playerPiecePlaced * 25); i += 25) {
    if (playerStarts)
      if (playerTurn && (75 - (playerPiecePlaced * 25) - i) == 0) { //while piece is in hand, apply transparency
        tint(255, 100);
        image(o, width - i, height - 23.5, 20, 20);
        tint(255, 255);
      } else
        image(o, width - i, height - 23.5, 20, 20);

    else
      if (playerTurn && (75 - (playerPiecePlaced * 25) - i) == 0) { //while piece is in hand, apply transparency
        tint(255, 100);
        image(x, width - i, height - 23.5, 20, 20);
        tint(255, 255);
      } else
        image(x, width - i, height - 23.5, 20, 20);
  }
}

void drawPieces() {
  for (int i = 0; i < pieces.length; i++)
    if (pieces[i]=='E')
      if (playerStarts)
        image(x, squares[i].x, squares[i].y);
      else
        image(o, squares[i].x, squares[i].y);
    else if (pieces[i]=='F')
      if (playerStarts)
        image(o, squares[i].x, squares[i].y);
      else
        image(x, squares[i].x, squares[i].y);
}

void drawCursor() {
  if (playerStarts && turn != 0 && playerTurn)
    cursor(o, 31, 31);
  else if (!playerStarts && turn != 0 && playerTurn)
    cursor(x, 31, 31);
  else
    cursor(ARROW);
}

void highlightBlock() {
  if (playerTurn && selectedBlock() != 0 && pieces[selectedBlock()] == '.') {
    fill(55);
    rectMode(CENTER);
    rect(squares[selectedBlock()].x, squares[selectedBlock()].y, 200, 200);
    rectMode(CORNER);
  }
}


//SOURCE: https://processing.org/examples/lineargradient.html
void setGradient(int x, int y, float w, float h, color c1, color c2) {
  noFill();
  for (int i = x; i <= x+w; i++) {
    float inter = map(i, x, x+w, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(i, y, i, y+h);
    stroke(255);
  }
}

void gameOver(char a) {
  fill(gameOverAccentColor, 30);
  rectMode(CORNER);
  rect(0, 0, width, _height);

  fill(0, 200);
  rectMode(CENTER);
  stroke(gameOverAccentColor);
  rect(width/2, height/2 - 25, width, 300);
  fill(130);
  textSize(64);

  if (a == 'W') {
    if (!gameOverBool) {
      winCounter++;
      gameOverBool = true;
    }
    gameOverAccentColor = color(102, 255, 25);
    fill(gameOverAccentColor);
    text("YOU WON!", width/2, height/3+25);
  } else if (a == 'L')
  {
    if (!gameOverBool) {
      loseCounter++;
      gameOverBool = true;
    }
    gameOverAccentColor = color(210, 40, 30);
    fill(gameOverAccentColor);
    text("YOU LOST!", width/2, height/3+25);
  } else
  {
    if (!gameOverBool) {
      drawCounter++;
      gameOverBool = true;
    }
    gameOverAccentColor = color(90, 200, 230);
    fill(gameOverAccentColor);
    text("DRAW!", width/2, height/3+25);
  }
  textSize(24);
  text("Wins: " + winCounter + " | Draws: " + drawCounter + " | Losses: " + loseCounter, width/2, height/2); 

  rectMode(CORNER);
  translate(width/2, height/2);
  noFill();
  rect(50 - (width/2), 32, 200, 60);
  rect(50, 32, 200, 60);
  //Continue button mouseover
  if (mouseX - (width/2) >= 50 - (width/2) && mouseX - (width/2) <= (50 - (width/2) + 200) && mouseY - (height/2) >= 32 && mouseY - (height/2) <= 32 + 60) {
    fill(gameOverAccentColor, 100);
    rect(50 - (width/2), 32, 200, 60);
    fill(gameOverAccentColor);
  }  //MainMenu button mouseover
  else if (mouseX - (width/2) >= 50 && mouseX - (width/2) <= (50 + 200) && mouseY - (height/2) >= 32 && mouseY - (height/2) <= 32 + 60) {
    fill(gameOverAccentColor, 100);
    rect(50, 32, 200, 60);
    fill(gameOverAccentColor);
  }
  translate(-width/2, -height/2);
  text("Continue", (width/2)/2, (height*2)/3-38); 
  text("Main Menu", (width/2)/2 + width/2, (height*2)/3-38); 

  turn = 0;
  if (result == '.')
    result = a;
  stroke(255);

  if (turn == 0 && resetBool) {
    nextLevel();
  }
}
