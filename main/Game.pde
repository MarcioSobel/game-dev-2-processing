public class Game {
  ArrayList<GameObject> gameObjects;

  // when calling addObject(), the process() might be running,
  // giving an ConcurrentModificationException.
  // creating a separate list to be added later will fix the issue.
  private ArrayList<GameObject> pendingAdditions;

  public Game() {
    this.gameObjects = new ArrayList<GameObject>();
    this.pendingAdditions = new ArrayList<GameObject>();
    Globals.game = this;
  }

  void process() {
    // add objects that couldn't be added before due to
    // already running process function
    handlePendingAdditions();

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

  Game addObject(GameObject obj) {
    pendingAdditions.add(obj);
    return this;
  }
}
