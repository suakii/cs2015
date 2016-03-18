/*
 * Jonghwa Park
 * suakii@gmail.com
*/
World world;

void setup() {

  size(800, 800);
  world = new World(20);
  smooth();

}

void draw() {
  background(255);

  world.run();
  
  fill(0);
  text("Press 's' to view SimpleMode", 30, height-16);


}

void mousePressed() {
  world.born(mouseX,mouseY); 
}

void mouseDragged() {
  world.born(mouseX,mouseY); 
}

void keyPressed() {

  if (key == 's') {
    world.changeGraphicsMode();
  }
}