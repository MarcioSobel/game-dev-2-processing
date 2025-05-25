Game game;

void draw() {
  background(0);
  game.process();
}

void setup() {
  size(800, 800);
  frameRate(60);

  game = new Game();
  
  Sprite background = new Sprite("background.png");
  background.setScale(width, height);
  game.addObject(background);

  Player player = new Player(width / 2, height - 60);
  game.addObject(player);
  
  Enemies enemies = new Enemies(32);
  game.addObject(enemies);
}
