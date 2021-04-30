void displayPf(byte a) {
  title = "Line " + a+1 + ": Lowpass and Highpass Filter";
  helper = "";

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
    println(_lpFreq);
  } else {
    strokeWeight(1);
    fill(bg);
  }
  rect(_lp, height/4-10, 100, 80, 4);
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
  } else {
    strokeWeight(1);
    fill(bg);
  }
  rect(_hp,  height/5+85 + height/4-10, 100, 80, 4);
  hpf[a] = _hpFreq;
  println(hpf[a]);

}
