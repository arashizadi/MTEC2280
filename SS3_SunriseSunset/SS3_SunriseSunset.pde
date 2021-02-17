//Sunrise Sunset by A.I.
//Drag the white rectangle in x-axis

PImage sunrise, sunset;
PVector button;
int pixelX = 0; 
int opacity, _opacity;
boolean dragging, valueChanged;

void setup() {
  size(987, 555);
  imageMode(CENTER);
  sunrise = loadImage("sunrise.png");
  sunset = loadImage("sunset.png");
  rectMode(CENTER);
  button = new PVector(width/2+pixelX, height*2/3);
}

void draw() {
  background(255);
  tint(255, 255);
  image(sunrise, width/2, height/2);
  tint(255, 125+pixelX);  // Apply transparency
  image(sunset, width/2, height/2);

  opacity = round(map(pixelX, -135, 135, 0, 100));
  drawButton();
  drawText();
}

void mouseDragged() {
  if (dragging || (pmouseX != mouseX && mouseX >= button.x && mouseY >= button.y &&
    mouseX <= button.x + 100 && mouseY <= button.y + 40)) {
    if (!valueChanged) {
      _opacity = opacity;
      valueChanged = true;
    }
    if (opacity > 100) {
      opacity = 100;
      pixelX = 135;
    } else if (opacity < 0) {
      opacity = 0;
      pixelX = -135;
    } else {
      pixelX += mouseX-pmouseX;
      button = new PVector(width/2+pixelX, height*2/3);
      dragging = true;
    }
  }
}

void mouseReleased() {
  dragging = false;    
  if (button.x < 359)
    button = new PVector(359, height*2/3);
  else if (button.x > 627)
    button = new PVector(627, height*2/3);
  valueChanged = false;
}
void drawButton() {
  if (mouseX >= button.x && mouseY >= button.y &&
    mouseX <= button.x + 100 && mouseY <= button.y + 40) 
    strokeWeight(4);
  else 
  strokeWeight(1);
  if (opacity < 0 || button.x < 359)
  {
    button = new PVector(359, height*2/3);
    textSize(14); 
    fill(250);
    rect(button.x, button.y-5, 100, 40);    
    fill(20);
    text("Opacity: " + 0, button.x, button.y);
  } else if (opacity > 100 || button.x > 627) {
    button = new PVector(627, height*2/3);
    textSize(14); 
    fill(250);
    rect(button.x, button.y-5, 100, 40);    
    fill(20);
    text("Opacity: " + 100, button.x, button.y);
  } else {    
    textSize(14); 
    fill(250);
    rect(button.x, button.y-5, 100, 40);    
    fill(20);
    text("Opacity: " + round(opacity), button.x, button.y);
  }
}

void drawText() {
  textAlign(CENTER);
  textSize(18); 
  fill(255);

  if (dragging) {
    if (_opacity != opacity && int(abs(_opacity - opacity)) >= 2) //make sure to show only numbers that are user friendly
      text("Changing the Opacity by: " + (opacity - _opacity), width/2, height/3);
  } else
    text("Drag the knob horizontally to change between Sunset and Sunrise.", width/2, height/3);
}
