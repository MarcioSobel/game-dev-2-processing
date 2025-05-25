public class MainGameScene extends GameScene {
  public MainGameScene() {
    Sprite background = new Sprite("background.png");
    background.setScale(width, height);
    this.addObject(background);

    Player player = new Player(width / 2, height - 60);
    this.addObject(player);

    Enemies enemies = new Enemies(32);
    this.addObject(enemies);
  }
}
