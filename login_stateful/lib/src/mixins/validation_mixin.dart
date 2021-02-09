class ValidationMixin {
  String validateEmail(String value) {
    if (value.length < 4) {
      return 'Please Enter a valid password';
    }

    return null;
  }

  String validatePassword(String value) {
    if (value.length < 4) {
      return 'Please Enter a valid password';
    }

    return null;
  }
}
