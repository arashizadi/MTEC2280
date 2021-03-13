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
  gameOverBool = true;
  
  fill(gameOverAccentColor, 30);
  rectMode(CORNER);
  rect(0, 0, width, _height);
  
  fill(0, 200);
  rectMode(CENTER);
  stroke(gameOverAccentColor);
  rect(width/2, height/2 - 25, width, 150);
  fill(130);
  textSize(64);
  
  if (a == 'W') {
    winCounter++;
    gameOverAccentColor = color(102, 255, 25);
    fill(gameOverAccentColor);
    text("YOU WON!", width/2, height/2);
  } else if (a == 'L')
  {
    loseCounter++;
    gameOverAccentColor = color(210, 40, 30);
    fill(gameOverAccentColor);
    text("YOU LOST!", width/2, height/2);
  } else
  {
    drawCounter++;
    gameOverAccentColor = color(90, 200, 230);
    fill(gameOverAccentColor);
    text("DRAW!", width/2, height/2);
  }
  rectMode(CORNER);
  turn = 0;
  if (result == '.')
    result = a;
  stroke(255);
}
