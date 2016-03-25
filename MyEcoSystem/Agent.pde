/*
 * Jonghwa Park
 * suakii@gmail.com
*/

class Agent {
  PVector location;
  PVector velocity;
  
  float health;
  float xoff;
  float yoff;
 
  float r;
  float maxspeed;
  

 
  
  Agent(PVector l) {
    location = l;
    health = 200;
    xoff = random(1000);
    yoff = random(1000);
    maxspeed = map(random(1), 0, 1, 15, 0);
    r = map(random(1), 0, 1, 0, 50);
    
    velocity = new PVector(0, 0);
  }
  
  void run() {
    update();
    borders();
    display();
  }
  
  void update() {
    // Simple movement based on perlin noise
    // How about change noise function to random function?
    velocity.x = map(noise(xoff),0,1,-maxspeed,maxspeed);
    velocity.y = map(noise(yoff),0,1,-maxspeed,maxspeed);
    xoff += 0.01;
    yoff += 0.01;

    location.add(velocity);
    // Death b.b
    health -= 0.2;
  }
  
  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }
  
  void display() {
    
    pushMatrix();
      if(simpleGraphics == false)
        drawBody();
      else
        simpleShape();
    popMatrix();
  }
  
  //child class to override this 
  void drawBody() {
  
  }
  void simpleShape() {
      ellipseMode(CENTER);
      stroke(0,health);
      fill(0, health);
      ellipse(location.x, location.y, r, r);
  }

  // Death
  boolean dead() {
    if (health < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
}