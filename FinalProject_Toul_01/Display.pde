void display(byte screen) {
  switch (screen) {
  case 0:
    title = "Main Menu";
    helper = "OSC 1, OSC 3";
    window(245, 0, 300, height);
    window(0, 0, width/2, height);
    if (_oct != 8)
    button(570, 100, "Octave +", 1);
    button(570, 320, "Octave -", 2);
    textSize(64);
    fill(bg);
    stroke(bg);
    rect(520, 200, 270, 100);
    fill(fg);
    text(floor(_oct) + " | " + floor(_oct+1), 650, 255);
    break;
  case 1:
    title = "Frequency";
    helper = "OSC 1, OSC 3";
  }
  fill(0);
  rect(0, 0, width, 35);
  rect(0, height-35, width, 35);
  fill(255);
  textAlign(CENTER);
  textSize(18);
  text(title.toUpperCase(), width/2, 35/2 + 8);
  text(helper, width/2, 8 + height - 35 + 35/2);
  textAlign(CORNER);
}
