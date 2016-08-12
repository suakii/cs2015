// A class to describe a population of virtual organisms
// In this case, each organism is just an instance of a DNA object

class Population {

  float mutationRate;           // Mutation rate
  DNA[] population;             // Array to hold the current population
  DNA[] populationBack;         // Backup population
  int dnaSize;
  
  Population(int popNum, int dnaSize) {
    population = new DNA[popNum];
    populationBack = new DNA[popNum];
    this.dnaSize = dnaSize;
    for (int i = 0; i < population.length; i++) {
      population[i] =new DNA(dnaSize);
      populationBack[i] = new DNA(dnaSize);
      
    }
  }


  void display(int newDNA) {
    //create keyframe
    if(newDNA%rootpopmax == 0) {
      c_canvas.beginDraw();
      c_canvas.background(255);
      for(int i = 0; i < newDNA; i++){
        population[i].c_display();
      }
      for(int i = newDNA + rootpopmax; i < popmax; i++){
        population[i].c_display();
      }
      c_canvas.endDraw();
      
    } else {
      //canvas = c_canvas;
      canvas.beginDraw();
      canvas.image(c_canvas,0,0);
      for (int i = newDNA - newDNA%rootpopmax; i < newDNA - newDNA%rootpopmax + rootpopmax; i++) {
        population[i].display();
      }
      
      canvas.endDraw();
      
    }
   }
   
       // Fitness function
  int calFitness() {

    float rerr, gerr, berr, error;
    int fit = 0;
    
    for (int x = 0; x < target.width; x++) {
      for (int y = 0; y < target.height; y++) {
        int loc = x + y*target.width;
        //int comploc = x + (y+(target.height))*target.width;
        color sourcepix = target.pixels[loc];
        color comparepix = canvas.pixels[loc];
  
        //find the error in color (0 to 255, 0 is no error)
        rerr = abs(red(sourcepix)-red(comparepix));
        gerr = abs(green(sourcepix)-green(comparepix));
        berr = abs(blue(sourcepix)-blue(comparepix));
        error = (rerr+gerr+berr)/3;
        fit += error;
      }
    }  

    
    return fit;
  }
  
  DNA getDNA(int i) {
    return population[i];
  }
  
  void copyFromOrigToBack() {
    //println("copy From Orig To Back");
    for (int i = 0; i < population.length; i++)
      for (int j = 0; j < dnaSize; j++)
        populationBack[i].genes[j] = population[i].genes[j];
  }
  
   void copyFromBackToOrig() {
    for (int i = 0; i < population.length; i++)
      for (int j = 0; j < dnaSize; j++)
        population[i].genes[j] = populationBack[i].genes[j];
  }
}  
 