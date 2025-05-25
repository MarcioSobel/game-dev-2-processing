import java.util.HashMap;

public class VictoryScene extends GameScene {
  public VictoryScene() {
    super();
    this.addTitle();
    this.addMenu();
  }

  private void addTitle() {
    Text gameName = new Text("You won!");
    gameName
      .setFontSize(96)
      .setPosition(0, 120)
      .centerX()
      .setAnchor(AnchorPosition.MIDDLE_CENTER);

    this.addObject(gameName);
  }

  private void addMenu() {
    VictoryMenu menu = new VictoryMenu();
    this.addObject(menu);
  }
}

private class VictoryMenu extends GameObject {
  HashMap<Integer, Text> options;
  int selectedOption = 0;
  int optionAmount = 0;

  public VictoryMenu() {
    super();
    this.options = new HashMap<Integer, Text>();
    this.setPosition(width / 2, height / 2);
    this.setScale(0, 0);

    this
      .addOption("Go to main menu")
      .addOption("Restart")
      .addOption("Exit game");
  }

  public VictoryMenu addOption(String label) {
    Text option = new Text(label).setFontSize(32);
    option.setPosition(scale.x, scale.y).setAnchor(AnchorPosition.MIDDLE_CENTER);

    options.put(optionAmount++, option);
    this.addChild(option);

    this.setScale(1, scale.y - option.textBoxSize.y - 20);
    return this;
  }

  void update() {
    if (!keyPressed) Utils.isKeyDown = false;

    if (keyPressed) {
      if (!Utils.isKeyDown) changeOption();
      Utils.isKeyDown = true;
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
      Globals.game.setScene(new MenuScene());
      break;
    case 1:
      Globals.game.setScene(new MainGameScene());
      break;
    case 2:
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
