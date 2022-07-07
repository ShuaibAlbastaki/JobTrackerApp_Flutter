import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key,
      this.child,
      this.primary,
      this.onPrimary,
      this.height = 48,
      this.borderRadius = 6,
      this.onPressed})
      : super(key: key);

  final Widget? child;
  final Color? primary;
  final Color? onPrimary;
  final double height;
  final double borderRadius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: primary,
            onPrimary: onPrimary,
            onSurface: primary, //for disabled button color.
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
            textStyle: const TextStyle(
              fontSize: 16,
            )),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
