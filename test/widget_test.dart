// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_1/radio_form_field.dart';
import 'package:test_task_1/user.dart';

void main() {
  testWidgets('Radio form field smoke test', (WidgetTester tester) async {
    const firstUserName = 'Ivan';
    const firstUserAge = 25;
    const secondUserName = 'Petro';
    const secondUserAge = 32;

    const firstUser = User(firstUserName, firstUserAge);
    const secondUser = User(secondUserName, secondUserAge);
    const errorMessage = "You haven't selected any option!";

    const radioTiles = [
      firstUser,
      secondUser,
    ];

    String? validator(int? value) {
      return value == null ? errorMessage : null;
    }

    final radioFormKey = GlobalKey<FormFieldState>();

    // Build app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: RadioFormField(
        items: radioTiles,
        validatior: validator,
        radioFormKey: radioFormKey,
      ),
    ));

    // Verify that no error message shown and radio tiles presented.
    expect(find.text(errorMessage), findsNothing);
    expect(find.textContaining(firstUserName), findsOneWidget);
    expect(find.textContaining(secondUserName), findsOneWidget);

    // Validate Radio form field without choosing any tile
    radioFormKey.currentState?.validate();
    await tester.pump();

    // Verify that error message shown
    expect(find.text(errorMessage), findsOneWidget);

    //Tap and choose first radio tile
    await tester.tap(find.textContaining(firstUserName));
    await tester.pump();

    // Validate Radio form field with choosing first tile
    radioFormKey.currentState?.validate();
    await tester.pump();

    // Verify that no error message anymore
    expect(find.text(errorMessage), findsNothing);
  });
}
