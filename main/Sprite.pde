public class Sprite extends GameObject {
  PImage img;

  public Sprite(String filePath) {
    super();
    this.img = loadImage(filePath);
  }

  void draw() {
    image(this.img, this.position.x, this.position.y, this.scale.x, this.scale.y);
  }
}

public class AnimatedSprite extends GameObject {
  ArrayList<PImage> imgs;
  int currentFrame;
  boolean playing;

  // framerate handling
  int framerate;
  int lastUpdateTime;
  int interval;

  public AnimatedSprite(ArrayList<String> filePaths) {
    super();
    this.setDefaults();

    for (String path : filePaths) {
      this.imgs.add(loadImage(path));
    }
  }

  public AnimatedSprite(String filePath) {
    super();
    this.setDefaults();
    this.addFrame(filePath);
  }

  private void setDefaults() {
    this.imgs = new ArrayList<PImage>();
    this.currentFrame = 0;
    this.playing = false;
    this.setFramerate(int(frameRate));
  }

  public AnimatedSprite addFrame(String filePath) {
    this.imgs.add(loadImage(filePath));
    return this;
  }

  public AnimatedSprite addFrame(Sprite sprite) {
    this.imgs.add(sprite.img);
    return this;
  }

  public AnimatedSprite setFrame(int frame) {
    this.currentFrame = Utils.clamp(frame, 1, imgs.size() + 1) - 1;
    return this;
  }

  public AnimatedSprite play() {
    this.playing = true;
    this.lastUpdateTime = millis();
    return this;
  }

  public AnimatedSprite pause() {
    this.playing = false;
    return this;
  }

  public AnimatedSprite stop() {
    this.playing = false;
    this.currentFrame = 0;
    return this;
  }

  public AnimatedSprite setFramerate(int framerate) {
    this.framerate = framerate;
    this.interval = 1000 / this.framerate;
    return this;
  }

  private boolean isNowAfterLastUpdatedTime() {
    return millis() - this.lastUpdateTime >= interval;
  }

  void draw() {
    image(this.imgs.get(currentFrame), this.position.x, this.position.y, this.scale.x, this.scale.y);

    // loop animation
    if (this.playing && isNowAfterLastUpdatedTime()) {
      this.currentFrame = (this.currentFrame + 1) % this.imgs.size();
      this.lastUpdateTime = millis();
    }
  }
}
