

// Genetic Algorithm, 



PFont f;
PImage target;
int popmax;
int dnaSize;
Population population;


int lastFitness;

void setup() {
  size(128, 400);
  noStroke();
  smooth();
  f = createFont("Courier", 32, true);
  target = loadImage("monalisa.jpg");
  popmax = 200;
  dnaSize = 10;

  image(target, 0, 0);
  target.loadPixels();
  
  // Create a populationation with a target , mutation rate, and populationation max
  population = new Population(popmax,dnaSize);

  lastFitness = population.calFitness();
}
int i, gen, fitness;
void draw() {

  population.population[i].mutate2();
  
  
  fill(0);
  rect(0, target.height,target.width, target.height);
  
  population.display();
  if (i < population.population.length-1)
    i++;
  else {
    i = 0;
    gen++;
  }
  
  fitness = population.calFitness();
  if (fitness < lastFitness) {
    population.copyFromOrigToBack();
    lastFitness = fitness;
  
  } else {
      population.copyFromBackToOrig();
  }
  
  displayInfo();
  
}

void displayInfo() {
  
 //display generation count
  textSize(14);
  fill(0);
  rect(4,5 + 2*target.height, target.width,60);
  fill(255);
  text("Gen: " + gen, 6, 20 + 2*target.height);
  text("Time: " + millis(), 6, 40 + 2*target.height);
  text("Fitness: " + fitness, 6, 60 + 2*target.height);
  
  
}