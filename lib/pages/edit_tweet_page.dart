import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:metweet/components/custom_button/fill_button.dart';
import 'package:metweet/components/custom_field/bordered_text_field.dart';
import 'package:metweet/components/pop_app_bar.dart';
import 'package:metweet/models/tweet.dart';
import 'package:metweet/providers/auth.dart';
import 'package:metweet/providers/tweet_provider.dart';
import 'package:metweet/utils/field_validator.dart';
import 'package:metweet/utils/http_exception.dart';

class EditTweetPage extends HookConsumerWidget {
  final Tweet tweet;
  const EditTweetPage(this.tweet, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = useState<GlobalKey<FormState>>(GlobalKey());
    final _tweetTextEditingController =
        useTextEditingController(text: tweet.tweet);
    final _tweetCount = useState(0);
    final _isLoading = useState(false);
    return Scaffold(
      body: Form(
        key: _formKey.value,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PopAppBar(
                  title: 'Edit Tweet',
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit or Delete Your Tweet',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
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
                        validator: FieldValidator.validateTweet,
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
                              text: 'Edit Tweet',
                              leading: Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                              ),
                              onTap: () async {
                                if (!_formKey.value.currentState!.validate()) {
                                  return;
                                }

                                final newTweet =
                                    _tweetTextEditingController.text;

                                if (newTweet.isEmpty) {
                                  return;
                                }
                                _isLoading.value = true;

                                try {
                                  await ref
                                      .read(tweetProvider.notifier)
                                      .updateTweet(
                                          Tweet(
                                            id: tweet.id,
                                            serverTimestamp:
                                                tweet.serverTimestamp,
                                            tweet: newTweet,
                                          ),
                                          ref.read(authProvider).userId!);

                                  Navigator.of(context).pop();
                                } on HttpException catch (error) {
                                  Fluttertoast.showToast(msg: error.toString());
                                } catch (error) {
                                  Fluttertoast.showToast(msg: error.toString());
                                }
                                _isLoading.value = false;
                              },
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      _isLoading.value
                          ? SizedBox.shrink()
                          : FillButton(
                              text: 'Delete Tweet',
                              color: Colors.red,
                              leading: Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                              ),
                              onTap: () async {
                                _isLoading.value = true;

                                try {
                                  await ref
                                      .read(tweetProvider.notifier)
                                      .deleteTweet(tweet,
                                          ref.read(authProvider).userId!);

                                  Navigator.of(context).pop();
                                } on HttpException catch (error) {
                                  Fluttertoast.showToast(msg: error.toString());
                                } catch (error) {
                                  Fluttertoast.showToast(msg: error.toString());
                                }
                                _isLoading.value = false;
                              },
                            ),
                    ],
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
