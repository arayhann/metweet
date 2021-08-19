import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:metweet/utils/http_exception.dart';

class AuthData {
  String? token;
  String? userId;
  String? email;
  DateTime? expiryDate;

  AuthData({
    this.token,
    this.userId,
    this.email,
    this.expiryDate,
  });
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthData>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthData> {
  AuthNotifier() : super(AuthData());

  Future<void> signUp(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDdg7e5mu_U7oStj7dFOrtMqPZ6snvbheA';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      final authData = AuthData(
        token: responseData['idToken'],
        userId: responseData['localId'],
        email: responseData['email'],
        expiryDate: DateTime.now().add(
          Duration(
            seconds: int.parse(responseData['expiresIn']),
          ),
        ),
      );

      state = authData;

      var box = await Hive.openBox('metweet');
      box.put('token', authData.token);
      box.put('user_id', authData.userId);
      box.put('expiry_date', authData.expiryDate);
      box.put('email', authData.email);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDdg7e5mu_U7oStj7dFOrtMqPZ6snvbheA';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = jsonDecode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      final authData = AuthData(
        token: responseData['idToken'],
        userId: responseData['localId'],
        email: responseData['email'],
        expiryDate: DateTime.now().add(
          Duration(
            seconds: int.parse(responseData['expiresIn']),
          ),
        ),
      );

      state = authData;

      var box = await Hive.openBox('metweet');
      box.put('token', authData.token);
      box.put('user_id', authData.userId);
      box.put('expiry_date', authData.expiryDate);
      box.put('email', authData.email);
    } catch (error) {
      throw error;
    }
  }

  bool tryAutoLogin() {
    final String? token = Hive.box('metweet').get('token');
    final String? userId = Hive.box('metweet').get('user_id');
    final String? email = Hive.box('metweet').get('email');
    final DateTime? expiryDate = Hive.box('metweet').get('expiry_date');

    if (token == null ||
        userId == null ||
        expiryDate == null ||
        email == null) {
      return false;
    }
    state = AuthData(
      token: token,
      userId: userId,
      expiryDate: expiryDate,
      email: email,
    );
    return true;
  }

  void logout() {
    state = AuthData();
    final box = Hive.box('metweet');
    box.delete('token');
    box.delete('user_id');
    box.delete('email');
    box.delete('expiry_date');
  }
}
