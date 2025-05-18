public static class Utils {
   // clamp will make sure the value is at least min and at most max
   public static int clamp(int x, int min, int max) {
     return Math.max(min, Math.min(max, x));
   }
}
