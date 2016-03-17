
World world;

void setup() {

  size(600, 600);
  world = new World(20);
  smooth();

}

void draw() {
  background(255);
  world.run();
  

}

// We can add a creature manually if we so desire
void mousePressed() {
  world.born(mouseX,mouseY); 
}

void mouseDragged() {
  world.born(mouseX,mouseY); 
}