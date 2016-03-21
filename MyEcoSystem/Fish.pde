

class Fish extends Agent {
  
  float s = random(-90, 90);
  float d = random(0.1, 0.3);
  
  Fish(PVector l) {
    super(l);
    
  }
  
  void drawBody() {
    pushMatrix();
      translate(location.x, location.y);
      scale(d);
      stroke(0,health);
      fill(0, health);
      
      rotate(velocity.heading()-radians(90));
      beginShape();
        for (int i = 0; i <= 180; i+=20) {
          float x = sin(radians(i)) * i/3;
          float angle = sin(radians(i+s+frameCount*5)) * 50;
          vertex(x-angle, i*2);
          vertex(x-angle, i*2);
        }
        
       for (int i = 180; i >= 0; i-=20) {
          float x = sin(radians(i)) * i/3;
          float angle = sin(radians(i+s+frameCount*5)) * 50;
          vertex(-x-angle, i*2);
          vertex(-x-angle, i*2);
      }
      endShape();
    popMatrix();
  }
  



}