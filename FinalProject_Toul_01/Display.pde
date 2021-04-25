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
      strokeWeight(0.5);
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
    fill(fg);
    text(floor(_oct) + " | " + floor(_oct+1), 650, 255);
    break;
  case 2:
    title = "Line 1: Oscillators";
    helper = "Active: Sawtooth + White Noise";
    textAlign(CENTER);
    textSize(24);
    stroke(0);
    strokeWeight(4);

    if (mouseX >= 0 && mouseX <= 280 
      && mouseY >= 35 && mouseY <= height/2 && mousePressed)
      mouseUp = 4;
    if (one.outputs[0]) {
      fill(#27C5BD);
      rect(0, 35, 280, height/2-35);
      fill(fg);
      text("Sinusoid ~", 140, height/4 + 25);
    } else
    {
      fill(#71bcb9);
      rect(0, 35, 280, height/2-35);
      fill(bg);
      text("Sinusoid ~", 140, height/4 + 25);
    }
    if (mouseX >= 0 && mouseX <= 280 
      && mouseY >= height/2 && mouseY <= height/2 + height/2-35 && mousePressed)
      mouseUp = 5;
    if (one.outputs[1])
    {
      fill(#61C442);
      rect(0, height/2, 280, height/2-35);
      fill(fg);
      text("Triangle ∆", 140, height - 130);
    } else {
      fill(#91c381);
      rect(0, height/2, 280, height/2-35);
      fill(bg);
      text("Triangle ∆", 140, height - 130);
    }
    if (mouseX >= 280 && mouseX <= 560 
      && mouseY >= 35 && mouseY <= height/2 && mousePressed)
      mouseUp = 6;
    if (one.outputs[2])
    {
      fill(#6F4BCF);    
      rect(280, 35, 280, height/2-35);
      fill(fg);
      text("Square □", 420, height/4 + 25);
    } else {
      fill(#aa9cd2);
      rect(280, 35, 280, height/2-35);
      fill(bg);
      text("Square □", 420, height/4 + 25);
    }
    if (mouseX >= 280 && mouseX <= 560 
      && mouseY >= height/2 && mouseY <= height/2 + height/2-35 && mousePressed)
      mouseUp = 7;
    if (one.outputs[3]) {
      fill(#FE7474);
      rect(280, height/2, 280, height/2-35);
      fill(fg);
      text("Sawtooth N", 420, height - 130);
      fill(#FE7474);
      noStroke();
      rect(482.04, height/2+10, 280 - 20, height/2-35 - 10);
      stroke(0);
    } else {
      fill(#fdb1b1);
      rect(280, height/2, 280, height/2-35);
      fill(bg);
      text("Sawtooth N", 420, height - 130);
      fill(#fdb1b1);
      noStroke();
      rect(482.04, height/2+10, 280 - 20, height/2-35 - 10);
      stroke(0);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280 + 35/3
      && mouseY >= 35 && mouseY <= 35 + height/3 - 35/3 && mousePressed)
      mouseUp = 8; 
    if (one.outputs[4]) {
      fill(#e7e7e7);
      rect(560, 35, 280 + 35/3, height/3 - 35/3);
      fill(fg);
      text("White ▓", 677 + 35/5, height/4 - 7);
    } else {
      fill(#9b9b9b);
      rect(560, 35, 280 + 35/3, height/3 - 35/3);
      fill(bg);
      text("White ▓", 677 + 35/5, height/4 - 7);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280
      && mouseY >= height/3  + 35/3 && mouseY <= height/3  + 35/3 + height/3 - 35/3 && mousePressed)
      mouseUp = 9; 
    if (one.outputs[5]) {
      fill(#FE02E4);
      rect(560, height/3  + 35/3, 280, height/3 - 35/3);
      fill(fg);
      text("Pink ░", 677 + 35/5, height/4 +130);
    } else {
      fill(#fb9ff2);
      rect(560, height/3  + 35/3, 280, height/3 - 35/3);
      fill(bg);
      text("Pink ░", 677 + 35/5, height/4 +130);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280
      && mouseY >= height/3 + height/3 - 35/3 && mouseY <= height/3 + height/3 - 35/3 + height/3 - 35/3&& mousePressed)
      mouseUp = 10; 
    if (one.outputs[6]) {
      fill(#cd0044);
      rect(560, height/3 + height/3 - 35/3, 280, height/3 - 35/3);
      fill(fg);
      text("Brownian ▒", 677 + 35/5, height/4 + 265);
    } else {
      fill(#ce8da3);
      rect(560, height/3 + height/3 - 35/3, 280, height/3 - 35/3);
      fill(bg);
      text("Brownian ▒", 677 + 35/5, height/4 + 265);
    }
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
