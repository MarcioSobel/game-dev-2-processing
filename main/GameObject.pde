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

  public GameObject() {
    this.scale = new PVector(1, 1);
    this.position = new PVector(0, 0);
    this.children = new ArrayList<GameObject>();
    this.anchor = AnchorPosition.TOP_LEFT;
  }

  GameObject setAnchor(AnchorPosition anchor) {
    this.anchor = anchor;
    updatePosition();
    return this;
  }

  GameObject setPosition(float x, float y) {
    position.x = calculateXFromAnchor(x);
    position.y = calculateYFromAnchor(y);
    return this;
  }

  GameObject setScale(float x, float y) {
    scale.x = x;
    scale.y = y;
    updatePosition();
    return this;
  }

  GameObject addChild(GameObject obj) {
    children.add(obj);
    return this;
  }

  void updateChildren() {
    for (GameObject obj : children) {
      obj.updateChildren();
      obj.draw();
      obj.update();
    }
  }
  
  protected void updatePosition() {
   this.setPosition(position.x, position.y); 
  }

  protected float calculateYFromAnchor(float y) {
    switch (anchor) {
    case MIDDLE_LEFT:
    case MIDDLE_CENTER:
    case MIDDLE_RIGHT:
      return y - scale.y / 2;

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
      return x - scale.x / 2;

    case TOP_RIGHT:
    case MIDDLE_RIGHT:
    case BOTTOM_RIGHT:
      return x - scale.x;

    default:
      return x;
    }
  }

  void draw() {
  }

  void update() {
  }
}
