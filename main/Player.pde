public class Player extends GameObject {
  Bullet bullet;
  Collision collision;

  private int SPEED = 60;
  private int BOUNDING_PADDING = 20;

  // to move player in steps
  private int lastMovedTime;
  private int moveInterval;

  public Player(int initialPositionX, int initialPositionY) {
    super();
    this.moveInterval = 150;
    this.lastMovedTime = millis();
    
    this.setScale(100, 100);

    this.addSprite();
    this.addCollision();

    this.bullet = new Bullet();
    bullet.active = false;

    this.setPosition(initialPositionX, initialPositionY);
    this.setAnchor(AnchorPosition.MIDDLE_CENTER);
    for (GameObject child : children) child.setAnchor(anchor, this);
  }

  private void addSprite() {
    Sprite sprite = new Sprite("player.png");
    sprite.setScale(scale.x, scale.y);

    this.addChild(sprite);
  }

  private void addCollision() {
    this.collision = new Collision();
    collision.setScale(scale.x / 2, scale.y / 4);

    this.addChild(collision);
  }

  private Bullet addBullet() {
    this.bullet = new Bullet(this.position.copy());
    bullet.setAnchor(AnchorPosition.MIDDLE_CENTER);
    Globals.currentScene.addObject(bullet);
    return bullet;
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
    return millis() - this.lastMovedTime >= moveInterval;
  }

  private void moveLeft() {
    if (position.x - (scale.x * 0.5) - SPEED <= BOUNDING_PADDING) return;
    setPosition(position.x - SPEED, position.y);
  }

  private void moveRight() {
    if (position.x + (scale.x * 0.5) + SPEED >= width - BOUNDING_PADDING) return;
    setPosition(position.x + SPEED, position.y);
  }
}
