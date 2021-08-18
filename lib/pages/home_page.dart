import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:metweet/components/custom_button/fill_button.dart';
import 'package:metweet/components/custom_field/bordered_text_field.dart';
import 'package:metweet/providers/tweet_provider.dart';
import 'package:metweet/utils/themes.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _tweetTextEditingController = useTextEditingController();
    final _tweetCount = useState(0);
    final _isLoadingPost = useState(false);
    final _isLoadingGet = useState(true);
    final _listTweet = useState<List<Tweet>>([]);

    useEffect(() {
      ref.read(tweetProvider.notifier).getTweets().then((_) {
        _isLoadingGet.value = false;
        _listTweet.value = ref.read(tweetProvider);
      });
    }, []);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/img-logo.png',
                      height: 10,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.person_outline,
                            color: primaryColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.logout,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Create Tweet',
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
                  'Start tweeting your self',
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
                BorderedFormField(
                  hint: 'Tweet',
                  maxLine: 5,
                  textEditingController: _tweetTextEditingController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(280),
                  ],
                  onChanged: (value) {
                    _tweetCount.value = value.length;
                  },
                ),
                const SizedBox(
                  height: 4,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${_tweetCount.value} / 280 character',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                _isLoadingPost.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : FillButton(
                        text: 'Tweet!',
                        leading: Icon(
                          Icons.add_box_outlined,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          final tweet = _tweetTextEditingController.text;

                          if (tweet.isEmpty) {
                            return;
                          }
                          _isLoadingPost.value = true;
                          await ref
                              .read(tweetProvider.notifier)
                              .createTweet(tweet);
                          _isLoadingPost.value = false;
                        },
                      ),
                const SizedBox(
                  height: 40,
                ),
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
            ),
          ),
        ),
      ),
    );
  }
}
