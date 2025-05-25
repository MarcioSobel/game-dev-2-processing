Game game;

void draw() {
  background(0);
  game.process();
}

void setup() {
  size(800, 800);
  frameRate(60);

  game = new Game();
  game.setScene(new MenuScene());
}
