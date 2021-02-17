String[] mainmenu = new String[2];
PVector[] buttons = new PVector[mainmenu.length];
final int buttonWidth = 200, buttonHeight = 50;
int stage = -1;

void setup() {
  size(800, 800);
  stroke(0, 0, 0, 255);
  strokeWeight(1);
  switch (stage) {
  default:
  case -1:   
    setupUI(); 
    break;
  case 0: 
    SketchOne(); 
    break;
  case 1: 
    setupSketchTwo(); 
    break;    
    //case 2: setupThirdSketch(); break;
  }
  setupBackButton();
}

void draw() {
  drawSketchTwo();
}
void mouseMoved() {
  mouseMovedUI();
  mouseMovedBackButton();
}
void mouseClicked() {
  mouseClickedUI();
  mouseClickedBackButton();
}
void mouseDragged() {
  mouseClickedUI();
  mouseDraggedSketchTwo();
  mouseClickedBackButton();
}
void mouseReleased() {
  mouseReleasedSketchTwo();
}
void SketchOne() {
  if (stage == 0) {
    // background (255, 0, 45);  
    clear();
    background (230, 230, 230);  
    //Sketch #1: Algorithmic Drawing
    //Tendency by A.I.
    for (int i = 0; i < width; i += width/5) {
      strokeWeight(i/50);
      fill(0, 0, 0, 0.6*(i+1));
      triangle(30+i, 75+i, 58+i, 20+i, 86+i, 75+i);
      square(width-30-i, height-20-i, 55);
    }
  }
  strokeWeight(5);
  stroke(60, 102, 153, 50);
  line(width/2, height/10, width/2, height/4);
  fill(20, 20, 20);
  text("A.I.", 10, height-10);
}
void setupSketchTwo() {
  background (255, 0, 45);
}
void drawSketchTwo() {
  if (stage == 1)
    line(width/2, 0, mouseX, mouseY);
}

void setupBackButton() {
  if (stage != -1) {
    fill(0, 50, 100);
    strokeWeight(2);
    rect(0, 0, buttonWidth/2, buttonHeight/2, 6);
    fill(240);
    text("Main Menu", 20, 18);
  }
}

void mouseMovedBackButton() {
  if (stage != -1) {
    if (mouseX >= 0 && mouseX <= buttonWidth/2 
      && mouseY >= 0 && mouseY <= buttonHeight/2) {
      fill(255, 200, 200);
      strokeWeight(2);
      rect(0, 0, buttonWidth/2, buttonHeight/2, 6);
      fill(20);
      text("Main Menu", 20, 18);
    } else
    {
      fill(0, 50, 100);
      strokeWeight(2);
      rect(0, 0, buttonWidth/2, buttonHeight/2, 6);
      fill(240);
      text("Main Menu", 20, 18);
    }
  }
}
void mouseClickedBackButton() {
  if (stage != -1) {
    if (mouseX >= 0 && mouseX <= buttonWidth/2 
      && mouseY >= 0 && mouseY <= buttonHeight/2) {
      stage = -1;
      clear();
      setup();
    }
  }
}
void setupUI() {
  if (stage == -1) {
    background(230);
    mainmenu[0] = "First Sketch";
    mainmenu[1] = "Second Sketch";
    //mainmenu[2] = "Third Sketch";
    fill(200);
    for (int i = 0; i < mainmenu.length; i++) {
      buttons[i] = new PVector(width/2 - buttonWidth/2, (height/2)+ i*100 - mainmenu.length*20);
      fill(200);
      rect(buttons[i].x, buttons[i].y, buttonWidth, buttonHeight, 6);
      fill(20);
      text(mainmenu[i], buttons[i].x + buttonWidth/3, buttons[i].y + buttonHeight/2);
    }
  }
}
void mouseMovedUI() {
  if (stage == -1) {
    for (int i = 0; i < mainmenu.length; i++) {
      //checking if mouse is on any buttons.
      if (mouseX >= buttons[i].x && mouseX <= buttons[i].x + buttonWidth
        && mouseY >= buttons[i].y && mouseY <= buttons[i].y + buttonHeight) {

        fill(0, 50, 100);
        rect(buttons[i].x, buttons[i].y, buttonWidth, buttonHeight, 6);
        fill(240);
        text(mainmenu[i], buttons[i].x + buttonWidth/3, buttons[i].y + buttonHeight/2);
      } else {
        fill(200);
        rect(buttons[i].x, buttons[i].y, buttonWidth, buttonHeight, 6);
        fill(20);
        text(mainmenu[i], buttons[i].x + buttonWidth/3, buttons[i].y + buttonHeight/2);
      }
    }
  }
}

void mouseClickedUI() {
  if (stage == -1) {
    for (int i = 0; i < mainmenu.length; i++) {
      //checking if mouse is on any buttons.
      if (mouseX >= buttons[i].x && mouseX <= buttons[i].x + buttonWidth
        && mouseY >= buttons[i].y && mouseY <= buttons[i].y + buttonHeight) {
        stage = i;      
        setup();
      }
    }
  }
}
void mouseDraggedSketchTwo() {
  if (stage == 1)
    ellipse(mouseX, mouseY, 400, 400);
}
void mouseReleasedSketchTwo() {
  if (stage == 1) {
    background (255, 0, 45);
    text("X: " + mouseX + " | Y: " + mouseY, mouseX, mouseY + 30);
  }
}
