public class Collision extends GameObject {
  public Collision() {
    super();
  }

  public boolean collidesWith(GameObject other) {
    float thisLeft = position.x;
    float thisRight = position.x + scale.x;
    float thisTop = position.y;
    float thisBottom = position.y + scale.y;

    float otherLeft = other.position.x;
    float otherRight = other.position.x + other.scale.x;
    float otherTop = other.position.y;
    float otherBottom = other.position.y + other.scale.y;

    boolean horizontalCollision = thisRight > otherLeft && thisLeft < otherRight;
    boolean verticalCollision = thisBottom > otherTop && thisTop < otherBottom;
    boolean collision = (horizontalCollision && verticalCollision);

    return collision;
  }
  
  void draw() {
     if (!Globals.game.debug) return;
     
     stroke(255, 0, 0);
     strokeWeight(4);
     
     float left = position.x;
     float right = position.x + scale.x;
     float top = position.y;
     float bottom = position.y + scale.y;
     
     // upper line
     line(left, top, right, top);
     
     // lower line
     line(left, bottom, right, bottom);
     
     // left line
     line(left, top, left, bottom);
     
     // right line
     line(right, top, right, bottom);
  }
}
