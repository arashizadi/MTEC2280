//A.I
//Move the mousewheel to change the state of LED 
import processing.serial.*;
Serial port;
int assignedTime = 760, currentTime = 0, savedTime = 0;
boolean ledOff;

void setup() {
  size(400, 400);
  port = new Serial(this, Serial.list()[0], 9600);
  textAlign(CENTER);
  textSize(64);
}

void draw() {
  currentTime = millis();
  if (currentTime - savedTime > assignedTime) {
    savedTime = currentTime;
    ledOff = !ledOff;
  }
  if (ledOff || assignedTime >= 1480) {
    ledOff = true;
    port.write(0);    
    fill(70, 0, 0);
  } 
  if (!ledOff || assignedTime <= 40) {
    ledOff = false;
    port.write(1); 
    fill(255, 0, 0);
  }
  stroke(255);
  ellipse(width/2, height/2, width*0.75, height*0.75);
  fill(255);
  if (assignedTime>=1480)
    text("OFF", width/2, height/2);
  else if (assignedTime<=40)
    text("ON", width/2, height/2);
  else
    text(floor(map(assignedTime, 60, 1460, 99.990, 1.102)), width/2, height/2);
}

void mouseWheel(MouseEvent scroll) {
  if (assignedTime <= 20)
    assignedTime = 40;
  else if (assignedTime >= 1500)
    assignedTime = 1480;
  else
    assignedTime += 20 * scroll.getCount();
  println(assignedTime);
}
