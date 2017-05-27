// evolving_imager999 version 1.2.0 build 15
// Population version 1.2.0 build 11
// DNA version 1.2.0 build 11

// A class to describe a population of virtual organisms
// In this case, each organism is just an instance of a DNA object

class Population {

  DNA[] population;          // Array to hold the current population
  DNA[] populationBack;      // Backup population

  int dnaSize;
  private int popLength;

  private color backgroundColor;

  private int fitness, lastFitness;
  private int[] fitrgb, lastFitrgb = new int[3];

  private int success;

  private PImage target;

  private PGraphics canvas; // GA drawing
  private PGraphics c_canvas1; //Ga drawing cache

  Population(int popLength, int dnaSize, PImage target) {

    if (popLength > 10000) {
      println("error : popLength is up to 10000");
      popLength = 10000;
    }

    this.popLength = popLength;

    population = new DNA[10000];
    populationBack = new DNA[10000];

    this.dnaSize = dnaSize;

    for (int i = 0; i < popLength; i++) {
      population[i] =new DNA(dnaSize);
      populationBack[i] = new DNA(dnaSize);
    }

    this.target = target;

    backgroundColor = selectBackgroundColor(target);

    canvas = createGraphics(target.width, target.height);
    canvas.beginDraw();
    canvas.background(backgroundColor);
    canvas.endDraw();
    c_canvas1 = createGraphics(target.width, target.height);

    fitrgb = calFitness();
    lastFitness = fitrgb[0] + fitrgb[1] + fitrgb[2];
    lastFitrgb = fitrgb;

    fitness = lastFitness;
  }

  void display(int start, int target) {
    //canvas = c_canvas;
    if (target == start) {
      c_canvas1.beginDraw();
      c_canvas1.background(backgroundColor);
      for (int i = 0; i < start; i++)
        population[i].draw(c_canvas1);
      c_canvas1.endDraw();
    }

    canvas.beginDraw();

    canvas.image(c_canvas1, 0, 0);
    for (int i = target; i < popLength; i++)
      population[i].draw(canvas);

    canvas.endDraw();
  }

  void display(int target) {
    display(0, target);
  }

  void display() {
    canvas.beginDraw();
    canvas.background(backgroundColor);
    for (int i = 0; i < popLength; i++)
      population[i].draw(canvas);
    canvas.endDraw();
  }

  int mutate(int start) {

    success = 0;

    for (int i = start; i < popLength; i++) {

      population[i].mutate(preset);
      display(start, i);

      fitrgb = calFitness();
      fitness = fitrgb[0] + fitrgb[1] + fitrgb[2];

      //if before draw is better, rollback
      if (fitness < lastFitness) {
        copyFromOrigToBack();
        lastFitness = fitness;
        lastFitrgb = fitrgb;

        success++;
      } else {
        copyFromBackToOrig();
        fitness = lastFitness;
        fitrgb = lastFitrgb;
      }

      c_canvas1.beginDraw();
      population[i].draw(c_canvas1);
      c_canvas1.endDraw();
    }

    //No errors have occurred
    return 0;
  }

  int mutate() {

    success = 0;

    for (int i = 0; i < popLength; i++) {

      population[i].mutate(preset);
      display(i);

      fitrgb = calFitness();
      fitness = fitrgb[0] + fitrgb[1] + fitrgb[2];

      //if before draw is better, rollback
      if (fitness < lastFitness) {
        copyFromOrigToBack();
        lastFitness = fitness;
        lastFitrgb = fitrgb;

        success++;
      } else {
        copyFromBackToOrig();
        fitness = lastFitness;
        fitrgb = lastFitrgb;
      }

      c_canvas1.beginDraw();
      population[i].draw(c_canvas1);
      c_canvas1.endDraw();
    }

    //No errors have occurred
    return 0;
  }

  int addPop() {
    return addPop(50);
  }

  int addPop(int n) {

    if (popLength + n > 10000) {
      println("error : popLength is up to 10000");
      return -1;
    }

    for (int i = popLength; i < popLength + n; i++) {
      population[i] =new DNA(dnaSize);
      populationBack[i] = new DNA(dnaSize);
    }

    popLength = popLength + n;
    println("popLength : " + popLength);

    display();

    fitrgb = calFitness();
    lastFitness = fitrgb[0] + fitrgb[1] + fitrgb[2];
    lastFitrgb = fitrgb;
    fitness = lastFitness;

    //No errors have occurred
    return 0;
  }
  
  int removePop(){
    
    //No errors have occurred
    return 0;
  }

  int getPopLength() {
    return popLength;
  }

  int getFitness() {
    return fitness;
  }

  int[] getFitrgb() {
    return fitrgb;
  }

  int getSuccess() {
    return success;
  }

  int getBackgroundColor() {
    return backgroundColor;
  }

  PGraphics getCanvas() {
    return canvas;
  }

  PImage getTarget() {
    return target;
  }

  void setBackgroundColor(color c) {
    backgroundColor = c;
  }

  void savefile() {
    println("saving canvas..");
    canvas.save("projects/" + projectName + "/result.png");

    println("saving dna..");
    PrintWriter output = createWriter("projects/" + projectName + "/dna.air");

    output.println("MILEUAIR v1.0.0");     //file version
    output.println("#256");                //Optimized resolution
    output.println(red(backgroundColor) + ":" + green(backgroundColor) + ":" + blue(backgroundColor));  //backgroundColor

    for (int i = 0; i < popLength; i++)
      output.println(populationBack[i].toString());

    output.flush(); // Writes the remaining data to the file
    output.close();
  }

  // Fitness function
  int[] calFitness() {

    float rerr, gerr, berr;
    int[] fit = new int[3];// r, g, b

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
        fit[0] += rerr;
        fit[1] += gerr;
        fit[2] += berr;
      }
    }  

    return fit;
  }

  color selectBackgroundColor(PImage image) {
    int rsum = 0, gsum = 0, bsum = 0;
    int totalpixel = image.width * image.height;
    color averageColor;

    target.loadPixels();

    for (int x = 0; x < image.width; x++) {
      for (int y = 0; y < image.height; y++) {
        int loc = x + y*target.width;
        //int comploc = x + (y+(target.height))*target.width;
        color sourcepix = image.pixels[loc];

        //find the error in color (0 to 255, 0 is no error)
        rsum += red(sourcepix);
        gsum += green(sourcepix);
        bsum += blue(sourcepix);
      }
    }

    rsum = rsum / totalpixel;
    gsum = gsum / totalpixel;
    bsum = bsum / totalpixel;

    averageColor = color(rsum, gsum, bsum);
    println(rsum + " : " + gsum + " : " + bsum);

    return averageColor;
  }

  DNA getDNA(int i) {
    return population[i];
  }

  void copyFromOrigToBack() {
    for (int i = 0; i < popLength; i++)
      for (int j = 0; j < dnaSize; j++)
        populationBack[i].genes[j] = population[i].genes[j];
  }

  void copyFromOrigToBack(int target) {
    for (int j = 0; j < dnaSize; j++)
      populationBack[target].genes[j] = population[target].genes[j];
  }

  void copyFromBackToOrig() {
    for (int i = 0; i < popLength; i++)
      for (int j = 0; j < dnaSize; j++)
        population[i].genes[j] = populationBack[i].genes[j];
  }

  void copyFromBackToOrig(int target) {
    for (int j = 0; j < dnaSize; j++)
      population[target].genes[j] = populationBack[target].genes[j];
  }

  void copyFromBackToOrig(int target, int rgb) { // 0 : red, 1 : green, 2 : blue
    population[target].genes[rgb] = populationBack[target].genes[rgb];
  }
}  