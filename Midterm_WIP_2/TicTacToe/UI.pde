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

  fill(102, 102, 153);
  rect(0, _height, width, height - _height);

  fill(0);
  textSize(24.12);
  text(status, 20-0.5, height - 15);

  fill(255);
  textSize(24);
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

void gameOver(char a) {
  gameOverBool = true;
  fill(0, 200);
  rectMode(CENTER);
  rect(width/2, height/2 - 25, width, 150);
  fill(130);
  textSize(64);
  if (a == 'W') {
    fill(102, 255, 25);
    text("YOU WON!", width/2, height/2);
  } else if (a == 'L')
  {
    fill(210, 40, 30);
    text("YOU LOST!", width/2, height/2);
  } else
  {
    fill(90, 200, 230);
    text("DRAW!", width/2, height/2);
  }
  rectMode(CORNER);
  turn = 0;
  if (result == '.')
    result = a;
}
