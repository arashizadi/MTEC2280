boolean clicked;
  int x = 0, r = 0, g = 0, b = 0;

void setup() {
  size(700, 700);
}
void draw() {
  x = 0;
  background(0);
  
  if(clicked){
  r = int(random(15));
  g = int(random(15));
  b = int(random(15));
  }
  
  while (x < 18 || r < 18 && g < 18 && b < 18)
  {
    if (!clicked)
      fill(x*15, x*15, x*15);
    else
      fill((r*15), (g*15), (b*15));
      
    rect(x*width/17, 0, x*width/17, height);
    
    if (!clicked)
    x++;
    else{
    r++; g++; b++;
    }
  }
}

void mouseClicked() {
clicked = true;
}

void mouseDragged() {
clicked = false;

}
