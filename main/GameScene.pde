public class GameScene {
  ArrayList<GameObject> objects;

  // when calling addObject() or removeObject(), the process() might
  // be running, giving an ConcurrentModificationException.
  // creating a separate list to be processed before will fix the issue.
  private ArrayList<GameObject> pendingAdditions;
  private ArrayList<GameObject> pendingRemovals;

  public GameScene() {
    super();
    this.objects = new ArrayList<GameObject>();
    this.pendingAdditions = new ArrayList<GameObject>();
    this.pendingRemovals = new ArrayList<GameObject>();
  }

  void process() {
    // add and remove objects that couldn't be added before
    // due to already running process function
    handlePendingAdditions();
    handlePendingRemovals();

    for (GameObject obj : objects) {
      obj.updateChildren();
      obj.update();
      obj.draw();
    }

    textSize(Utils.defaultFontSize);
  }

  private void handlePendingAdditions() {
    if (pendingAdditions.isEmpty()) return;
    this.objects.addAll(this.pendingAdditions);
    this.pendingAdditions.clear();
  }

  private void handlePendingRemovals() {
    if (pendingRemovals.isEmpty()) return;
    this.objects.removeAll(this.pendingRemovals);
    this.pendingRemovals.clear();
  }

  GameScene addObject(GameObject obj) {
    pendingAdditions.add(obj);
    return this;
  }

  GameScene removeObject(GameObject obj) {
    pendingRemovals.add(obj);
    return this;
  }
}
