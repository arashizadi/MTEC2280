//TicTacToe by A.I.
PImage o, x;
int _height, turn = 6, currentTime = 0, savedTime = 0, enemyLastBlock = 0, playerPiecePlaced = 0, xGradient = 0;
PVector[] squares = new PVector[10]; //Eligible coordinates for pieces to move into 
char[] pieces = new char[10]; // '.' = Empty, 'E' = Enemy, 'F' = Friendly
boolean playerStarts, playerTurn, gameOverBool;
char result = '.';
String status;
color gameOverAccentColor = color(255);

void setup() {
  size(600, 650);
  o = loadImage("O.png");
  x = loadImage("X.png");
  imageMode(CENTER);
  strokeCap(ROUND);

  _height = height - 50;

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
  drawStatusBar();
  enemyMove();
  playerMove();
  drawPieces();
  drawCursor();
  if (turn == 0)
    gameOver(result);
}
