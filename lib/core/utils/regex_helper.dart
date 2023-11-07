class RegExHelper {
  static bool hasUpperCase(String value) {
    return RegExp(r"[A-Z]+").hasMatch(value);
  }

  static bool hasLowerCase(String value) {
    return RegExp(r"[a-z]+").hasMatch(value);
  }

  static bool hasNumber(String value) {
    return RegExp(r"[0-9]+").hasMatch(value);
  }

  static bool hasSpecialCharacter(String value) {
    return RegExp(r"[^A-Za-z0-9]+").hasMatch(value);
  }
}
