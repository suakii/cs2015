/*
 * Jonghwa Park
 * suakii@gmail.com
*/
class World {

  ArrayList<Agent> agents;   

  World(int num) {
    agents = new ArrayList<Agent>();              
    for (int i = 0; i < num; i++) {
      PVector l = new PVector(random(width),random(height));
      agents.add(new Fish(l));
    }
  }

  void born(float x, float y) {
    PVector l = new PVector(x,y);
    agents.add(new Fish(l));
  }

  void run() {
    
    for (int i = agents.size()-1; i >= 0; i--) {
      Agent a = agents.get(i);
      a.run();
      if (a.dead()) {
        agents.remove(i);
      }
    }
  }
  
}