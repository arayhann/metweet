import 'dart:convert';

import 'package:metweet/providers/auth.dart';
import 'package:metweet/utils/http_exception.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;

class Tweet {
  Tweet({
    required this.id,
    required this.serverTimestamp,
    required this.tweet,
  });

  String id;
  int serverTimestamp;
  String tweet;

  factory Tweet.fromJson(Map<String, dynamic> json) => Tweet(
        id: json["id"],
        serverTimestamp: json["server_timestamp"],
        tweet: json["tweet"],
      );
}

final tweetProvider = StateNotifierProvider<TweetNotifier, List<Tweet>>((ref) {
  return TweetNotifier(authData: ref.watch(authProvider));
});

class TweetNotifier extends StateNotifier<List<Tweet>> {
  TweetNotifier({required this.authData}) : super([]);

  final AuthData authData;

  Future<void> createTweet(String tweet) async {
    final url =
        'https://rayhanasprilla-default-rtdb.asia-southeast1.firebasedatabase.app/tweets.json?auth=${authData.token}';

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

  Future<void> updateTweet(Tweet newTweet) async {
    final url =
        'https://rayhanasprilla-default-rtdb.asia-southeast1.firebasedatabase.app/tweets/${newTweet.id}.json?auth=${authData.token}';

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

  Future<void> deleteTweet(Tweet newTweet) async {
    final url =
        'https://rayhanasprilla-default-rtdb.asia-southeast1.firebasedatabase.app/tweets/${newTweet.id}.json?auth=${authData.token}';

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

  Future<void> getTweets() async {
    final url =
        'https://rayhanasprilla-default-rtdb.asia-southeast1.firebasedatabase.app/tweets.json?auth=${authData.token}';

    try {
      final response = await http.get(Uri.parse(url));

      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;

      final List<Tweet> loadedData = [];

      extractedData.forEach((key, value) {
        loadedData.add(
          Tweet(
            id: key,
            serverTimestamp: value['server_timestamp'],
            tweet: value['tweet'],
          ),
        );
      });

      loadedData.sort((a, b) => b.serverTimestamp.compareTo(a.serverTimestamp));

      state = loadedData;
    } catch (error) {
      throw error;
    }
  }
}
