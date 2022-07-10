import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/custom_elevated_button.dart';

/// This class is a template for the submit form behavior.
class FormSubmitButton extends CustomElevatedButton {
  FormSubmitButton({
    Key? key,
    required String text,
    VoidCallback? onPressed,
  }) : super(
            key: key,
            child: Text(
              text,
            ),
            primary: Colors.green,
            onPrimary: Colors.white,
            onPressed: onPressed);
}
