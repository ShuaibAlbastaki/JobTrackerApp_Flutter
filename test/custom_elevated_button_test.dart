// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/custom_elevated_button.dart';

void main() {
  testWidgets("", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CustomElevatedButton(
        child: Text("tap me"),
      ),
    ));
    final button = find.byType(ElevatedButton);
    expect(button, findsOneWidget);
    expect(find.byType(RaisedButton), findsNothing);
    expect(find.text("tap me"), findsOneWidget);
  });
}
