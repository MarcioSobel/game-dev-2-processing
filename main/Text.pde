public class Text extends GameObject {
  String content;
  int fontSize = Utils.defaultFontSize;
  PVector textBoxSize;

  public Text(String content) {
    super();
    this.content = content;
    this.textBoxSize = new PVector(0, 0);
    this.calculateSizeFromContent();
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
    // set font size
    textSize(this.fontSize);
    
    text(this.content, this.position.x, this.position.y + textBoxSize.y);
    
    // reset font size (so it doesn't mess with other draw methods)
    textSize(Utils.defaultFontSize);
  }
  
  
  Text setPosition(float x, float y) {
    originalPosition.set(x, y);
    position = originalPosition.copy();
    this.calculateSizeFromContent();
    return this;
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
