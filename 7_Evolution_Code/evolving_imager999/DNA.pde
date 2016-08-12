
class DNA {

  // The genetic sequence
  float[] genes;//(x1,y1), (x2,y2), (x3,y3), r, g, b, a;
  int dnaSize;
  float fitness;
  
  // Constructor (makes a random DNA)
DNA(int num) {
        this.dnaSize = num;
        
        
        genes = new float[dnaSize];
        
       
        genes[0] = random(0, target.width);
        genes[1] = random(target.height, target.height*2);
     
        genes[2] = random(0, target.width);
        genes[3] = random(target.height, target.height*2);
        
        genes[4] = random(0, target.width);
        genes[5] = random(target.height, target.height*2);
        
        //create random fill color and define alpha
        genes[6] = random(1,255);
        genes[7] = random(1,255);
        genes[8] = random(1,255);
        
        genes[9] = 64;
       
  }
 
   
   void mutate2() {
      genes[0]=constrain(genes[0]*random(0.9,1.1),1, target.width);
      genes[1]=constrain(genes[1]*random(0.9,1.1),target.height, 2*target.height);
     
      genes[2]=constrain(genes[2]*random(0.9,1.1),1, target.width);
      genes[3]=constrain(genes[3]*random(0.9,1.1),target.height, 2*target.height);
     
      genes[4]=constrain(genes[4]*random(0.9,1.1),1, target.width);
      genes[5]=constrain(genes[5]*random(0.9,1.1),target.height, 2*target.height);
     
     
      genes[6]=constrain(genes[6]*random(0.7,1.3),1,255);
      genes[7]=constrain(genes[7]*random(0.7,1.3),1,255);
      genes[8]=constrain(genes[8]*random(0.7,1.3),1,255);

   
   }
   
  void display(){
    //draw polygon on screen based on parameters
    fill(genes[6], genes[7], genes[8], genes[9]);
    
    triangle(genes[0],genes[1],genes[2],genes[3],genes[4],genes[5]);
    
    
  }
  
    
}