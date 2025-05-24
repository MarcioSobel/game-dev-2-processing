public class Bullet extends GameObject {
  int SPEED = 10;
  boolean active;

  public Bullet() {
    super();
    this.setDefaults();
  }

  public Bullet(PVector position) {
    super();
    this.setDefaults();
    this.setPosition(position);
  }

  private void setDefaults() {
    this.scale = new PVector(5, 10);
    this.active = true;
  }

  void update() {
    this.setPosition(position.x, position.y - SPEED);
    boolean isOutsideView = position.y - scale.y < 0 || position.y + scale.y > height;
    if (isOutsideView) {
      Globals.game.removeObject(this);
      this.active = false;
    };
   
    // TODO: check collisions
  }

  void draw() {
    fill(255, 255, 0);
    noStroke();
    rect(position.x, position.y, scale.x, scale.y);
  }
}
