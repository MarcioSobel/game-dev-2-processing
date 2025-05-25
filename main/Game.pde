public class Game {
  private GameScene scene;

  public boolean debug;

  public Game() {
    setDefaults();

    // create empty scene
    this.setScene(new GameScene());
  }

  private void setDefaults() {
    this.debug = false;
    Globals.game = this;
  }

  Game setScene(GameScene scene) {
    this.scene = scene;
    Globals.currentScene = scene;
    return this;
  }

  void process() {
    scene.process();
    textSize(Utils.defaultFontSize);
  }
}
