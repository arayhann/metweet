import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:metweet/models/tweet.dart';

void main() {
  test('Parse Tweet json to Tweet Object', () {
    final json = {
      '-MkBbNKXrP0KK2Gr-3AV': {
        'server_timestamp': 1632299222371,
        'tweet': 'Tweet from test account'
      }
    };
    final expectedTweet = Tweet(
      id: '-MkBbNKXrP0KK2Gr-3AV',
      serverTimestamp: 1632299222371,
      tweet: 'Tweet from test account',
    );

    final resultTweet = Tweet.fromJson(json.keys.first, json.values.first);

    expect(resultTweet.id, expectedTweet.id);
    expect(resultTweet.serverTimestamp, expectedTweet.serverTimestamp);
    expect(resultTweet.tweet, expectedTweet.tweet);
  });

  test('Sort Tweets json to Tweets object by date', () {
    final json = {
      '-MkBbNKXrP0KK2Gr-3AV': {
        'server_timestamp': 1632299222371,
        'tweet': 'Tweet from test account'
      },
      '-MkBbutZtRU1O7AmbvlP': {
        'server_timestamp': 1632299363941,
        'tweet': 'Second tweet from test account'
      },
    };

    final sortedTweet = Tweet.parseTweets(json);

    expect(sortedTweet.length, 2);
    expect(sortedTweet[0].id, '-MkBbutZtRU1O7AmbvlP');
  });
}
