import java.util.HashMap;

public class MenuScene extends GameScene {
  public MenuScene() {
    super();
    this.addTitle();
    this.addMenu();
  }

  private void addTitle() {
    Text gameName = new Text("invasores do mal");
    gameName
      .setFontSize(96)
      .setPosition(0, 120)
      .centerX()
      .setAnchor(AnchorPosition.MIDDLE_CENTER);

    this.addObject(gameName);
  }

  private void addMenu() {
    Menu menu = new Menu();
    this.addObject(menu);
  }
}

private class Menu extends GameObject {
  HashMap<Integer, Text> options;
  int selectedOption = 0;
  int optionAmount = 0;
  boolean keyDown = false;

  public Menu() {
    super();
    this.options = new HashMap<Integer, Text>();
    this.setPosition(width / 2, height / 2);
    this.setScale(0, 0);

    this
      .addOption("Start game")
      .addOption("Exit game");
  }

  public Menu addOption(String label) {
    Text option = new Text(label).setFontSize(32);
    option.setPosition(scale.x, scale.y).setAnchor(AnchorPosition.MIDDLE_CENTER);

    options.put(optionAmount++, option);
    this.addChild(option);

    this.setScale(1, scale.y - option.textBoxSize.y - 20);
    return this;
  }

  void update() {
    if (!keyPressed) keyDown = false;

    if (keyPressed) {
      if (!keyDown) changeOption();
      keyDown = true;
    }

    for (int i = 0; i < optionAmount; ++i) {
      Text option = options.get(i);
      if (selectedOption == i) option.setColor(255, 255, 255);
      else option.setColor(100, 100, 100);
    }
  }

  private void changeOption() {
    if (keyCode == UP) previousOption();
    if (keyCode == DOWN) nextOption();
    if (keyCode == RIGHT) selectOption();
  }

  private void selectOption() {
    switch (selectedOption) {
    case 0:
      Globals.game.setScene(new MainGameScene());
      break;
    case 1:
      exit();
      break;
    }
  }

  private void nextOption() {
    selectedOption += 1;
    selectedOption %= optionAmount;
  }

  private void previousOption() {
    selectedOption -= 1;
    if (selectedOption < 0) selectedOption = optionAmount - 1;
  }
}
