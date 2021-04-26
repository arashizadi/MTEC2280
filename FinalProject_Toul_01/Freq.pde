    void displayFreq(){
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
  
}
