import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:metweet/components/custom_button/bordered_button.dart';
import 'package:metweet/components/custom_button/fill_button.dart';
import 'package:metweet/components/tweet_history.dart';
import 'package:metweet/main.dart';
import 'package:metweet/pages/add_tweet_page.dart';
import 'package:metweet/providers/auth.dart';
import 'package:metweet/utils/page_transition_builder.dart';
import 'package:metweet/utils/themes.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: scaffoldBackgroundColor,
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Your Profile',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      'User Id',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      ref.read(authProvider).userId ??
                                          'user id',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      ref.read(authProvider).email ?? 'email',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 34,
                                    ),
                                    FillButton(
                                      text: 'Close',
                                      onTap: () => Navigator.of(context).pop(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.person_outline,
                            color: primaryColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: scaffoldBackgroundColor,
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Are you sure to Sign Out',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 34,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: BorderedButton(
                                            text: 'Cancel',
                                            onTap: () =>
                                                Navigator.of(context).pop(),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: FillButton(
                                            text: 'Sign Out',
                                            onTap: () {
                                              ref
                                                  .read(authProvider.notifier)
                                                  .logout();
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      createRoute(
                                                          page: MainPage()),
                                                      (route) => false);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0x20C4C4C4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                      ),
                      Positioned(
                        top: -40,
                        left: 10,
                        child: Image.asset(
                          'assets/images/img-login.png',
                          width: 300,
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        right: 20,
                        left: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Let's Start Twittin' Now!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 80,
                              child: FillButton(
                                text: 'Create Tweet!',
                                onTap: () {
                                  Navigator.of(context)
                                      .push(createRoute(page: AddTweetPage()));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TweetHistory(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
