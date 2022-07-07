import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/custom_elevated_button.dart';

void main() {
  testWidgets("", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomElevatedButton()));
  });
}
