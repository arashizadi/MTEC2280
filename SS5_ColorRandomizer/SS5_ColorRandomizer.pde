//ColorRandomizer by A.I.
//Mouse drag to ink, click to reset.

Dot[] dots = new Dot[1500];
Triangle triangle;

void setup() {
  fullScreen();
}

void draw() {
  for (int i = 0; i < dots.length; i++) {
    dots[i] = new Dot();  
    dots[i].display();
  }
  changeColor();
}

void changeColor() {
  if (second() % 10 == 0) {
    stroke(random(255), random(255), random(255));
    triangle = new Triangle();
    triangle.display();
  }
}

void mouseClicked() {
  background(random(80, 150), random(80, 150), random(80, 150));
}

void mouseDragged() {
  strokeWeight(random(10, 40));
  stroke(random(60, 220), random(60, 220), random(60, 220));
  line(mouseX, mouseY, pmouseX, pmouseY);
  strokeWeight(1);
}

class Dot { 
  float x;
  float y;
  Dot() {
    x = random(width);
    y = random(height);
  }
  void display() {
    line(x, y, x+1, y+1);
  }
}

class Triangle { 
  float x1, y1, x2, y2, x3, y3;
  Triangle() {
    x1 = random(width);
    y1 = random(height);
    x2 = random(x1 - 20, x1 + 20);
    y2 = random(y1 - 20, y1 + 20);
    x3 = random(x2 - 20, x2 + 20);
    y3 = random(y2 - 20, y2 + 20);
  }
  void display() {
    fill(random(255), random(255), random(255), random(10));
    triangle(x1, y1, x2, y2, x3, y3);
  }
}
