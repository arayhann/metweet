import 'package:flutter/material.dart';
import 'package:metweet/components/custom_button/bordered_button.dart';
import 'package:metweet/components/custom_button/fill_button.dart';
import 'package:metweet/pages/sign_in_page.dart';
import 'package:metweet/pages/sign_up_page.dart';
import 'package:metweet/utils/page_transition_builder.dart';
import 'package:metweet/utils/themes.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/img-blur.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sign In, and',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Let’s tweeting your self!',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/img-login.png',
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  FillButton(
                    text: 'Sign In',
                    onTap: () {
                      Navigator.of(context).push(
                        createRoute(
                          page: SignInPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BorderedButton(
                    text: 'Sign Up',
                    onTap: () {
                      Navigator.of(context).push(
                        createRoute(
                          page: SignUpPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By clicking to continue, you\'re agreeing to our ',
                      children: [
                        TextSpan(
                          text: 'Terms and Condition ',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: 'and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
