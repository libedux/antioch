class Helpers {
  static String transformErrors(error) {
    if (error is List) {
      return error.join('\n').trim();
    } else {
      return error;
    }
  }
}
