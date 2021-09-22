class FieldValidator {
  static String? validateEmail(String? value) {
    if (value == null) {
      return 'Enter Email!';
    }

    if (value.isEmpty) {
      return 'Enter Email!';
    }

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (!emailValid) {
      return 'Enter Valid Email!';
    }

    return null;
  }

  static String? validatePassword(String? value, {String? matchPassword}) {
    if (value == null) {
      return 'Enter Password!';
    }

    if (value.isEmpty) {
      return 'Enter Password!';
    }

    if (value.length < 7) {
      return 'Password must be more than 6 character';
    }

    if (matchPassword != null) {
      if (value != matchPassword) {
        return 'Passwords do not match!';
      }
    }

    return null;
  }

  static String? validateTweet(String? value) {
    if (value == null) {
      return 'Enter Tweet!';
    }

    if (value.isEmpty) {
      return 'Enter Tweet!';
    }

    if (value.length > 280) {
      return 'Tweet must be less than 280 character';
    }

    return null;
  }
}
