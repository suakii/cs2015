
class DNA {

  // The genetic sequence
  float[] genes;//(x1,y1), (x2,y2), r, g, b, a;
  int dnaSize;
  float fitness;

  // Constructor (makes a random DNA)
  DNA(int num) {
    this.dnaSize = num;
    float len = target.width;
    genes = new float[dnaSize];

    //do not create too long line at first
    while (len > target.width / 2) {
      genes[0] = random(0, target.width);
      genes[1] = random(0, target.height);

      genes[2] = random(0, target.width);
      genes[3] = random(0, target.height);

      len = sqrt((genes[0] - genes[2]) * (genes[0] - genes[2]) + (genes[1] - genes[3]) * (genes[1] - genes[3]));
    }
    //create random fill color and define alpha
    genes[4] = random(1, 255);
    genes[5] = random(1, 255);
    genes[6] = random(1, 255);

    genes[7] = 64;
  }


  void mutate2() {
    genes[0]=constrain(genes[0]*random(0.9, 1.1), 1, target.width);
    genes[1]=constrain(genes[1]*random(0.9, 1.1), 1, target.height);

    genes[2]=constrain(genes[2]*random(0.9, 1.1), 1, target.width);
    genes[3]=constrain(genes[3]*random(0.9, 1.1), 1, target.height);

    genes[4]=constrain(genes[4]*random(0.8, 1.2), 1, 255);
    genes[5]=constrain(genes[5]*random(0.8, 1.2), 1, 255);
    genes[6]=constrain(genes[6]*random(0.8, 1.2), 1, 255);
  }

  void display(PGraphics cacheboard) {
    //draw polygon on screen based on parameters

    cacheboard.stroke(genes[4], genes[5], genes[6], genes[7]);
    cacheboard.strokeWeight(2);
    cacheboard.line(genes[0], genes[1], genes[2], genes[3]);
  }
}