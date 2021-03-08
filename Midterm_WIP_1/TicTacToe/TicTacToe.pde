//TicTacToe by A.I.
PImage o, x;
int _height, turn = 6; //0 = game over
PVector[] squares = new PVector[10]; //Eligible coordinates for pieces to move into 
char[] pieces = new char[10]; // '.' = Empty, 'E' = Enemy, 'F' = Friendly
boolean playerStarts, playerTurn;
char result = '.';
String status = "Ready";

void setup() {
  size(600, 650);
  o = loadImage("O.png");
  x = loadImage("X.png");
  imageMode(CENTER);
  _height = height - 50;


 //82 squares[0] = new PVector(-100, -100); //out of the screen
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
  drawStatusBar();
  playerMove();
  drawStatusBar();
  drawPieces();
  drawCursor();
  if (turn == 0)
    gameOver(result);
}
