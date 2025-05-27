public static class Utils {
  static int defaultFontSize = 10;
  static int defaultStrokeWeight = 4;
  static boolean isKeyDown = false;
  
  // clamp will make sure the value is at least min and at most max
  public static int clamp(int x, int min, int max) {
    return Math.max(min, Math.min(max, x));
  }
}

public static class Globals {
   static Game game;
   static GameScene currentScene;
   static PApplet processing;
}
