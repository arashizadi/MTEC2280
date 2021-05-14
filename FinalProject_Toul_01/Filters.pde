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
  //_reverbRoom = 0, _reverbDamp = 0, _reverbWet
  _lpFreq = map(lpSlider, 24, 676, 20, 8000);
  if (mouseX >= 0 && mouseX < width && mouseY > height/4-10 && mouseY < height/4+70 && mousePressed)
  {
    if (mouseX >= 676)
      lpSlider = 676;
    else if (mouseX < 24)
      lpSlider = 24;
    else
      lpSlider = mouseX;
    strokeWeight(2);
    fill(fg);
    rect(lpSlider, height/4-10, 100, 80, 4);
    fill(bg);
    text("LPF", lpSlider + 11, height/4+48);
  } else {
    strokeWeight(1);
    fill(bg);
    rect(lpSlider, height/4-10, 100, 80, 4);
    fill(fg);
    text("LPF", lpSlider + 11, height/4+48);
  }
  lpf[a] = _lpFreq;

  window(0, height/5+10, width-10, height/2);
  noFill();
  strokeWeight(2);
  rect(25, height/5+85 + height/4+20, width - 50, 20, 5);
  _hpFreq = map(hpSlider, 676, 24, 8000, 50);
  if (mouseX >= 0 && mouseX < width && mouseY >  height/5+85 + height/4-10 && mouseY <  height/5+85 + height/4+70 && mousePressed)
  {
    if (mouseX >= 676)
      hpSlider = 676;
    else if (mouseX < 24)
      hpSlider = 24;
    else
      hpSlider = mouseX;
    strokeWeight(2);
    fill(fg);
    rect(hpSlider, height/5+85 + height/4-10, 100, 80, 4);
    fill(bg);
    text("HPF", hpSlider+6, height/5+85 + height/4+48);
  } else {
    strokeWeight(1);
    fill(bg);
    rect(hpSlider, height/5+85 + height/4-10, 100, 80, 4);
    fill(fg);
    text("HPF", hpSlider+6, height/5+85 + height/4+48);
  }

  hpf[a] = _hpFreq;
  println("LP: " + lpf[a]);
  println("HP: " + hpf[a]);
}

void displayReverb() {
  title = "Main Reverb";
  textSize(32);
  window(0, -2, width-10, height/2 - 20);
  rect(25, height/4-23, width - 50, 20, 5);
  _reverbRoom = map(reverbRoomSizeSlider, 24, 676, 0, 1.0);
  if (mouseX >= 0 && mouseX < width && mouseY > height/4-56 && mouseY < height/4+56 && mousePressed)
  {
    if (mouseX >= 676)
      reverbRoomSizeSlider = 676;
    else if (mouseX < 24)
      reverbRoomSizeSlider = 24;
    else
      reverbRoomSizeSlider = mouseX;
    strokeWeight(2);
    fill(fg);
    rect(reverbRoomSizeSlider, height/4-56, 100, 80, 4);
    fill(bg);
    text("Room", reverbRoomSizeSlider+6, 115);
  } else {
    strokeWeight(1);
    fill(bg);
    rect(reverbRoomSizeSlider, height/4-56, 100, 80, 4);
    fill(fg);
    text("Room", reverbRoomSizeSlider+6, 115);
  }
  window(0, 65, width-10, height/2 - 20);
  rect(25, height/2-9, width - 50, 20, 5);
  _reverbDamp = map(reverbDampSlider, 24, 676, 0, 1.0);
  if (mouseX >= 0 && mouseX < width && mouseY > height/2-39 && mouseY < height/2+61 && mousePressed)
  {
    if (mouseX >= 676)
      reverbDampSlider = 676;
    else if (mouseX < 24)
      reverbDampSlider = 24;
    else
      reverbDampSlider = mouseX;
    strokeWeight(2);
    fill(fg);
    rect(reverbDampSlider, height/2-39, 100, 80, 4);
    fill(bg);
    text("Damp", reverbDampSlider+4, height/4 + 130);
  } else {
    strokeWeight(1);
    fill(bg);
    rect(reverbDampSlider, height/2-39, 100, 80, 4);
    fill(fg);
    text("Damp", reverbDampSlider+4, height/4 + 130);
  }
  window(0, 132, width-10, height/2 - 20);
  rect(25, height/2+126, width - 50, 20, 5);
  _reverbWet = map(reverbWetSlider, 24, 676, 0, 1.0);
  if (mouseX >= 0 && mouseX < width && mouseY > height/2+95 && mouseY < height/2+195 && mousePressed)
  {
    if (mouseX >= 676)
      reverbWetSlider = 676;
    else if (mouseX < 24)
      reverbWetSlider = 24;
    else
      reverbWetSlider = mouseX;
    strokeWeight(2);
    fill(fg);
    rect(reverbWetSlider, height/2+95, 100, 80, 4);
    fill(bg);
    text("Wet", reverbWetSlider+22, height/2 + 145);
  } else {
    strokeWeight(1);
    fill(bg);
    rect(reverbWetSlider, height/2+95, 100, 80, 4);
    fill(fg);
    text("Wet", reverbWetSlider+22, height/2 + 145);
  }
  one.reverb.room(_reverbRoom);
  one.reverb.damp(_reverbDamp);
  one.reverb.wet(_reverbWet);
}

void displayDelay() {
  title = "Main Delay";
  textSize(32);
  window(0, 15, width-10, height/2);
  noFill();
  strokeWeight(2);
  rect(25, height/4+20, width - 50, 20, 5);
  _delayTime = map(delayTimeSlider, 24, 676, 0, 24);
  if (mouseX >= 0 && mouseX < width && mouseY > height/4-10 && mouseY < height/4+70 && mousePressed)
  {
    if (mouseX >= 676)
      delayTimeSlider = 676;
    else if (mouseX < 24)
      delayTimeSlider = 24;
    else
      delayTimeSlider = mouseX;
    strokeWeight(2);
    fill(fg);
    rect(delayTimeSlider, height/4-10, 100, 80, 4);
    fill(bg);
    text("Time", delayTimeSlider + 11, height/4+41);
  } else {
    strokeWeight(1);
    fill(bg);
    rect(delayTimeSlider, height/4-10, 100, 80, 4);
    fill(fg);
    text("Time", delayTimeSlider + 11, height/4+41);
  }
  window(0, height/5+10, width-10, height/2);
  noFill();
  strokeWeight(2);
  rect(25, height/5+85 + height/4+20, width - 50, 20, 5);
  _delayFeedback = map(delayFeedbackSlider, 24, 646, 0, 24);
  textSize(18);
  if (mouseX >= 0 && mouseX < width && mouseY >  height/5+85 + height/4-10 && mouseY <  height/5+85 + height/4+70 && mousePressed)
  {
    if (mouseX >= 676)
      delayFeedbackSlider = 676;
    else if (mouseX < 24)
      delayFeedbackSlider = 24;
    else
      delayFeedbackSlider = mouseX;
    strokeWeight(2);
    fill(fg);
    rect(delayFeedbackSlider, height/5+85 + height/4-10, 100, 80, 4);
    fill(bg);
    text("Feedback", delayFeedbackSlider+10, height/5+75 + height/4+48);
  } else {
    strokeWeight(1);
    fill(bg);
    rect(delayFeedbackSlider, height/5+85 + height/4-10, 100, 80, 4);
    fill(fg);
    text("Feedback", delayFeedbackSlider+10, height/5+75 + height/4+48);
  }
  println("Feedback: " + _delayFeedback);
  println("Time: " + _delayTime);
}
