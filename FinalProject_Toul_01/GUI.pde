void window(float x, float y, float w, float h) {
  x += 5;
  y += 22;
  h -= 89;
  w -= 10;
  translate(x, y);
  noFill();
  strokeWeight(0.1);
  stroke(fg);
  rect(x, y, w, h, 20);
  translate(-x, -y);
}

void button(float x, float y, String label, int func) {
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
    mouseUp = func;

  } else {
    fill(bg);
    rect(0, 0, label.length() * 20, 50);
    fill(fg);
    textSize(20);
    textAlign(CENTER);
    text(label, label.length() * 10, 0 + 31);
  }
  translate(-x, -y);
}
