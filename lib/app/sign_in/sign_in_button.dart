import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/custom_elevated_button.dart';

/// This class creates a basic behavior definition of a Sign In Button.
class SignInButton extends CustomElevatedButton {
  SignInButton(
      {Key? key,
      required String text,
      required Color color,
      required Color textColor,
      required VoidCallback? onPressed})
      : super(
            key: key,
            child: Text(text),
            primary: color,
            onPrimary: textColor,
            onPressed: onPressed);
}
