public class Game {
  ArrayList<GameObject> gameObjects;

  // when calling addObject() or removeObject(), the process() might
  // be running, giving an ConcurrentModificationException.
  // creating a separate list to be processed before will fix the issue.
  private ArrayList<GameObject> pendingAdditions;
  private ArrayList<GameObject> pendingRemovals;
  
  public boolean debug;

  public Game() {
    this.gameObjects = new ArrayList<GameObject>();
    this.pendingAdditions = new ArrayList<GameObject>();
    this.pendingRemovals = new ArrayList<GameObject>();
    this.debug = false;
    
    Globals.game = this;
  }

  void process() {
    // add and remove objects that couldn't be added before 
    // due to already running process function
    handlePendingAdditions();
    handlePendingRemovals();

    for (GameObject obj : gameObjects) {
      obj.updateChildren();
      obj.update();
      obj.draw();
    }

    textSize(Utils.defaultFontSize);
  }

  private void handlePendingAdditions() {
    if (pendingAdditions.isEmpty()) return;
    this.gameObjects.addAll(this.pendingAdditions);
    this.pendingAdditions.clear();
  }

  private void handlePendingRemovals() {
    if (pendingRemovals.isEmpty()) return;
    this.gameObjects.removeAll(this.pendingRemovals);
    this.pendingRemovals.clear();
  }

  Game addObject(GameObject obj) {
    pendingAdditions.add(obj);
    return this;
  }

  Game removeObject(GameObject obj) {
    pendingRemovals.add(obj);
    return this;
  }
}
