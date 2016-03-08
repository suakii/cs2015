color c;
float xpos;
float ypos;
float xspeed;

void setup() {
  size(200,200);
  c = color(255);
  xpos = width/2;
  ypos = height/2;
  xspeed = 1;
}

void draw() {
  background(0);
  display();
  drive();
}

void display() {
  rectMode(CENTER);
  fill(c);
  rect(xpos, ypos, 20,10);
}

void drive() {
  xpos =  xpos + xspeed;
  if (xpos > width)
    xpos = 0;
}