Game game;

void draw() {
  background(0);
  game.process();
}

void setup() {
  size(700, 700);
  frameRate(60);
  Globals.processing = this;

  game = new Game();
  game.setScene(new MenuScene());
}
