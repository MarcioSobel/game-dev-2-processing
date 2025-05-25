public class Collision extends GameObject {
  private float left;
  private float right;
  private float top;
  private float bottom;

  private int r;
  private int g;
  private int b;

  public Collision() {
    super();

    this.setColor(255, 0, 0);
  }

  private void calculateBoundaries() {
    this.left = position.x;
    this.right = position.x + scale.x;
    this.top = position.y;
    this.bottom = position.y + scale.y;
  }

  public boolean isCollidingHorizontal(Collision other) {
    return this.right > other.left && this.left < other.right;
  }

  public boolean isCollidingVertical(Collision other) {
    return this.bottom > other.top && this.top < other.bottom;
  }

  public boolean isColliding(Collision other) {
    return this.isCollidingHorizontal(other) && this.isCollidingVertical(other);
  }

  public void setColor(int r, int g, int b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }

  void update() {
    this.calculateBoundaries();
  }

  void draw() {
    if (!Globals.game.debug) return;

    stroke(this.r, this.g, this.b);
    strokeWeight(4);

    // upper line
    line(left, top, right, top);

    // lower line
    line(left, bottom, right, bottom);

    // left line
    line(left, top, left, bottom);

    // right line
    line(right, top, right, bottom);

    noStroke();
  }
}
