import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:metweet/providers/tweet_provider.dart';
import 'package:metweet/utils/http_exception.dart';

import 'custom_button/fill_button.dart';
import 'custom_field/bordered_text_field.dart';

class TweetPost extends HookConsumerWidget {
  const TweetPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _tweetTextEditingController = useTextEditingController();
    final _tweetCount = useState(0);
    final _isLoading = useState(false);
    return Column(
      children: [
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
        _isLoading.value
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
                  _isLoading.value = true;

                  try {
                    await ref.read(tweetProvider.notifier).createTweet(tweet);
                  } on HttpException catch (error) {
                    Fluttertoast.showToast(msg: error.toString());
                  } catch (error) {
                    Fluttertoast.showToast(msg: error.toString());
                  }
                  _isLoading.value = false;
                },
              ),
      ],
    );
  }
}
