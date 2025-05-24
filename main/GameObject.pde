public enum AnchorPosition {
  TOP_LEFT,
    TOP_CENTER,
    TOP_RIGHT,
    MIDDLE_LEFT,
    MIDDLE_CENTER,
    MIDDLE_RIGHT,
    BOTTOM_LEFT,
    BOTTOM_CENTER,
    BOTTOM_RIGHT,
}

public class GameObject {
  PVector scale;
  PVector position;
  ArrayList<GameObject> children;
  AnchorPosition anchor;

  // used to update position based on parent
  protected PVector originalPosition;

  public GameObject() {
    this.scale = new PVector(1, 1);
    this.position = new PVector(0, 0);
    this.originalPosition =  new PVector(0, 0);
    this.children = new ArrayList<GameObject>();
    this.anchor = AnchorPosition.TOP_LEFT;
  }

  GameObject setAnchor(AnchorPosition anchor) {
    this.anchor = anchor;
    updatePosition();
    return this;
  }

  GameObject setPosition(float x, float y) {
    originalPosition.set(x, y);
    position = originalPosition.copy();

    updateChildPosition();
    return this;
  }

  GameObject setPosition(PVector pos) {
    return this.setPosition(pos.x, pos.y);
  }

  protected void updateChildPosition() {
    print(position + "\n");
    for (GameObject child : children) {
      PVector offset = position.copy();
      offset.sub(child.originalPosition);
      offset = child.calculatePositionFromAnchor(offset);
      child.position = offset;

      child.updateChildPosition();
    }
  }

  GameObject setScale(float x, float y) {
    scale.x = x;
    scale.y = y;
    updatePosition();
    return this;
  }

  GameObject addChild(GameObject obj) {
    children.add(obj);
    obj.updatePosition();
    return this;
  }

  void updateChildren() {
    for (GameObject obj : children) {
      obj.update();
      obj.updateChildren();
      obj.updateChildPosition();
      obj.draw();
    }
  }

  protected void updatePosition() {
    this.setPosition(originalPosition);
  }

  protected PVector calculatePositionFromAnchor(PVector pos) {
    PVector v = pos.copy();
    v.x = calculateXFromAnchor(v.x);
    v.y = calculateYFromAnchor(v.y);
    return v;
  }

  protected float calculateYFromAnchor(float y) {
    switch (anchor) {
    case MIDDLE_LEFT:
    case MIDDLE_CENTER:
    case MIDDLE_RIGHT:
      return y - floor(scale.y / 2);

    case BOTTOM_LEFT:
    case BOTTOM_CENTER:
    case BOTTOM_RIGHT:
      return y - scale.y;

    default:
      return y;
    }
  }

  protected float calculateXFromAnchor(float x) {
    switch (anchor) {
    case TOP_CENTER:
    case MIDDLE_CENTER:
    case BOTTOM_CENTER:
      return x - floor(scale.x / 2);

    case TOP_RIGHT:
    case MIDDLE_RIGHT:
    case BOTTOM_RIGHT:
      return x - scale.x;

    default:
      return x;
    }
  }

  // draw is where the the images and shapes of the game will be rendered.
  // this method should not be used to update values, only use them.
  void draw() {
  }

  // update is where the game logic is handled -- keypresses, time events, collisions.
  // no drawing methods should be used here.
  void update() {
  }
}
