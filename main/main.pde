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

  Player player = new Player(width / 2, height / 2);
  game.addObject(player);
}
