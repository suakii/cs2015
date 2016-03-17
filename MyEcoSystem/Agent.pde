
class Agent {
  PVector location;
  
  float health;
  float xoff;
  float yoff;
 
  float r;
  float maxspeed;
  
  Agent(PVector l) {
    location = l.get();
    health = 200;
    xoff = random(1000);
    yoff = random(1000);
    maxspeed = map(random(1), 0, 1, 15, 0);
    r = map(random(1), 0, 1, 0, 50);
  }
  
  void run() {
    update();
    borders();
    display();
  }
  

  
  Agent reproduce() {
    // asexual reproduction
    if (random(1) < 0.0005) {
      return new Agent(location);
    } 
    else {
      return null;
    }
  }
  
   // Method to update location
  void update() {
    // Simple movement based on perlin noise
    float vx = map(noise(xoff),0,1,-maxspeed,maxspeed);
    float vy = map(noise(yoff),0,1,-maxspeed,maxspeed);
    PVector velocity = new PVector(vx,vy);
    xoff += 0.01;
    yoff += 0.01;

    location.add(velocity);
    // Death always looming
    health -= 0.2;
  }
  
   // Wraparound
  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }
  
  // Method to display
  void display() {
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