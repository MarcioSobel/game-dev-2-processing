Game game;

void draw() {
  background(0);
  game.process();
}

void setup() {
  size(800, 800);
  frameRate(60);
  
  game = new Game();
  GameScene mainScene = newMainScene();
  game.setScene(mainScene);
}

GameScene newMainScene() {
  GameScene mainScene = new GameScene();

  Sprite background = new Sprite("background.png");
  background.setScale(width, height);
  mainScene.addObject(background);

  Player player = new Player(width / 2, height - 60);
  mainScene.addObject(player);

  Enemies enemies = new Enemies(16);
  mainScene.addObject(enemies);

  return mainScene;
}
