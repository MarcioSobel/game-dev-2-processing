public class Player extends GameObject {
  Sprite sprite;
  Bullet bullet;

  private int SPEED = 50;

  // to move player in steps of 1 second
  private int lastMovedTime;

  public Player(int initialPositionX, int initialPositionY) {
    super();
    this.addSprite();
    this.addBullet();
    this.setPosition(initialPositionX, initialPositionY);
  }

  private void addSprite() {
    this.sprite = new Sprite("player.png");
    sprite.setScale(100, 100);
    sprite.setAnchor(AnchorPosition.MIDDLE_CENTER);

    this.addChild(sprite);
  }

  private Bullet addBullet() {
    this.bullet = new Bullet(this.position.copy());
    bullet.setAnchor(AnchorPosition.MIDDLE_CENTER);
    Globals.game.addObject(bullet);
    return bullet;
  }

  Player setSprite(Sprite spr) {
    this.sprite = spr;
    return this;
  }

  void update() {
    if (keyPressed) {
      handleMovement();
      handleShoot();
    }
  }

  private void handleShoot() {
    if (bullet.active) return;
    
    switch (keyCode) {
    case UP:
      shoot();
      break;
    }
  }

  private void handleMovement() {
    if (!canMove() || key != CODED) return;
    this.lastMovedTime = millis();

    switch (keyCode) {
    case RIGHT:
      moveRight();
      break;
    case LEFT:
      moveLeft();
      break;
    }
  }

  private void shoot() {
    this.addBullet();
  }

  // the player should move in steps, not in a fluid motion
  // so we say we can move it at most once per quarter of a second.
  private boolean canMove() {
    return millis() - this.lastMovedTime >= 250;
  }

  private void moveLeft() {
    if (position.x - SPEED <= 0) return;
    setPosition(position.x - SPEED, position.y);
  }

  private void moveRight() {
    if (position.x + SPEED >= width) return;
    setPosition(position.x + SPEED, position.y);
  }
}
