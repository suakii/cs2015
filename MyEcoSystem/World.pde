
class World {

  ArrayList<Agent> agents;    // An arraylist for all the creatures

  // Constructor
  World(int num) {
    // Start with initial food and creatures
    agents = new ArrayList<Agent>();              // Initialize the arraylist
    for (int i = 0; i < num; i++) {
      PVector l = new PVector(random(width),random(height));
      agents.add(new Agent(l));
    }
  }

  // Make a new creature
  void born(float x, float y) {
    PVector l = new PVector(x,y);
    agents.add(new Agent(l));
  }

  // Run the world
  void run() {
    
    // Cycle through the ArrayList backwards b/c we are deleting
    for (int i = agents.size()-1; i >= 0; i--) {
      // All bloops run and eat
      Agent a = agents.get(i);
      a.run();
      // If it's dead, kill it and make food
      if (a.dead()) {
        agents.remove(i);
      }
      // Perhaps this bloop would like to make a baby?
      Agent child = a.reproduce();
      if (child != null) 
        agents.add(child);
    }
  }
}