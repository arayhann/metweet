import 'dart:convert';

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
  return TweetNotifier();
});

class TweetNotifier extends StateNotifier<List<Tweet>> {
  TweetNotifier() : super([]);

  Future<void> createTweet(String tweet) async {
    const url =
        'https://rayhanasprilla-default-rtdb.asia-southeast1.firebasedatabase.app/tweets.json';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'tweet': tweet,
          'server_timestamp': {'.sv': 'timestamp'},
        }),
      );

      print(response.statusCode);
    } catch (error) {
      throw error;
    }
  }

  Future<void> getTweets() async {
    const url =
        'https://rayhanasprilla-default-rtdb.asia-southeast1.firebasedatabase.app/tweets.json';

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

      state = loadedData;
    } catch (error) {
      throw error;
    }
  }
}
