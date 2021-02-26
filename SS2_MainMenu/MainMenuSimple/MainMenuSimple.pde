//MainMenuSimple by A.I.
String[] mainmenu = new String[3];
PVector[] buttons = new PVector[mainmenu.length];
final int buttonWidth = 200, buttonHeight = 50;
int click = 0;

void setup() {
  size(800, 800);
  setupUI();
}
void draw() {}
void mouseMoved() {
  mouseMovedUI();
}
void mouseClicked() {
  mouseClickedUI();
}
void mouseDragged() {
  mouseClickedUI();
}

void setupUI() {
  background(230);
  mainmenu[0] = "First Sketch";
  mainmenu[1] = "Second Sketch";
  mainmenu[2] = "Third Sketch";
  fill(200);
  //rectMode(CENTER);
  //textAlign(CENTER);

  for (int i = 0; i < mainmenu.length; i++) {
    buttons[i] = new PVector(width/2 - buttonWidth/2, (height/2)+ i*100 - mainmenu.length*20);
    fill(200);
    rect(buttons[i].x, buttons[i].y, buttonWidth, buttonHeight, 6);
    fill(20);
    text(mainmenu[i], buttons[i].x + buttonWidth/3, buttons[i].y + buttonHeight/2);
  }
}
void mouseMovedUI() {
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
void mouseClickedUI() {
  for (int i = 0; i < mainmenu.length; i++) {
    //checking if mouse is on any buttons.
    if (mouseX >= buttons[i].x && mouseX <= buttons[i].x + buttonWidth
      && mouseY >= buttons[i].y && mouseY <= buttons[i].y + buttonHeight) {
      click++;
      switch (i) {
      case 0 : println("Button 1 Clicked. Total Clicks: " + click); break;
      case 1 : println("Button 2 Clicked. Total Clicks: " + click); break;
      case 2 : println("Button 3 Clicked. Total Clicks: " + click); break;
      }
    }
  }
}
