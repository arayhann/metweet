class Tweet {
  Tweet({
    required this.id,
    required this.serverTimestamp,
    required this.tweet,
  });

  String id;
  int serverTimestamp;
  String tweet;

  factory Tweet.fromJson(String id, Map<dynamic, dynamic> json) => Tweet(
        id: id,
        serverTimestamp: json["server_timestamp"],
        tweet: json["tweet"],
      );

  static List<Tweet> parseTweets(Map<dynamic, dynamic> json) {
    final List<Tweet> tweets = [];

    json.forEach((key, value) {
      tweets.add(
        Tweet.fromJson(key, value),
      );
    });

    tweets.sort((a, b) => b.serverTimestamp.compareTo(a.serverTimestamp));

    return tweets;
  }
}
