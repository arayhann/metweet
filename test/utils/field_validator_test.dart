import 'package:flutter_test/flutter_test.dart';
import 'package:metweet/utils/field_validator.dart';

void main() {
  group('validateEmail', () {
    test('Null Email Test', () {
      final result = FieldValidator.validateEmail(null);
      expect(result, 'Enter Email!');
    });

    test('Empty Email Test', () {
      final result = FieldValidator.validateEmail('');
      expect(result, 'Enter Email!');
    });

    test('Invalid Email Test', () {
      final result = FieldValidator.validateEmail('test.com');
      expect(result, 'Enter Valid Email!');
    });

    test('Valid Email Test', () {
      final result = FieldValidator.validateEmail('test@test.com');
      expect(result, null);
    });
  });

  group('validatePassword', () {
    test('Null Password Test', () {
      final result = FieldValidator.validatePassword(null);
      expect(result, 'Enter Password!');
    });

    test('Empty Password Test', () {
      final result = FieldValidator.validatePassword('');
      expect(result, 'Enter Password!');
    });

    test('Invalid Password Test', () {
      final result = FieldValidator.validatePassword('test');
      expect(result, 'Password must be more than 6 character');
    });

    test('Valid Password Test', () {
      final result = FieldValidator.validatePassword('testtest');
      expect(result, null);
    });

    test('Not Match Password Test', () {
      final result = FieldValidator.validatePassword('testtest',
          matchPassword: 'testtest123');
      expect(result, 'Passwords do not match!');
    });
  });

  group('validateTweet', () {
    test('Null Tweet Test', () {
      final result = FieldValidator.validateTweet(null);
      expect(result, 'Enter Tweet!');
    });

    test('Empty Tweet Test', () {
      final result = FieldValidator.validateTweet('');
      expect(result, 'Enter Tweet!');
    });

    test('Invalid Tweet Test', () {
      final result = FieldValidator.validateTweet(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sapien faucibus et molestie ac. Morbi enim nunc faucibus a pellentesque sit amet porttitor eget. Odio ut sem nulla pharetra. Condimentum vitae sapien pellentesque habitant morbi tristique. Et netus et malesuada fames ac turpis egestas sed. Convallis a cras semper auctor neque vitae tempus. Eu sem integer vitae justo eget magna fermentum iaculis. Est sit amet facilisis magna. Bibendum neque egestas congue quisque. Euismod nisi porta lorem mollis aliquam. Mauris vitae ultricies leo integer malesuada nunc.');
      expect(result, 'Tweet must be less than 280 character');
    });

    test('Valid Password Test', () {
      final result = FieldValidator.validateTweet('Test Tweet');
      expect(result, null);
    });
  });
}
