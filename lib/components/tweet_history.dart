import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:metweet/providers/auth.dart';
import 'package:metweet/providers/tweet_provider.dart';

class TweetHistory extends HookConsumerWidget {
  const TweetHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isLoadingGet = useState(true);
    final _listTweet = useState<List<Tweet>>([]);

    useEffect(() {
      ref.read(tweetProvider.notifier).getTweets().then((_) {
        _isLoadingGet.value = false;
        _listTweet.value = ref.read(tweetProvider);
      });

      return;
    }, []);
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
        _isLoadingGet.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _listTweet.value.length,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: Color(0x20C4C4C4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${DateFormat('dd MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(_listTweet.value[index].serverTimestamp))}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        _listTweet.value[index].tweet,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
              ),
      ],
    );
  }
}
