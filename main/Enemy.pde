public class Enemy extends GameObject {
  Collision collision;

  public Enemy() {
    super();

    this.setScale(100, 100);
    this.setAnchor(AnchorPosition.MIDDLE_CENTER);
    
    this.addSprite();
    this.addCollision();
  }

  private void addSprite() {
    Sprite sprite = new Sprite("enemy.png");
    sprite.setScale(scale.x, scale.y).setAnchor(anchor, this);

    this.addChild(sprite);
  }

  private void addCollision() {
    this.collision = new Collision();
    collision.setColor(255, 255, 0);
    collision.setPosition(4, 6);
    collision.setScale(scale.x / 2, scale.y / 4).setAnchor(anchor, this);

    this.addChild(collision);
  }
}
