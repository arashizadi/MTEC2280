//Sketch #1: Algorithmic Drawing
//Tendency by A.I.
size(500, 500);

for (int i = 0; i < width; i += width/5){
strokeWeight(i/50);
fill(0, 0, 0, 0.6*(i+1));
triangle(30+i, 75+i, 58+i, 20+i, 86+i, 75+i);
square(width-30-i, height-20-i, 55);
}

strokeWeight(5);
stroke(60, 102, 153, 50);
line(width/2, height/10, width/2, height/4);

fill(20, 20, 20);
text("A.I.", 10, height-10);
