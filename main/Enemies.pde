import java.util.Optional;

public class Enemies extends GameObject {
  private int lastUpdatedPosition;
  int horizontalOffset;
  int horizontalOffsetDirection;

  public Enemies(int enemyAmount) {
    super();
    this.addEnemies(enemyAmount);
    this.setPosition(90, 40);
    for (GameObject child : children) child.setAnchor(anchor, this);

    this.horizontalOffset = 0;
    this.horizontalOffsetDirection = 1;
    this.lastUpdatedPosition = millis();
  }

  void update() {
    checkCollisionWithPlayer();
    boolean shouldUpdateOffset = millis() - lastUpdatedPosition >= 1000;
    if (!shouldUpdateOffset) return;

    updateHorizontalOffset();

    if (abs(horizontalOffset) == 2) horizontalOffsetDirection *= -1;
    if (abs(horizontalOffset) == 2) updateVerticalOffset();

    lastUpdatedPosition = millis();
  }

  private void updateHorizontalOffset() {

    horizontalOffset += horizontalOffsetDirection;

    switch (horizontalOffset) {
    case 1:
    case 2:
      this.setPosition(110, position.y);
      break;
    case 0:
      this.setPosition(90, position.y);
      break;
    case -1:
    case -2:
      this.setPosition(70, position.y);
      break;
    }
  }

  private void updateVerticalOffset() {
    this.setPosition(position.x, position.y + 30);
  }

  private void checkCollisionWithPlayer() {
    Optional<Player> optionalPlayer = getPlayer();
    if (optionalPlayer.isEmpty()) return;

    Player player = optionalPlayer.get();

    boolean collided = false;
    for (GameObject child : children) {
      Enemy enemy = (Enemy) child;

      if (!enemy.checkCollisionWithPlayer(player)) continue;

      collided = true;
      break;
    }

    if (!collided) return;

    // do something when collided
  }

  public void removeEnemy(Enemy enemy) {
    this.children.remove(enemy);
  }

  private Optional<Player> getPlayer() {
    for (GameObject obj : Globals.currentScene.objects) {
      if (obj instanceof Player) return Optional.of((Player) obj);
    }

    return Optional.empty();
  }

  private void addEnemies(int amount) {
    PVector enemyScale = getEnemyScale();
    PVector gap = new PVector(1, -(enemyScale.y / 3));
    int columns = floor(width / (enemyScale.x + gap.x));

    PVector initialPos = this.position.copy();
    PVector pos = initialPos.copy();
    for (int i = 0; i < amount; ++i) {
      for (int j = 0; j < columns; ++j) {
        addEnemy(pos.copy());
        pos.x -= enemyScale.x + gap.x;
        ++i;
      }

      // go to the next row
      pos.y -= enemyScale.y + gap.y;
      pos.x = initialPos.x;
    }
  }

  private void addEnemy(PVector pos) {
    Enemy enemy = new Enemy();
    enemy.setScale(scale.x, scale.y);
    enemy.setPosition(pos);
    this.addChild(enemy);
  }

  private PVector getEnemyScale() {
    Enemy enemy = new Enemy();
    return enemy.scale.copy();
  }
}
