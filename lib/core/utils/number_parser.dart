class NumberParser {
  static int intFromDoubleString(String? stringDouble) {
    return double.tryParse("$stringDouble")?.toInt() ?? 0;
  }

  static int intFromString(String? string) {
    return int.tryParse("$string") ?? 0;
  }

  static double doubleFromString(String? string) {
    return double.tryParse("$string") ?? 0;
  }

  static String twoDecimalDigit(String? string) {
    return double.tryParse("$string")!.toStringAsFixed(2);
  }
}
