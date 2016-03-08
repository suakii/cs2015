Car myCar; // Declare car object as a globle variable.

void setup() {
  size(480, 270);
  // Initialize car object in setup() by calling constructor.
  myCar = new Car();
}

void draw() {
  background(255);
  // Operate Car object in draw() by calling 
  // object methods using the dot syntax.
  myCar.move(); 
  myCar.display();
}