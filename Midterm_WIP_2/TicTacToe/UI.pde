void drawBoard() {
  stroke(200);
  fill(40);
  for (int i = 0; i < width; i+=200)
    for (int j = 0; j < _height; j+=200)
      rect(i, j, i+200, j+200);
  drawStatusBar();
}

void drawStatusBar() {
  textAlign(CORNER);
  fill(20);
  rect(0, _height, width, height - _height);
  fill(200);
  textSize(20);
  text(status, 20, height - 15);
  textAlign(CENTER);
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
  if (playerStarts && turn != 0)
    cursor(o, 31, 31);
  else if (!playerStarts && turn != 0)
    cursor(x, 31, 31);
  else
    cursor(ARROW);
}

void gameOver(char a) {
  status = "Game over";
  drawStatusBar();
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
