//TicTacToe by A.I.
PImage o, x, loadingTop, loadingBottom;
int _height, turn = 6, currentTime = 0, savedTime = 0, enemyLastBlock = 0, playerPiecePlaced = 0, xGradient = 0, winCounter = 0, loseCounter = 0, drawCounter = 0, playerScore, yTransition1 = 0, yTransition2 = 0, yTransitionSpeed = 7;
PVector[] squares = new PVector[10]; //Eligible coordinates for pieces to move into 
char[] pieces = new char[10]; // '.' = Empty, 'E' = Enemy, 'F' = Friendly
boolean playerStarts, playerTurn, gameOverBool, resetBool, mainMenuBool = true, playerNameTextInputBool, leaderBoardBool, showCaret, inGameMenu;
char result = '.', charInput;
String status, transition = "T0", page = "", playerName, textInput = "", ver = "0.61 alpha";
color gameOverAccentColor = color(255);
float lineAnimation = 0;
PFont font;
XML xml;
XML[] children;

void setup() {
  size(600, 650);
  o = loadImage("O.png");
  x = loadImage("X.png");
  loadingTop = loadImage("loadingtop.png");
  loadingBottom = loadImage("loadingbottom.png");
  xml = loadXML("./ScoreBoard.xml");
  font = createFont("BAUHS93.TTF", 64);
  imageMode(CENTER);
  strokeCap(ROUND);
  textFont(font);
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
  if (mainMenuBool)
    drawMainMenu();
  else if (playerNameTextInputBool || leaderBoardBool)
    drawScoreBoard();
  else {
    drawBoard();
    drawStatusBar();
    enemyMove();
    playerMove();
    drawPieces();
    drawCursor();
    if (turn == 0)
      drawVictoryLine(lineAnimationPath());
    if (inGameMenu)
      drawInGameMenu();
  }
  loadScreen();
}
