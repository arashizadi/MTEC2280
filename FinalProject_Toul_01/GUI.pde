void window(float x, float y, float w, float h) {
  x += 5;
  y += 22;
  h -= 89;
  w -= 10;
  translate(x, y);
    println("X: " + x +"Y: " + y +"W: " + w +"H: " + h );
  noFill();
  strokeWeight(0.1);
  rect(x, y, w, h, 20);
  translate(-x, -y);
}

void button(float x, float y, String label, int screen) {
  translate(x, y);
  noFill();
  rect(0, 0, label.length() * 20, 50);
  fill(bg);
  textSize(20);
  textAlign(CENTER);
  text(label, label.length() * 10, 0 + 31);
  textAlign(CORNER);
  if (mouseX >= x && mouseX <= x + label.length() * 20 
    && mouseY >= y && mouseY <= y + 50 && mousePressed)
  {
    fill(fg);
    rect(0, 0, label.length() * 20, 50);
    fill(bg);
    textSize(20);
    textAlign(CENTER);
    text(label, label.length() * 10, 0 + 31);
    mouseUp = screen;
  } else {
    fill(bg);
    rect(0, 0, label.length() * 20, 50);
    fill(fg);
    textSize(20);
    textAlign(CENTER);
    text(label, label.length() * 10, 0 + 31);
    mouseUp = 0;
  }
  translate(-x, -y);
}
