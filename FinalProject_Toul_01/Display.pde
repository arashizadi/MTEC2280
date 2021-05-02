void display(byte screen) {
  rect(0, 0, width, height);
    textBanner(screen);

  switch (screen) {
  case 0:
    break;
  case 1:
    displayFreq();
    break;
  case 2:
    displayOsc(selectedLine);
    break;
  case 3:
    displayPf(selectedLine);
    break;
  case 4:
    displayReverb();
    break;
  case 5:
    displayDelay();
    break;
  }
  fill(0);
  rect(0, 0, width, 35);
  rect(0, height-35, width, 35);
  fill(255);
  textAlign(CENTER);
  textSize(18);
  text(title.toUpperCase(), width/2, 35/2 + 8);
  textAlign(CORNER);
  textAlign(CENTER);
  textSize(18);
  text(title.toUpperCase(), width/2, 35/2 + 8);
  text(helper, width/2, 8 + height - 35 + 35/2);
  textAlign(CORNER);
}
