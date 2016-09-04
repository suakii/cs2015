//data of times and fitness
Table table = new Table();

// Genetic Algorithm, 
PFont f;
PImage target;

PGraphics canvas; // GA drawing
PGraphics c_canvas1, c_canvas2; //Ga drawing cache

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

  surface.setSize(target.width, target.height * 2 + 70);
  
  table.addColumn("Gen");
  table.addColumn("Time");
  table.addColumn("Fitness");
  
  canvas = createGraphics(target.width, target.height);
  canvas.beginDraw();
  canvas.smooth();
  canvas.noStroke();
  canvas.background(255);
  canvas.endDraw();
  
  c_canvas1 = createGraphics(target.width, target.height);
  c_canvas1.beginDraw();
  c_canvas1.smooth();
  c_canvas1.noStroke();
  c_canvas1.background(255);
  c_canvas1.endDraw();

  c_canvas2 = createGraphics(target.width, target.height);
  c_canvas2.beginDraw();
  c_canvas2.smooth();
  c_canvas2.noStroke();
  c_canvas2.endDraw();
  
  //rootpopmax = (target.width + target.height) / 10;
  rootpopmax = 33;
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
  if(fitness < 230000) exit();
  for (int i = 0; i < population.population.length; i++) {
    
    population.population[i].mutate2();
    
    population.display(i);

    fitness = population.calFitness();

    //if before draw is better, rollback
    if (fitness < lastFitness || random(100) < 2) {
      population.copyFromOrigToBack();
      lastFitness = fitness;
    } else {
      population.copyFromBackToOrig();
    }
    
  }

  gen++;

  image(target, 0, 0);
  image(canvas, 0, target.height);
  displayInfo();
  
  
  TableRow newRow = table.addRow();
  newRow.setInt("Gen", gen);
  newRow.setInt("Time", millis());
  newRow.setInt("Fitness", fitness);
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
  saveTable(table, "data/data.csv");
}