

// A class to describe a population of virtual organisms
// In this case, each organism is just an instance of a DNA object

class Population {

  float mutationRate;           // Mutation rate
  DNA[] population;             // Array to hold the current population
  DNA[] populationBack;
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

  void display() {
    for (int i = 0; i < population.length; i++) {
        population[i].display();
      }
   }
   
       // Fitness function
  int calFitness() {
    float rerr, gerr, berr, error;
    int fit = 0;
    //load pixels from display
    loadPixels();
    
    for (int x = 0; x < target.width; x++) {
      for (int y = 0; y < target.height; y++) {
        int loc = x + y*target.width;
        int comploc = x + (y+(target.height))*target.width;
        color sourcepix = target.pixels[loc];
        color comparepix = pixels[comploc];
  
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
 