Game game;

void setup() {
  size(800, 800);
  game = new Game();
}

void draw() {
  background(0);
  game.process();
}
