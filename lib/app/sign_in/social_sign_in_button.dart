import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/custom_elevated_button.dart';

/// This class creates the design outline of the social sign in button used for Google.
class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton(
      {Key? key,
      required String text,
      required String assetName,
      required Color color,
      required Color textColor,
      required VoidCallback? onPressed})
      : super(
            key: key,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(assetName),
                Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                  ),
                ),
                Opacity(
                  opacity: 0.0,
                  child: Image.asset(assetName),
                ),
              ],
            ),
            primary: color,
            onPrimary: textColor,
            onPressed: onPressed);
}
