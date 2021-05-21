import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class FinalProject_Toul_01 extends PApplet {

//<>// //<>//


//placeholders for arduino data;
boolean _adsrBool;
boolean[] revdelStatus = {false, false}, lines = {false, false, false, false};
float[]_freq = {150f, 150f, 150f, 150f}, lpf = {0f, 0f, 0f, 0f}, hpf = {0f, 0f, 0f, 0f}, _amp = {0f, 0f, 0f, 0f}, _pan = {0.5f, 0.5f, 0.5f, 0.5f};
float _a = 0, _d = 0, _s = 0, _r = 0, _delayTime = 0, _delayFeedback = 0, _reverbRoom = 0, _reverbDamp = 0, _reverbWet = 0, _oct = 3, _note, _pitch = 0, lpSlider = 676, hpSlider = 24, reverbRoomSizeSlider = 24, reverbDampSlider = 24, reverbWetSlider = 24, delayTimeSlider = 24, delayFeedbackSlider = 24, _lpFreq, _hpFreq;
final byte NUMBER_OF_AMPS = 4;
final String[][] freqLabel = {{"Off"}, {"C-2", "C#-2/Db-2", "D-2", "D#-2/Eb-2", "E-2", "F-2", "F#-2/Gb-2", "G-2", "G#-2/Ab-2", "A-2", "A#-2/Bb-2", "B-2"}, {"C-1", "C#-1/Db-1", "D-1", "D#-1/Eb-1", "E-1", "F-1", "F#-1/Gb-1", "G-1", "G#-1/Ab-1", "A-1", "A#-1/Bb-1", "B-1"}, {"C0", "C#0/Db0", "D0", "D#0/Eb0", "E0", "F0", "F#0/Gb0", "G0", "G#0/Ab0", "A0", "A#0/Bb0", "B0"}, {"C1", "C#1/Db1", "D1", "D#1/Eb1", "E1", "F1", "F#1/Gb1", "G1", "G#1/Ab1", "A1", "A#1/Bb1", "B1"}, {"C2", "C#2/Db2", "D2", "D#2/Eb2", "E2", "F2", "F#2/Gb2", "G2", "G#2/Ab2", "A2", "A#2/Bb2", "B2"}, {"C3", "C#3/Db3", "D3", "D#3/Eb3", "E3", "F3", "F#3/Gb3", "G3", "G#3/Ab3", "A3", "A#3/Bb3", "B3"}, {"C4", "C#4/Db4", "D4", "D#4/Eb", "4 E4", "F4", "F#4/Gb4", "G4", "G#4/Ab4", "A4", "A#4/Bb4", "B4"}, {"C5", "C#5/Db5", "D5", "D#5/Eb5", "E5", "F5", "F#5/Gb5", "G5", "G#5/Ab5", "A5", "A#5/Bb5", "B5"}, {"C6", "C#6/Db6", "D6", "D#6/Eb6", "E6", "F6", "F#6/Gb6", "G6", "G#6/Ab6", "A6", "A#6/Bb6", "B6"}, {"C7", "C#7/Db7", "D7", "D#7/Eb7", "E7", "F7", "F#7/Gb7", "G7", "G#7/Ab7", "A7", "A#7/Bb7", "B7"}, {"C8", "C#8/Db8", "D8", "D#8/Eb8", "E8", "F8", "F#8/Gb8", "G8", "G#8/Ab8", "A8", "A#8/Bb8", "B8"}};
final float[][] freqNumber = {{0}, {4.08f, 4.33f, 4.58f, 4.86f, 5.15f, 5.45f, 5.78f, 6.12f, 6.48f, 6.875f, 7.283f, 7.71f}, {8.17f, 8.66f, 9.17f, 9.72f, 10.30086f, 10.91f, 11.56f, 12.24f, 12.978f, 13.75f, 14.56762f, 15.43f}, {16.35f, 17.32f, 18.35f, 19.45f, 20.6f, 21.83f, 23.12f, 24.5f, 25.96f, 27.5f, 29.14f, 30.87f}, {32.7f, 34.65f, 36.71f, 38.89f, 41.2f, 43.65f, 46.25f, 49, 51.91f, 55, 58.27f, 61.74f}, {65.41f, 69.3f, 73.42f, 77.78f, 82.41f, 87.31f, 92.5f, 98, 103.83f, 110, 116.54f, 123.47f}, {130.81f, 138.59f, 146.83f, 155.56f, 164.81f, 174.61f, 185, 196, 207.65f, 220, 233.08f, 246.94f}, {261.63f, 277.18f, 293.66f, 311.13f, 329.63f, 349.23f, 369.99f, 392, 415.3f, 440, 466.16f, 493.88f}, {523.25f, 554.37f, 587.33f, 622.25f, 659.25f, 698.46f, 739.99f, 783.99f, 830.61f, 880, 932.33f, 987.77f}, {1046.5f, 1108.73f, 1174.66f, 1244.51f, 1318.51f, 1396.91f, 1479.98f, 1567.98f, 1661.22f, 1760, 1864.66f, 1975.53f}, {2093, 2217.46f, 2349.32f, 2489.02f, 2637.02f, 2793.83f, 2959.96f, 3135.96f, 3322.44f, 3520, 3729.31f, 3951.07f}, {4186.01f, 4434.92f, 4698.63f, 4978.03f, 5274.04f, 5587.65f, 5919.91f, 6271.93f, 6644.88f, 7040, 7458.62f, 7902.13f}};
byte[] mixer = {0, 1, 2, 3};
LineMixer one, two, three, four;

byte screen = 0, selectedLine = 0;
int mouseUp = 0;
int [] lastMouseReleased = {0, 0, 0, 0};
String title, helper;
int bg = (0xffCCCCCC), fg = (0xff111111); 

public void setup() {
  
  one = new LineMixer(0, new SinOsc(this), new TriOsc(this), new SqrOsc(this), new SawOsc(this), new WhiteNoise(this), new PinkNoise(this), new BrownNoise(this), new LowPass(this), new HighPass(this), new Env(this), new Delay(this), new Reverb(this));
  one.toggleSin();
  one.amp = 0.1f;
  one.setFreq(getFreq(0, 1));
  one.toggleTri();
  one.a = 1;
  one.d = 1;
  one.s = 1;
  one.r = 1;
  one.adsr();
  one.play();
  one.filters();

  two = new LineMixer(1, new SinOsc(this), new TriOsc(this), new SqrOsc(this), new SawOsc(this), new WhiteNoise(this), new PinkNoise(this), new BrownNoise(this), new LowPass(this), new HighPass(this), new Env(this), new Delay(this), new Reverb(this));
  three = new LineMixer(2, new SinOsc(this), new TriOsc(this), new SqrOsc(this), new SawOsc(this), new WhiteNoise(this), new PinkNoise(this), new BrownNoise(this), new LowPass(this), new HighPass(this), new Env(this), new Delay(this), new Reverb(this));
  four = new LineMixer(3, new SinOsc(this), new TriOsc(this), new SqrOsc(this), new SawOsc(this), new WhiteNoise(this), new PinkNoise(this), new BrownNoise(this), new LowPass(this), new HighPass(this), new Env(this), new Delay(this), new Reverb(this));
}      
public float getFreq(int note, int oct) {
  if (note > 12)
    return freqNumber[oct+4][note-13];
  else
    return freqNumber[oct+3][note];
}
public String getNote(int note, int oct) {
  if (note > 12)
    return freqLabel[oct+4][note-13];
  else
    return freqLabel[oct+3][note];
}
public void draw() {
  display(screen);
}

public void keyPressed() {
  if (key == '+')
    screen++;
  if (key == '-')
    screen--;
  if (key == 'A' || key == 'a')
  {
    _note = getFreq(0, PApplet.parseInt(_oct));
    one.setFreq(_note);
    one.play();
  }
  if (key == 'Z' || key == 'z')
  {
    _note = getFreq(13, PApplet.parseInt(_oct));
    one.setFreq(_note);
    one.play();
  }
  if (key == 'S' || key == 's')
  {
    one.toggleAdsr();
    println("toggled");
  }
}

public void mouseReleased() {
  switch (mouseUp) {
  case 0:
    break;
  case 1:
    if (_oct != 7)
      _oct++;
    break;
  case 2:
    if (_oct != -2)
      _oct--;
    break;
  case 3:
    _pitch = 0;
    break;
  case 4:
    if (selectedLine == 0)
      one.toggleSin();
    else if (selectedLine == 1)
      two.toggleSin();
    else if (selectedLine == 2)
      three.toggleSin();
    else if (selectedLine == 3)
      four.toggleSin();
    break;
  case 5:
    if (selectedLine == 0)
      one.toggleTri();
    else if (selectedLine == 1)
      two.toggleTri();
    else if (selectedLine == 2)
      three.toggleTri();
    else if (selectedLine == 3)
      four.toggleTri();
    break;
  case 6:
    if (selectedLine == 0)
      one.toggleSqr();
    else if (selectedLine == 1)
      two.toggleSqr();
    else if (selectedLine == 2)
      three.toggleSqr();
    else if (selectedLine == 3)
      four.toggleSqr();
    break;
  case 7:
    if (selectedLine == 0)
      one.toggleSaw();
    else if (selectedLine == 1)
      two.toggleSaw();
    else if (selectedLine == 2)
      three.toggleSaw();
    else if (selectedLine == 3)
      four.toggleSaw();
    break;
  case 8:
    if (selectedLine == 0)
      one.toggleWhite();
    else if (selectedLine == 1)
      two.toggleWhite();
    else if (selectedLine == 2)
      three.toggleWhite();
    else if (selectedLine == 3)
      four.toggleWhite();
    break;
  case 9:
    if (selectedLine == 0)
      one.togglePink();
    else if (selectedLine == 1)
      two.togglePink();
    else if (selectedLine == 2)
      three.togglePink();
    else if (selectedLine == 3)
      four.togglePink();
    break;
  case 10:
    if (selectedLine == 0)
      one.toggleBrown();
    else if (selectedLine == 1)
      two.toggleBrown();
    else if (selectedLine == 2)
      three.toggleBrown();
    else if (selectedLine == 3)
      four.toggleBrown();
    break;
  }
  mouseUp = 0;
}
public void textBanner (byte screen) {
  switch (screen) {
  case 0:
    title = "Main Menu";
    helper = "Active Oscillators: ";
    int i;
    for (i = 0; i < one.outputs.length; i++) {
      lines[0] = false;
      if (one.outputs[i] == true) {
        lines[0] = true;
        break;
      }
    }
    for (i = 0; i < two.outputs.length; i++) {
      lines[1] = false;
      if (two.outputs[i] == true) {
        lines[1] = true;
        break;
      }
    }
    for (i = 0; i < three.outputs.length; i++) {
      lines[2] = false;
      if (three.outputs[i] == true) {
        lines[2] = true;
        break;
      }
    }
    for (i = 0; i < four.outputs.length; i++) {
      lines[3] = false;
      if (four.outputs[i] == true) {
        lines[3] = true;
        break;
      }
    }
    for (i = 0; i < lines.length; i++)
      if (lines[i] == true)
        helper += "Line " + lines[i]+1 + ", ";
    if (helper == "Active Oscillators: ")
      helper = "No Active Oscillators";
    else
      helper = helper.substring(0, helper.length() - 2);
    break;
  case 1:
    break;
  case 2:
    break;
  case 3:
    break;
  case 4:
  case 5:
    helper = "Active Time-Based Effects: ";
    if (_reverbWet != 0)
      revdelStatus[0] = true;
    else
      revdelStatus[0] = false;
    if (_delayFeedback != 0)
      revdelStatus[1] = true;
    else
      revdelStatus[1] = false;
    if (revdelStatus[0])
      helper += "Reverb, ";
    if (revdelStatus[1])
      helper += "Delay, ";
    if (helper == "Active Time-Based Effects: ")
      helper = "No Active Time-Based Effects";
    else
      helper = helper.substring(0, helper.length() - 2);
    break;
  }
  text(helper, width/2, 8 + height - 35 + 35/2);
}
public void display(byte screen) {
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
public void displayPf(byte a) {
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

public void displayReverb() {
  title = "Main Reverb";
  textSize(32);
  window(0, -2, width-10, height/2 - 20);
  rect(25, height/4-23, width - 50, 20, 5);
  _reverbRoom = map(reverbRoomSizeSlider, 24, 676, 0, 1.0f);
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
  _reverbDamp = map(reverbDampSlider, 24, 676, 0, 1.0f);
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
  _reverbWet = map(reverbWetSlider, 24, 676, 0, 1.0f);
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

public void displayDelay() {
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
    public void displayFreq(){
    title = "Frequency";
    window(245, 0, 300, height);
    window(0, 0, width/2, height);
    strokeWeight(2);
    rect(15, height/2-10, width/2 - 20, 15);
    if (mouseX >= 5 && mouseX <= width/2 + 5 
      && mouseY >= 35 && mouseY <= height +38-89 && mousePressed)
    {    
      strokeWeight(0.5f);
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
public void window(float x, float y, float w, float h) {
  x += 5;
  y += 22;
  w -= 10;
  h -= 89;
  translate(x, y);
  noFill();
  strokeWeight(1);
  stroke(fg);
  rect(x, y, w, h, 20);
  translate(-x, -y);
}

public void button(float x, float y, String label, int func) {
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
class LineMixer {
  boolean muted, adsrBool = true;
  float freq, amp, savedAmp, pan, a, d, s, r, delayTime, delayFeedback, reverbRoom, reverbDamp, reverbWet;
  boolean [] outputs = {false, false, false, false, false, false, false}; //0 = sine, 1 = tri, 2 = sqr, 3 = saw, 4 = white, 5 = pink, 6 = brown;
  int numberOfActiveOutputs = 0, input;
  final SinOsc sin;
  final TriOsc tri;
  final SqrOsc sqr;
  final SawOsc saw;
  final WhiteNoise white;
  final PinkNoise pink;
  final BrownNoise brown;
  final LowPass lp;
  final HighPass hp;
  final Env adsr;
  final Delay delay;
  final Reverb reverb;
  LineMixer(int _input, SinOsc _sin, TriOsc _tri, SqrOsc _sqr, SawOsc _saw, WhiteNoise _white, PinkNoise _pink, BrownNoise _brown, LowPass _lp, HighPass _hp, Env _adsr, Delay _delay, Reverb _reverb) {
    sin = _sin;
    tri = _tri;
    sqr = _sqr;
    saw = _saw;
    white = _white;
    pink = _pink;
    brown = _brown;
    lp = _lp;
    hp = _hp;
    adsr = _adsr;
    delay = _delay;
    reverb = _reverb;
    input = _input;
    pan = _pan[input];
    freq = _freq[input];
    sin.amp(0);
    tri.amp(0);
    sqr.amp(0);
    saw.amp(0);
    white.amp(0);
    pink.amp(0);
    brown.amp(0);
    this.sin.play();
    tri.play();
    sqr.play();
    saw.play();
    white.play();
    pink.play();
    brown.play();
    delay.process(sin, _delayFeedback, _delayTime);
    delay.process(tri, _delayFeedback, _delayTime);
    delay.process(sqr, _delayFeedback, _delayTime);
    delay.process(saw, _delayFeedback, _delayTime);
  reverb.room(_reverbRoom);
  reverb.damp(_reverbDamp);
  reverb.wet(_reverbWet);
  reverb.process(sin);
  reverb.process(tri);
  reverb.process(sqr);
  reverb.process(saw);
    amp = _amp[input];
    a = _a;
    d = _d;
    s = _s;
    r = _r;
  }
  public void play() {
    //filters();
    freq();
    amp();
    pan();
    if (adsrBool)
      adsr();
    lp.process(sin, lpf[input]);
    lp.process(tri, lpf[input]);
    lp.process(sqr, lpf[input]);
    lp.process(saw, lpf[input]);
    hp.process(sin, hpf[input]);
    hp.process(tri, hpf[input]);
    hp.process(sqr, hpf[input]);
    hp.process(saw, hpf[input]);
    delay.process(sin, _delayFeedback, _delayTime);
    delay.process(tri, _delayFeedback, _delayTime);
    delay.process(sqr, _delayFeedback, _delayTime);
    delay.process(saw, _delayFeedback, _delayTime);
  }
  public void play(float _userFreq) {
    //filters();
    freq(_userFreq);
    amp();
    pan();
    if (adsrBool)
      adsr();
    lp.process(sin, lpf[input]);
    lp.process(tri, lpf[input]);
    lp.process(sqr, lpf[input]);
    lp.process(saw, lpf[input]);
    hp.process(sin, hpf[input]);
    hp.process(tri, hpf[input]);
    hp.process(sqr, hpf[input]);
    hp.process(saw, hpf[input]);
    delay.set(_delayTime, _delayFeedback);
    reverb.set(_reverbRoom, _reverbDamp, _reverbWet);
  }
  public void pan() {
    sin.pan(pan);
    tri.pan(pan);
    sqr.pan(pan);
    saw.pan(pan);
  }
  public void adsr() {
    adsr.play(sin, a, d, s, r);
    adsr.play(tri, a, d, s, r);
    adsr.play(sqr, a, d, s, r);
    adsr.play(saw, a, d, s, r);
    adsr.play(white, a, d, s, r);
    adsr.play(pink, a, d, s, r);
    adsr.play(brown, a, d, s, r);
  }
  public void toggleAdsr() {
    adsrBool = !adsrBool;
  }
  public void amp() {
    if (outputs[0])
      sin.amp(amp);
    else
      sin.amp(0);
    if (outputs[1])
      tri.amp(amp);
    else
      tri.amp(0);
    if (outputs[2])
      sqr.amp(amp);
    else
      sqr.amp(0);
    if (outputs[3])
      saw.amp(amp);
    else
      saw.amp(0);
    if (outputs[4])
      white.amp(amp);
    else
      white.amp(0);
    if (outputs[5])
      pink.amp(amp);
    else
      pink.amp(0);
    if (outputs[6])
      brown.amp(amp);
    else
      brown.amp(0);
  }
  public void toggleSin() {
    outputs[0] = !outputs[0];
  }
  public void toggleTri() {
    outputs[1] = !outputs[1];
  }
  public void toggleSqr() {
    outputs[2] = !outputs[2];
  }
  public void toggleSaw() {
    outputs[3] = !outputs[3];
  }  
  public void toggleWhite() {
    outputs[4] = !outputs[4];
  }
  public void togglePink() {
    outputs[5] = !outputs[5];
  }
  public void toggleBrown() {
    outputs[6] = !outputs[6];
  }  
  public void freq() {
    sin.freq(freq);
    tri.freq(freq);
    sqr.freq(freq);
    saw.freq(freq);
  }
  public void freq(float _userFreq) {
    freq = _userFreq;
    sin.freq(freq);
    tri.freq(freq);
    sqr.freq(freq);
    saw.freq(freq);
  }
  public void filters() {
  }
  public void setFreq(float _userFreq) {
    freq = _userFreq + _pitch;
  }
  public void setLpf(float a) {
    lp.freq(a);
  }
  public void setHpf(float a) {
    hp.freq(a);
  }
  public void mute() {
    savedAmp = amp;
    amp = 0;
    muted = true;
  }
  public void unmute() {
    amp = savedAmp;
    muted = false;
  }
  public boolean isMuted() {
    return muted;
  }
  public void setVolume(float _userAmp) {
    numberOfActiveOutputs = 0;
    for (int i = 0; i < outputs.length; i++)
      if (outputs[i])
        numberOfActiveOutputs++;
    if (_userAmp/(NUMBER_OF_AMPS + numberOfActiveOutputs) <= 1)
      amp = _userAmp/(NUMBER_OF_AMPS + numberOfActiveOutputs);
  }
  public void volumeUp() {
    numberOfActiveOutputs = 0;
    for (int i = 0; i < outputs.length; i++)
      if (outputs[i])
        if (amp + 1f < amp/(NUMBER_OF_AMPS + numberOfActiveOutputs))
          amp =+ 1f;
        else
          amp = 1/(NUMBER_OF_AMPS + numberOfActiveOutputs);
  }
  public void volumeDown() {
    numberOfActiveOutputs = 0;
    for (int i = 0; i < outputs.length; i++)
      if (outputs[i])
        if (amp - 1f > 0)
          amp =- 1f;
        else
          amp = 0;
  }
  public void setPan(float _userPan) {
    if (_userPan <= 1 || _userPan >= -1)
      pan = _userPan;
  }
  public void panUp() {
    if (pan + 0.1f < 1)
      pan += 0.1f;
  }
  public void panDown() {
    if (pan - 0.1f > -1)
      pan -= 0.1f;
  }
  public String getActiveOuts() {
    String _return = "";  
    for (int i = 0; i < outputs.length; i++)
      if (outputs[i])
        switch (i) {
        case 0:
          _return += "Sine, ";
          break;
        case 1:
          _return += "Triangle, ";
          break;
        case 2:
          _return += "Square, ";
          break;
        case 3:
          _return += "Saw, ";
          break;
        case 4:
          _return += "White, ";
          break;
        case 5:
          _return += "Pink, ";
          break;
        case 6:
          _return += "Brown, ";
          break;
        }
    if (_return != "")
      return _return.substring(0, _return.length() - 2);
    else return "";
  }
}
public void displayOsc (byte line) {
  title = "Line " + selectedLine+1 + " : Oscillators and Noises";
  if (selectedLine == 0)
    if (one.getActiveOuts() != "")
      helper = "Active Outputs: " + one.getActiveOuts();
    else
      helper = "No Active Output";
  else if (selectedLine == 1)
    if (two.getActiveOuts() != "")
      helper = "Active Outputs: " + two.getActiveOuts();
    else
      helper = "No Active Output";
  else if (selectedLine == 2)
    if (three.getActiveOuts() != "")
      helper = "Active Outputs: " + three.getActiveOuts();
    else
      helper = "No Active Output";
  else if (selectedLine == 3)
    if (four.getActiveOuts() != "")
      helper = "Active Outputs: " + four.getActiveOuts();
    else
      helper = "No Active Output";

  textAlign(CENTER);
  textSize(24);
  stroke(0);
  strokeWeight(4);
  if (line == 0) {
    if (mouseX >= 0 && mouseX <= 280 
      && mouseY >= 35 && mouseY <= height/2 && mousePressed)
      mouseUp = 4;
    if (one.outputs[0]) {
      fill(0xff27C5BD);
      rect(0, 35, 280, height/2-35);
      fill(fg);
      text("Sinusoid ~", 140, height/4 + 25);
    } else {
      fill(0xff71bcb9);
      rect(0, 35, 280, height/2-35);
      fill(bg);
      text("Sinusoid ~", 140, height/4 + 25);
    }
    if (mouseX >= 0 && mouseX <= 280 
      && mouseY >= height/2 && mouseY <= height/2 + height/2-35 && mousePressed)
      mouseUp = 5;
    if (one.outputs[1]) {
      fill(0xff61C442);
      rect(0, height/2, 280, height/2-35);
      fill(fg);
      text("Triangle ∆", 140, height - 130);
    } else {
      fill(0xff91c381);
      rect(0, height/2, 280, height/2-35);
      fill(bg);
      text("Triangle ∆", 140, height - 130);
    }
    if (mouseX >= 280 && mouseX <= 560 
      && mouseY >= 35 && mouseY <= height/2 && mousePressed)
      mouseUp = 6;
    if (one.outputs[2]) {
      fill(0xff6F4BCF);    
      rect(280, 35, 280, height/2-35);
      fill(fg);
      text("Square □", 420, height/4 + 25);
    } else {
      fill(0xffaa9cd2);
      rect(280, 35, 280, height/2-35);
      fill(bg);
      text("Square □", 420, height/4 + 25);
    }
    if (mouseX >= 280 && mouseX <= 560 
      && mouseY >= height/2 && mouseY <= height/2 + height/2-35 && mousePressed)
      mouseUp = 7;
    if (one.outputs[3]) {
      fill(0xffFE7474);
      rect(280, height/2, 280, height/2-35);
      fill(fg);
      text("Sawtooth N", 420, height - 130);
      fill(0xffFE7474);
      noStroke();
      rect(482.04f, height/2+10, 280 - 20, height/2-35 - 10);
      stroke(0);
    } else {
      fill(0xfffdb1b1);
      rect(280, height/2, 280, height/2-35);
      fill(bg);
      text("Sawtooth N", 420, height - 130);
      fill(0xfffdb1b1);
      noStroke();
      rect(482.04f, height/2+10, 280 - 20, height/2-35 - 10);
      stroke(0);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280 + 35/3
      && mouseY >= 35 && mouseY <= 35 + height/3 - 35/3 && mousePressed)
      mouseUp = 8; 
    if (one.outputs[4]) {
      fill(0xffe7e7e7);
      rect(560, 35, 280 + 35/3, height/3 - 35/3);
      fill(fg);
      text("White ▓", 677 + 35/5, height/4 - 7);
    } else {
      fill(0xff9b9b9b);
      rect(560, 35, 280 + 35/3, height/3 - 35/3);
      fill(bg);
      text("White ▓", 677 + 35/5, height/4 - 7);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280
      && mouseY >= height/3  + 35/3 && mouseY <= height/3  + 35/3 + height/3 - 35/3 && mousePressed)
      mouseUp = 9; 
    if (one.outputs[5]) {
      fill(0xffFE02E4);
      rect(560, height/3  + 35/3, 280, height/3 - 35/3);
      fill(fg);
      text("Pink ░", 677 + 35/5, height/4 +130);
    } else {
      fill(0xfffb9ff2);
      rect(560, height/3  + 35/3, 280, height/3 - 35/3);
      fill(bg);
      text("Pink ░", 677 + 35/5, height/4 +130);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280
      && mouseY >= height/3 + height/3 - 35/3 && mouseY <= height/3 + height/3 - 35/3 + height/3 - 35/3&& mousePressed)
      mouseUp = 10; 
    if (one.outputs[6]) {
      fill(0xffcd0044);
      rect(560, height/3 + height/3 - 35/3, 280, height/3 - 35/3);
      fill(fg);
      text("Brownian ▒", 677 + 35/5, height/4 + 265);
    } else {
      fill(0xffce8da3);
      rect(560, height/3 + height/3 - 35/3, 280, height/3 - 35/3);
      fill(bg);
      text("Brownian ▒", 677 + 35/5, height/4 + 265);
    }
  } else if (line == 1) {
    if (mouseX >= 0 && mouseX <= 280 
      && mouseY >= 35 && mouseY <= height/2 && mousePressed)
      mouseUp = 4;
    if (two.outputs[0]) {
      fill(0xff27C5BD);
      rect(0, 35, 280, height/2-35);
      fill(fg);
      text("Sinusoid ~", 140, height/4 + 25);
    } else {
      fill(0xff71bcb9);
      rect(0, 35, 280, height/2-35);
      fill(bg);
      text("Sinusoid ~", 140, height/4 + 25);
    }
    if (mouseX >= 0 && mouseX <= 280 
      && mouseY >= height/2 && mouseY <= height/2 + height/2-35 && mousePressed)
      mouseUp = 5;
    if (two.outputs[1]) {
      fill(0xff61C442);
      rect(0, height/2, 280, height/2-35);
      fill(fg);
      text("Triangle ∆", 140, height - 130);
    } else {
      fill(0xff91c381);
      rect(0, height/2, 280, height/2-35);
      fill(bg);
      text("Triangle ∆", 140, height - 130);
    }
    if (mouseX >= 280 && mouseX <= 560 
      && mouseY >= 35 && mouseY <= height/2 && mousePressed)
      mouseUp = 6;
    if (two.outputs[2]) {
      fill(0xff6F4BCF);    
      rect(280, 35, 280, height/2-35);
      fill(fg);
      text("Square □", 420, height/4 + 25);
    } else {
      fill(0xffaa9cd2);
      rect(280, 35, 280, height/2-35);
      fill(bg);
      text("Square □", 420, height/4 + 25);
    }
    if (mouseX >= 280 && mouseX <= 560 
      && mouseY >= height/2 && mouseY <= height/2 + height/2-35 && mousePressed)
      mouseUp = 7;
    if (two.outputs[3]) {
      fill(0xffFE7474);
      rect(280, height/2, 280, height/2-35);
      fill(fg);
      text("Sawtooth N", 420, height - 130);
      fill(0xffFE7474);
      noStroke();
      rect(482.04f, height/2+10, 280 - 20, height/2-35 - 10);
      stroke(0);
    } else {
      fill(0xfffdb1b1);
      rect(280, height/2, 280, height/2-35);
      fill(bg);
      text("Sawtooth N", 420, height - 130);
      fill(0xfffdb1b1);
      noStroke();
      rect(482.04f, height/2+10, 280 - 20, height/2-35 - 10);
      stroke(0);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280 + 35/3
      && mouseY >= 35 && mouseY <= 35 + height/3 - 35/3 && mousePressed)
      mouseUp = 8; 
    if (two.outputs[4]) {
      fill(0xffe7e7e7);
      rect(560, 35, 280 + 35/3, height/3 - 35/3);
      fill(fg);
      text("White ▓", 677 + 35/5, height/4 - 7);
    } else {
      fill(0xff9b9b9b);
      rect(560, 35, 280 + 35/3, height/3 - 35/3);
      fill(bg);
      text("White ▓", 677 + 35/5, height/4 - 7);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280
      && mouseY >= height/3  + 35/3 && mouseY <= height/3  + 35/3 + height/3 - 35/3 && mousePressed)
      mouseUp = 9; 
    if (two.outputs[5]) {
      fill(0xffFE02E4);
      rect(560, height/3  + 35/3, 280, height/3 - 35/3);
      fill(fg);
      text("Pink ░", 677 + 35/5, height/4 +130);
    } else {
      fill(0xfffb9ff2);
      rect(560, height/3  + 35/3, 280, height/3 - 35/3);
      fill(bg);
      text("Pink ░", 677 + 35/5, height/4 +130);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280
      && mouseY >= height/3 + height/3 - 35/3 && mouseY <= height/3 + height/3 - 35/3 + height/3 - 35/3&& mousePressed)
      mouseUp = 10; 
    if (two.outputs[6]) {
      fill(0xffcd0044);
      rect(560, height/3 + height/3 - 35/3, 280, height/3 - 35/3);
      fill(fg);
      text("Brownian ▒", 677 + 35/5, height/4 + 265);
    } else {
      fill(0xffce8da3);
      rect(560, height/3 + height/3 - 35/3, 280, height/3 - 35/3);
      fill(bg);
      text("Brownian ▒", 677 + 35/5, height/4 + 265);
    }
  } else if (line == 2) {
    if (mouseX >= 0 && mouseX <= 280 
      && mouseY >= 35 && mouseY <= height/2 && mousePressed)
      mouseUp = 4;
    if (three.outputs[0]) {
      fill(0xff27C5BD);
      rect(0, 35, 280, height/2-35);
      fill(fg);
      text("Sinusoid ~", 140, height/4 + 25);
    } else {
      fill(0xff71bcb9);
      rect(0, 35, 280, height/2-35);
      fill(bg);
      text("Sinusoid ~", 140, height/4 + 25);
    }
    if (mouseX >= 0 && mouseX <= 280 
      && mouseY >= height/2 && mouseY <= height/2 + height/2-35 && mousePressed)
      mouseUp = 5;
    if (three.outputs[1]) {
      fill(0xff61C442);
      rect(0, height/2, 280, height/2-35);
      fill(fg);
      text("Triangle ∆", 140, height - 130);
    } else {
      fill(0xff91c381);
      rect(0, height/2, 280, height/2-35);
      fill(bg);
      text("Triangle ∆", 140, height - 130);
    }
    if (mouseX >= 280 && mouseX <= 560 
      && mouseY >= 35 && mouseY <= height/2 && mousePressed)
      mouseUp = 6;
    if (three.outputs[2]) {
      fill(0xff6F4BCF);    
      rect(280, 35, 280, height/2-35);
      fill(fg);
      text("Square □", 420, height/4 + 25);
    } else {
      fill(0xffaa9cd2);
      rect(280, 35, 280, height/2-35);
      fill(bg);
      text("Square □", 420, height/4 + 25);
    }
    if (mouseX >= 280 && mouseX <= 560 
      && mouseY >= height/2 && mouseY <= height/2 + height/2-35 && mousePressed)
      mouseUp = 7;
    if (three.outputs[3]) {
      fill(0xffFE7474);
      rect(280, height/2, 280, height/2-35);
      fill(fg);
      text("Sawtooth N", 420, height - 130);
      fill(0xffFE7474);
      noStroke();
      rect(482.04f, height/2+10, 280 - 20, height/2-35 - 10);
      stroke(0);
    } else {
      fill(0xfffdb1b1);
      rect(280, height/2, 280, height/2-35);
      fill(bg);
      text("Sawtooth N", 420, height - 130);
      fill(0xfffdb1b1);
      noStroke();
      rect(482.04f, height/2+10, 280 - 20, height/2-35 - 10);
      stroke(0);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280 + 35/3
      && mouseY >= 35 && mouseY <= 35 + height/3 - 35/3 && mousePressed)
      mouseUp = 8; 
    if (three.outputs[4]) {
      fill(0xffe7e7e7);
      rect(560, 35, 280 + 35/3, height/3 - 35/3);
      fill(fg);
      text("White ▓", 677 + 35/5, height/4 - 7);
    } else {
      fill(0xff9b9b9b);
      rect(560, 35, 280 + 35/3, height/3 - 35/3);
      fill(bg);
      text("White ▓", 677 + 35/5, height/4 - 7);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280
      && mouseY >= height/3  + 35/3 && mouseY <= height/3  + 35/3 + height/3 - 35/3 && mousePressed)
      mouseUp = 9; 
    if (three.outputs[5]) {
      fill(0xffFE02E4);
      rect(560, height/3  + 35/3, 280, height/3 - 35/3);
      fill(fg);
      text("Pink ░", 677 + 35/5, height/4 +130);
    } else {
      fill(0xfffb9ff2);
      rect(560, height/3  + 35/3, 280, height/3 - 35/3);
      fill(bg);
      text("Pink ░", 677 + 35/5, height/4 +130);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280
      && mouseY >= height/3 + height/3 - 35/3 && mouseY <= height/3 + height/3 - 35/3 + height/3 - 35/3&& mousePressed)
      mouseUp = 10; 
    if (three.outputs[6]) {
      fill(0xffcd0044);
      rect(560, height/3 + height/3 - 35/3, 280, height/3 - 35/3);
      fill(fg);
      text("Brownian ▒", 677 + 35/5, height/4 + 265);
    } else {
      fill(0xffce8da3);
      rect(560, height/3 + height/3 - 35/3, 280, height/3 - 35/3);
      fill(bg);
      text("Brownian ▒", 677 + 35/5, height/4 + 265);
    }
  } else if (line == 3) {
    if (mouseX >= 0 && mouseX <= 280 
      && mouseY >= 35 && mouseY <= height/2 && mousePressed)
      mouseUp = 4;
    if (four.outputs[0]) {
      fill(0xff27C5BD);
      rect(0, 35, 280, height/2-35);
      fill(fg);
      text("Sinusoid ~", 140, height/4 + 25);
    } else {
      fill(0xff71bcb9);
      rect(0, 35, 280, height/2-35);
      fill(bg);
      text("Sinusoid ~", 140, height/4 + 25);
    }
    if (mouseX >= 0 && mouseX <= 280 
      && mouseY >= height/2 && mouseY <= height/2 + height/2-35 && mousePressed)
      mouseUp = 5;
    if (four.outputs[1]) {
      fill(0xff61C442);
      rect(0, height/2, 280, height/2-35);
      fill(fg);
      text("Triangular ∆", 140, height - 130);
    } else {
      fill(0xff91c381);
      rect(0, height/2, 280, height/2-35);
      fill(bg);
      text("Triangular ∆", 140, height - 130);
    }
    if (mouseX >= 280 && mouseX <= 560 
      && mouseY >= 35 && mouseY <= height/2 && mousePressed)
      mouseUp = 6;
    if (four.outputs[2]) {
      fill(0xff6F4BCF);    
      rect(280, 35, 280, height/2-35);
      fill(fg);
      text("Square □", 420, height/4 + 25);
    } else {
      fill(0xffaa9cd2);
      rect(280, 35, 280, height/2-35);
      fill(bg);
      text("Square □", 420, height/4 + 25);
    }
    if (mouseX >= 280 && mouseX <= 560 
      && mouseY >= height/2 && mouseY <= height/2 + height/2-35 && mousePressed)
      mouseUp = 7;
    if (four.outputs[3]) {
      fill(0xffFE7474);
      rect(280, height/2, 280, height/2-35);
      fill(fg);
      text("Sawtooth N", 420, height - 130);
      fill(0xffFE7474);
      noStroke();
      rect(482.04f, height/2+10, 280 - 20, height/2-35 - 10);
      stroke(0);
    } else {
      fill(0xfffdb1b1);
      rect(280, height/2, 280, height/2-35);
      fill(bg);
      text("Sawtooth N", 420, height - 130);
      fill(0xfffdb1b1);
      noStroke();
      rect(482.04f, height/2+10, 280 - 20, height/2-35 - 10);
      stroke(0);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280 + 35/3
      && mouseY >= 35 && mouseY <= 35 + height/3 - 35/3 && mousePressed)
      mouseUp = 8; 
    if (four.outputs[4]) {
      fill(0xffe7e7e7);
      rect(560, 35, 280 + 35/3, height/3 - 35/3);
      fill(fg);
      text("White ▓", 677 + 35/5, height/4 - 7);
    } else {
      fill(0xff9b9b9b);
      rect(560, 35, 280 + 35/3, height/3 - 35/3);
      fill(bg);
      text("White ▓", 677 + 35/5, height/4 - 7);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280
      && mouseY >= height/3  + 35/3 && mouseY <= height/3  + 35/3 + height/3 - 35/3 && mousePressed)
      mouseUp = 9; 
    if (four.outputs[5]) {
      fill(0xffFE02E4);
      rect(560, height/3  + 35/3, 280, height/3 - 35/3);
      fill(fg);
      text("Pink ░", 677 + 35/5, height/4 +130);
    } else {
      fill(0xfffb9ff2);
      rect(560, height/3  + 35/3, 280, height/3 - 35/3);
      fill(bg);
      text("Pink ░", 677 + 35/5, height/4 +130);
    }
    if (mouseX >= 560 && mouseX <= 560 + 280
      && mouseY >= height/3 + height/3 - 35/3 && mouseY <= height/3 + height/3 - 35/3 + height/3 - 35/3&& mousePressed)
      mouseUp = 10; 
    if (four.outputs[6]) {
      fill(0xffcd0044);
      rect(560, height/3 + height/3 - 35/3, 280, height/3 - 35/3);
      fill(fg);
      text("Brownian ▒", 677 + 35/5, height/4 + 265);
    } else {
      fill(0xffce8da3);
      rect(560, height/3 + height/3 - 35/3, 280, height/3 - 35/3);
      fill(bg);
      text("Brownian ▒", 677 + 35/5, height/4 + 265);
    }
  }
}
  public void settings() {  size(800, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "FinalProject_Toul_01" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
