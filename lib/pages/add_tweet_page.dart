import 'package:flutter/material.dart';
import 'package:metweet/components/pop_app_bar.dart';
import 'package:metweet/components/tweet_post.dart';

class AddTweetPage extends StatelessWidget {
  const AddTweetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PopAppBar(
                  title: 'Add Tweet',
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TweetPost(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
