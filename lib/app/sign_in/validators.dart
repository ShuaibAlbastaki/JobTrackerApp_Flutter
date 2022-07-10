/// Abstract class for String validation.
abstract class StringValidator {
  bool isValid(String value);
}

/// Implementation class of the StringValidator to test for NonEmptyStringValidator that returns a bool.
class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

/// Constants for Email and Password validators.
class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = "Email can't be empty";
  final String invalidPasswordErrorText = "Password can't be empty";
}
