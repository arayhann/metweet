import 'dart:convert';

import 'package:metweet/models/tweet.dart';
import 'package:metweet/providers/auth.dart';
import 'package:metweet/utils/http_exception.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;

final tweetProvider = StateNotifierProvider<TweetNotifier, List<Tweet>>((ref) {
  return TweetNotifier(authData: ref.watch(authProvider));
});

class TweetNotifier extends StateNotifier<List<Tweet>> {
  TweetNotifier({required this.authData}) : super([]);

  final AuthData authData;

  Future<void> createTweet(String tweet, String userId) async {
    final url =
        'https://rayhanasprilla-default-rtdb.asia-southeast1.firebasedatabase.app/tweets/$userId.json?auth=${authData.token}';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'tweet': tweet,
          'server_timestamp': {'.sv': 'timestamp'},
        }),
      );

      print(response.statusCode);

      if (response.statusCode >= 400) {
        var error =
            (jsonDecode(response.body) as Map<String, dynamic>)['error'];

        if (error == 'Auth token is expired') {
          error = 'Auth token is expired, please re-login';
        }

        throw HttpException(error);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateTweet(Tweet newTweet, String userId) async {
    final url =
        'https://rayhanasprilla-default-rtdb.asia-southeast1.firebasedatabase.app/tweets/$userId/${newTweet.id}.json?auth=${authData.token}';

    try {
      final response = await http.patch(
        Uri.parse(url),
        body: jsonEncode({
          'tweet': newTweet.tweet,
          'server_timestamp': newTweet.serverTimestamp,
        }),
      );

      if (response.statusCode >= 400) {
        var error =
            (jsonDecode(response.body) as Map<String, dynamic>)['error'];

        if (error == 'Auth token is expired') {
          error = 'Auth token is expired, please re-login';
        }

        throw HttpException(error);
      }

      print(response.statusCode);
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteTweet(Tweet newTweet, String userId) async {
    final url =
        'https://rayhanasprilla-default-rtdb.asia-southeast1.firebasedatabase.app/tweets/$userId/${newTweet.id}.json?auth=${authData.token}';

    try {
      final response = await http.delete(Uri.parse(url));

      print(response.statusCode);

      if (response.statusCode >= 400) {
        var error =
            (jsonDecode(response.body) as Map<String, dynamic>)['error'];

        if (error == 'Auth token is expired') {
          error = 'Auth token is expired, please re-login';
        }

        throw HttpException(error);
      }
    } catch (error) {
      throw error;
    }
  }
}
