public class Text extends GameObject {
  String content;
  int fontSize = Utils.defaultFontSize;
  PVector textBoxSize;
  PVector rgb;

  public Text(String content) {
    super();
    this.content = content;
    this.textBoxSize = new PVector(0, 0);
    this.calculateSizeFromContent();
    this.rgb = new PVector(255, 255, 255);
  }

  public Text() {
    super();
    this.textBoxSize = new PVector(0, 0);
  }

  public Text setContent(String newContent) {
    this.content = newContent;
    this.calculateSizeFromContent();
    return this;
  }

  public Text appendContent(String content) {
    this.content += content;
    this.calculateSizeFromContent();
    return this;
  }

  public Text setFontSize(int fontSize) {
    this.fontSize = fontSize;
    this.calculateSizeFromContent();
    return this;
  }

  private void calculateSizeFromContent() {
    // set font size
    textSize(this.fontSize);

    // calculate box size
    this.textBoxSize.x = textWidth(this.content);
    this.textBoxSize.y = textAscent();
    this.updateTextAlignment();

    // reset font size (so it doesn't mess with other draw methods)
    textSize(Utils.defaultFontSize);
  }

  private void updateTextAlignment() {
    position = originalPosition.copy();
  }

  public void draw() {
    // set font size and color
    textSize(this.fontSize);
    fill(rgb.x, rgb.y, rgb.z);

    text(this.content, this.position.x, this.position.y + textBoxSize.y);

    // reset font size and color (so it doesn't mess with other draw methods)
    textSize(Utils.defaultFontSize);
    fill(255);
  }

  public Text setColor(float r, float g, float b) {
    this.rgb.set(r, g, b);
    return this;
  }

  Text setPosition(float x, float y) {
    originalPosition.set(x, y);
    position = originalPosition.copy();
    this.calculateSizeFromContent();
    return this;
  }

  Text centerX() {
    float x = this.getCenterX();
    this.setPosition(x, position.y);
    return this;
  }

  Text centerY() {
    float y = this.getCenterY();
    this.setPosition(position.x, y);
    return this;
  }

  Text center() {
    float x = this.getCenterX();
    float y = this.getCenterY();
    this.setPosition(x, y);
    return this;
  }

  private float getCenterX() {
    return width / 2 - textBoxSize.x / 2;
  }

  private float getCenterY() {
    return height / 2 - textBoxSize.y / 2;
  }

  protected float calculateYFromAnchor(float y) {
    switch (anchor) {
    case MIDDLE_LEFT:
    case MIDDLE_CENTER:
    case MIDDLE_RIGHT:
      return y - textBoxSize.y / 2;

    case BOTTOM_LEFT:
    case BOTTOM_CENTER:
    case BOTTOM_RIGHT:
      return y - textBoxSize.y;

    default:
      return y;
    }
  }

  protected float calculateXFromAnchor(float x) {
    switch (anchor) {
    case TOP_CENTER:
    case MIDDLE_CENTER:
    case BOTTOM_CENTER:
      return x - textBoxSize.x / 2;

    case TOP_RIGHT:
    case MIDDLE_RIGHT:
    case BOTTOM_RIGHT:
      return x - textBoxSize.x;

    default:
      return x;
    }
  }
}
