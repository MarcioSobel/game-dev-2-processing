public class Sprite extends GameObject {
  PImage img;

  public Sprite(String filePath) {
    this.img = loadImage(filePath);
  }

  void draw() {
    image(this.img, this.position.x, this.position.y, this.scale.x, this.scale.y);
  }
}
