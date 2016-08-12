// Genetic Algorithm, 
PFont f;
PImage target;

PGraphics canvas; // GA drawing
PGraphics c_canvas; //Ga drawing cache

int rootpopmax;
int popmax;

int dnaSize;
Population population;


int lastFitness;

void setup() {
  size(128, 325);
  
  noStroke();
  smooth();

  f = createFont("Courier", 32, true);
  target = loadImage("monalisa.jpg");

  canvas = createGraphics(128, 128);
  canvas.beginDraw();
  canvas.smooth();
  canvas.noStroke();
  canvas.background(255);
  canvas.endDraw();
  
  c_canvas = createGraphics(128, 128);
  c_canvas.beginDraw();
  c_canvas.smooth();
  c_canvas.noStroke();
  c_canvas.background(255);
  c_canvas.endDraw();

  //target = loadImage("gshs.jpg");
  rootpopmax = 34;
  popmax = rootpopmax * rootpopmax;
  
  dnaSize = 8;

  image(target, 0, 0);
  target.loadPixels();

  // Create a populationation with a target , mutation rate, and populationation max
  population = new Population(popmax, dnaSize);

  lastFitness = population.calFitness();
  fitness = lastFitness;
}

int gen, fitness;

void draw() {
  for (int i = 0; i < population.population.length; i++) {
    
    population.population[i].mutate2();
    
    population.display(i);

    fitness = population.calFitness();

    //if before draw is better, rollback
    if (fitness < lastFitness || random(100)<5) {
      population.copyFromOrigToBack();
      lastFitness = fitness;
    } else {
      population.copyFromBackToOrig();
    }
    
  }


  gen++;


  image(canvas, 0, target.height);
  displayInfo();
}

void displayInfo() {

  //display generation count
  textSize(14);
  fill(0);
  rect(0, 5 + 2*target.height, target.width, 60);
  fill(255);
  text("Gen: " + gen, 6, 20 + 2*target.height);
  text("Time: " + millis()/1000 + "." + (millis()%1000)/10, 6, 40 + 2*target.height);
  text("Fitness: " + fitness, 6, 60 + 2*target.height);
}

void exit(){
  println("saving canvas..");
  canvas.save("data/result.png");
}