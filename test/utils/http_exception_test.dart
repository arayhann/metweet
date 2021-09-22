import 'package:flutter_test/flutter_test.dart';
import 'package:metweet/utils/http_exception.dart';

void main() {
  group('getAuthError', () {
    test('should return \"This email address is already in use.\"', () {
      final error = 'EMAIL_EXISTS';

      final parsedError = HttpException.getAuthError(error);

      expect(parsedError, 'This email address is already in use.');
    });

    test('should return \"This is not a valid email address.\"', () {
      final error = 'INVALID_EMAIL';

      final parsedError = HttpException.getAuthError(error);

      expect(parsedError, 'This is not a valid email address.');
    });

    test('should return \"This password is too weak.\"', () {
      final error = 'WEAK_PASSWORD';

      final parsedError = HttpException.getAuthError(error);

      expect(parsedError, 'This password is too weak.');
    });

    test('should return \"Could not found a user with that email\"', () {
      final error = 'EMAIL_NOT_FOUND';

      final parsedError = HttpException.getAuthError(error);

      expect(parsedError, 'Could not found a user with that email');
    });

    test('should return \"Invalid password.\"', () {
      final error = 'INVALID_PASSWORD';

      final parsedError = HttpException.getAuthError(error);

      expect(parsedError, 'Invalid password.');
    });

    test('should return \"Authenticate failed. Please try again later.\"', () {
      final error = 's;lakd;lksajd;lsa';

      final parsedError = HttpException.getAuthError(error);

      expect(parsedError, 'Authenticate failed. Please try again later.');
    });
  });
}
