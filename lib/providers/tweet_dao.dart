import 'package:firebase_database/firebase_database.dart';

class TweetDao {
  final DatabaseReference _tweetRef = FirebaseDatabase.instance.reference();

  Query getTweetQuery() {
    return _tweetRef;
  }
}
