void displayPf(byte a) {
  title = "Line " + a+1 + ": Lowpass and Highpass Filter";
  helper = "Active Dynamic Effects: ";
  if (lpf[a] != 8000)
    helper += "Low-pass Filter, ";
  if (hpf[a] != 50)
    helper += "High-pass Filter, ";
  if (helper == "Active Dynamic Effects: ")
    helper = "No Active Dynamic Effects";
  else
    helper = helper.substring(0, helper.length() - 2);
  textSize(48);

  window(0, 15, width-10, height/2);
  noFill();
  strokeWeight(2);
  rect(25, height/4+20, width - 50, 20, 5);
  _lpFreq = map(_lp, 24, 676, 20, 8000);
  if (mouseX >= 0 && mouseX < width && mouseY > height/4-10 && mouseY < height/4+70 && mousePressed)
  {
    if (mouseX >= 676)
      _lp = 676;
    else if (mouseX < 24)
      _lp = 24;
    else
      _lp = mouseX;
    strokeWeight(2);
    fill(fg);
    rect(_lp, height/4-10, 100, 80, 4);
    fill(bg);
    text("LPF", _lp + 11, height/4+48);
  } else {
    strokeWeight(1);
    fill(bg);
    rect(_lp, height/4-10, 100, 80, 4);
    fill(fg);
    text("LPF", _lp + 11, height/4+48);
  }
  lpf[a] = _lpFreq;

  window(0, height/5+10, width-10, height/2);
  noFill();
  strokeWeight(2);
  rect(25, height/5+85 + height/4+20, width - 50, 20, 5);
  _hpFreq = map(_hp, 676, 24, 8000, 50);
  if (mouseX >= 0 && mouseX < width && mouseY >  height/5+85 + height/4-10 && mouseY <  height/5+85 + height/4+70 && mousePressed)
  {
    if (mouseX >= 676)
      _hp = 676;
    else if (mouseX < 24)
      _hp = 24;
    else
      _hp = mouseX;
    strokeWeight(2);
    fill(fg);
    rect(_hp, height/5+85 + height/4-10, 100, 80, 4);
    fill(bg);
    text("HPF", _hp+6, height/5+85 + height/4+48);
  } else {
    strokeWeight(1);
    fill(bg);
    rect(_hp, height/5+85 + height/4-10, 100, 80, 4);
    fill(fg);
    text("HPF", _hp+6, height/5+85 + height/4+48);
  }

  hpf[a] = _hpFreq;
  println("LP: " + lpf[a]);
  println("HP: " + hpf[a]);
}

void displayReverb() {
  title = "Main Reverb";
  helper = "Active Time-Based Effects: ";
}

void displayDelay() {
  title = "Main Reverb";
  helper = "Active Time-Based Effects: ";
  textSize(32);
  window(0, 15, width-10, height/2);
  noFill();
  strokeWeight(2);
  rect(25, height/4+20, width - 50, 20, 5);
  _delayTime = map(_dT, 24, 676, 0, 24);
  if (mouseX >= 0 && mouseX < width && mouseY > height/4-10 && mouseY < height/4+70 && mousePressed)
  {
    if (mouseX >= 676)
      _dT = 676;
    else if (mouseX < 24)
      _dT = 24;
    else
      _dT = mouseX;
    strokeWeight(2);
    fill(fg);
    rect(_dT, height/4-10, 100, 80, 4);
    fill(bg);
    text("Time", _dT + 11, height/4+41);
  } else {
    strokeWeight(1);
    fill(bg);
    rect(_dT, height/4-10, 100, 80, 4);
    fill(fg);
    text("Time", _dT + 11, height/4+41);
  }
  window(0, height/5+10, width-10, height/2);
  noFill();
  strokeWeight(2);
  rect(25, height/5+85 + height/4+20, width - 50, 20, 5);
  _delayFeedback = map(_dFb, 24, 646, 0, 24);
  textSize(18);
  if (mouseX >= 0 && mouseX < width && mouseY >  height/5+85 + height/4-10 && mouseY <  height/5+85 + height/4+70 && mousePressed)
  {
    if (mouseX >= 676)
      _dFb = 676;
    else if (mouseX < 24)
      _dFb = 24;
    else
      _dFb = mouseX;
    strokeWeight(2);
    fill(fg);
    rect(_dFb, height/5+85 + height/4-10, 100, 80, 4);
    fill(bg);
    text("Feedback", _dFb+10, height/5+75 + height/4+48);  
  } else {
    strokeWeight(1);
    fill(bg);
    rect(_dFb, height/5+85 + height/4-10, 100, 80, 4);
    fill(fg);
    text("Feedback", _dFb+10, height/5+75 + height/4+48);
  }
  println("Feedback: " + _delayFeedback);
  println("Time: " + _delayTime);
}
