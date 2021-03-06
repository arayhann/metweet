import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:metweet/components/custom_button/fill_button.dart';
import 'package:metweet/components/custom_field/bordered_text_field.dart';
import 'package:metweet/components/pop_app_bar.dart';
import 'package:metweet/pages/home_page.dart';
import 'package:metweet/pages/sign_up_page.dart';
import 'package:metweet/providers/auth.dart';
import 'package:metweet/utils/field_validator.dart';
import 'package:metweet/utils/http_exception.dart';
import 'package:metweet/utils/page_transition_builder.dart';
import 'package:metweet/utils/themes.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authData = useState({
      'email': '',
      'password': '',
    });
    final _formKey = useState<GlobalKey<FormState>>(GlobalKey());

    final _passwordFocusNode = useFocusNode();

    final _isLoading = useState(false);

    final _submit = useMemoized(
        () => () async {
              if (!_formKey.value.currentState!.validate()) {
                return;
              }

              _formKey.value.currentState!.save();

              _isLoading.value = true;

              try {
                await ref.read(authProvider.notifier).signIn(
                      _authData.value['email']!,
                      _authData.value['password']!,
                    );

                Navigator.of(context).pushAndRemoveUntil(
                    createRoute(page: HomePage()), (route) => false);
              } on HttpException catch (error) {
                var errorMessage = HttpException.getAuthError(error.toString());
                Fluttertoast.showToast(msg: errorMessage);
              } catch (error) {
                const errorMessage =
                    'Could not authenticate you. Please try again later.';
                Fluttertoast.showToast(msg: errorMessage);
              }

              _isLoading.value = false;
            },
        []);

    return Scaffold(
      body: Form(
        key: _formKey.value,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                PopAppBar(
                  title: 'Sign In',
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome Back !',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BorderedFormField(
                        hint: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: FieldValidator.validateEmail,
                        onSaved: (value) {
                          if (value != null) {
                            _authData.value['email'] = value;
                          }
                        },
                        onFieldSubmitted: (value) {
                          _passwordFocusNode.requestFocus();
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      BorderedFormField(
                        hint: 'Password',
                        obscureText: true,
                        maxLine: 1,
                        focusNode: _passwordFocusNode,
                        validator: FieldValidator.validatePassword,
                        onSaved: (value) {
                          if (value != null) {
                            _authData.value['password'] = value;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 34,
                      ),
                      _isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : FillButton(
                              text: 'Sign In',
                              onTap: _submit,
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Don\'t have an account?',
                          children: [
                            TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context)
                                      .push(createRoute(page: SignUpPage()));
                                },
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
        ),
      ),
    );
  }
}
