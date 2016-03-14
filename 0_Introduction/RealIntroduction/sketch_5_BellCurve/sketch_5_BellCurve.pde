
float[] heights;

void setup() {
  size(400, 200);
  smooth();
}

void draw() {
  background(255);
  float e = 2.71828183;                       
  float[] heights = new float[width];           
  float m = 0;                                  
  float sd = map(mouseX,0,width,0.4,2);     
  for (int i = 0; i < heights.length; i++) {
    float xcoord = map(i,0,width,-3,3);
    float sq2pi = sqrt(2*PI);                   
    float xmsq = -1*(xcoord-m)*(xcoord-m);      
    float sdsq = sd*sd;                         
    heights[i] = (1 / (sd * sq2pi)) * (pow(e, (xmsq/sdsq)));  
  }

  stroke(0);
  strokeWeight(2);
  noFill();
  beginShape();
  for (int i = 0; i < heights.length-1; i++) {
    float x = i; 
    float y = map(heights[i], 0, 1, height-2, 2);
    vertex(x, y);
  }
  endShape();
}