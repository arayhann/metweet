class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
  }

  static String getAuthError(String error) {
    var errorMessage = 'Authenticate failed. Please try again later.';
    if (error.contains('EMAIL_EXISTS')) {
      errorMessage = 'This email address is already in use.';
    } else if (error.contains('INVALID_EMAIL')) {
      errorMessage = 'This is not a valid email address.';
    } else if (error.contains('WEAK_PASSWORD')) {
      errorMessage = 'This password is too weak.';
    } else if (error.contains('EMAIL_NOT_FOUND')) {
      errorMessage = 'Could not found a user with that email';
    } else if (error.contains('INVALID_PASSWORD')) {
      errorMessage = 'Invalid password.';
    }
    return errorMessage;
  }
}
