public class Player extends GameObject {
  Sprite sprite;

  private int SPEED = 5;

  public Player(int initialPositionX, int initialPositionY) {
    super();
    this.addSprite();
    this.setPosition(initialPositionX, initialPositionY);
  }

  private void addSprite() {
    this.sprite = new Sprite("player.png");
    sprite.setScale(100, 100);
    sprite.setAnchor(AnchorPosition.MIDDLE_CENTER);

    this.addChild(sprite);
  }
  
  Player setSprite(Sprite spr) {
     this.sprite = spr;
     return this;
  }

  void update() {
    if (keyPressed) {
      switch (keyCode) {
      case RIGHT:
        moveRight();
        break;
      case LEFT:
        moveLeft();
        break;
      }
    }
  }

  private void moveLeft() {
    setPosition(position.x - SPEED, position.y);
  }

  private void moveRight() {
    setPosition(position.x + SPEED, position.y);
  }
}
