import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:metweet/models/tweet.dart';
import 'package:metweet/pages/edit_tweet_page.dart';
import 'package:metweet/providers/tweet_dao.dart';
import 'package:metweet/utils/page_transition_builder.dart';

class TweetHistory extends HookWidget {
  final String userId;
  const TweetHistory(this.userId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tweetDao = useState(TweetDao());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Tweet',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          'Your tweeting history',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          color: Colors.white,
        ),
        const SizedBox(
          height: 12,
        ),
        StreamBuilder(
          stream: _tweetDao.value.getTweetQuery().onValue,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                children: <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ],
              );
            } else {
              if (snapshot.connectionState == ConnectionState.active) {
                final json =
                    (snapshot.data as Event).snapshot.value['tweets'][userId];

                if (json == null) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.flutter_dash_outlined,
                          color: Colors.white,
                          size: 50,
                        ),
                        Text(
                          'No Tweets Yet',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final loadedData = Tweet.parseTweets(json);

                return ListView.builder(
                  itemCount: loadedData.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: Color(0x20C4C4C4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${DateFormat('dd MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(loadedData[index].serverTimestamp))}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              loadedData[index].tweet,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(createRoute(
                              page: EditTweetPage(loadedData[index])));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ]),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          },
        ),
      ],
    );
  }
}
