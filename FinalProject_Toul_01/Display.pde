void display(byte screen) {
  rect(0, 0, width, height);
  switch (screen) {
  case 0:
    title = "Main Menu";
    helper = "OSC 1, OSC 3";
    break;
  case 1:
    title = "Frequency";
    helper = "OSC 1, OSC 3";
    window(245, 0, 300, height);
    window(0, 0, width/2, height);
    strokeWeight(2);
    rect(15, height/2-10, width/2 - 20, 15);
    if (mouseX >= 5 && mouseX <= width/2 + 5 
      && mouseY >= 35 && mouseY <= height +38-89 && mousePressed)
    {    
      strokeWeight(0);
      fill(bg);
      rect(0, 0, width/2, height);
      window(0, 0, width/2, height);
      strokeWeight(3);
      fill(fg);
      rect(15, mouseY, width/2 - 20, 15);
      _pitch = map(mouseY, 420, 40, -_note/2, _note/2);
      mouseUp = 3;
    }
    if (_oct != 7)
      button(570, 100, "Octave +", 1);
    if (_oct != -2)
      button(570, 320, "Octave -", 2);
    textSize(64);
    fill(bg);
    stroke(bg);
    fill(fg);
    text(floor(_oct) + " | " + floor(_oct+1), 650, 255);
    break;
  case 2:
    title = "Oscillators";
    helper = "Line 1: Sawtooth + White Noise";
    stroke(0);
    fill(#27C5BD);
    rect(0, 35, 280, height/2-35);
    fill(#61C442);
    rect(0, height/2, 280, height/2-35);
    fill(#6F4BCF);
    rect(280, 35, 280, height/2-35);
    fill(#FE7474);
    rect(280, height/2, 280, height/2-35);
    fill(#D3D3D3);
    rect(560, 35, 280 + 35/3, height/3 - 35/3);
    fill(#FE02E4);
    rect(560, height/3  + 35/3, 280, height/3 - 35/3);
    fill(#A0672E);
    rect(560, height/3 + height/3 - 35/3, 280, height/3 - 35/3);
    break;
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
