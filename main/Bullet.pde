public class Bullet extends GameObject {
  int SPEED = 10;
  boolean active;
  Collision collision;

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
    addCollision();
  }

  private void addCollision() {
    this.collision = new Collision();
    collision.setScale(scale.x, scale.y);
    this.addChild(collision);
    collision.setAnchor(anchor, this);
  }

  void update() {
    this.setPosition(position.x, position.y - SPEED);
    boolean isOutsideView = position.y - scale.y < 0 || position.y + scale.y > height;
    if (isOutsideView) destroy();
    
    for (GameObject obj : Globals.game.gameObjects) {
      if (obj instanceof Enemies) {
        checkCollisionWithEnemies((Enemies) obj);
        break;
      };
    }
  }

  private void destroy() {
    Globals.game.removeObject(this);
    this.active = false;
  }

  private void checkCollisionWithEnemies(Enemies enemies) {
    boolean collided = false;
    Enemy collidedEnemy = new Enemy();
    
    for (GameObject enemy : enemies.children) {
      collided = checkCollisionWithEnemy((Enemy) enemy);
      if (!collided) continue;
      
      collidedEnemy = (Enemy) enemy;
      destroy();
      break;
    }

    if (collided) enemies.children.remove(collidedEnemy);
  }

  private boolean checkCollisionWithEnemy(Enemy enemy) {
    return collision.isColliding(enemy.collision);
  }

  void draw() {
    fill(255);
    noStroke();
    rect(position.x, position.y, scale.x, scale.y);
  }
}
