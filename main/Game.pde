public class Game {
  ArrayList<GameObject> gameObjects;

  public Game() {
    this.gameObjects = new ArrayList<GameObject>();
  }

  void process() {
    for (GameObject obj : gameObjects) {
      obj.updateChildren();
      obj.update();
      obj.draw();
    }
    
    textSize(Utils.defaultFontSize);
  }

  Game addObject(GameObject obj) {
    gameObjects.add(obj);
    return this;
  }
}
