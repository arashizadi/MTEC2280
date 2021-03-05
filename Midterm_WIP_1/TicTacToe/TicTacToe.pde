//TicTacToe by A.I.
PImage o, x;
int turn = 6; //0 = game over
PVector[] squares = new PVector[10]; //Eligible coordinates for pieces to move into 
char[] pieces = new char[10]; // '.' = Empty, 'E' = Enemy, 'F' = Friendly
boolean playerStarts, playerTurn;
char result = '.';
void setup() {
  size(600, 600);
  o = loadImage("O.png");
  x = loadImage("X.png");
  imageMode(CENTER);

  squares[0] = new PVector(-100, -100); //out of the screen
  for (int i = 1, x = 100, y = 100; i < squares.length; i++, x += 200) {
    if (x > width) {
      x = 100;
      y += 200;
    }
    squares[i] = new PVector(x, y);
  }

  for (int i = 0; i < pieces.length; i++)
    pieces[i] = '.';
  playerStarts = rngPlayerAssignment();
  playerTurn = playerStarts;
}

void draw() {
  drawBoard();
  enemyMove();
  playerMove();
  drawPieces();
  drawCursor();
  if (turn == 0)
    gameOver(result);
}

void drawBoard() {
  stroke(200);
  fill(40);
  for (int i = 0; i < width; i+=200)
    for (int j = 0; j < height; j+=200)
      rect(i, j, i+200, j+200);
}

void enemyMove() {
  if (turn != 0) {
    int block = int(random(1, squares.length));
    if (!playerTurn && pieces[block] == '.') {
      image(o, squares[block].x, squares[block].y);
      turn--;
      delay(300);
      pieces[block] = 'E';

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

void playerMove() {
  if (turn != 0) {
    selectedBlock();
    if (mousePressed && playerTurn && selectedBlock() != 0 && pieces[selectedBlock()] == '.') {
      turn--;
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
      playerTurn = !playerTurn;
    }
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
  if (playerStarts && turn != 0)
    cursor(o, 31, 31);
  else if (!playerStarts && turn != 0)
    cursor(x, 31, 31);
  else
    cursor(ARROW);
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

void gameOver(char a) {
  textAlign(CENTER);
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
