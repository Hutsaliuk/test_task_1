// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_1/radio_form_field.dart';

void main() {
  testWidgets('Radio form field smoke test', (WidgetTester tester) async {
    const firstElementTitle = 'Woman';
    const secondIconTile = Icons.man;
    const errorMessage = "You haven't selected any option!";

    const radioTiles = [
      Text(firstElementTitle),
      Icon(secondIconTile),
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
    expect(find.text(firstElementTitle), findsOneWidget);
    expect(find.byIcon(secondIconTile), findsOneWidget);

    // Validate Radio form field without choosing any tile
    radioFormKey.currentState?.validate();
    await tester.pump();

    // Verify that error message shown
    expect(find.text(errorMessage), findsOneWidget);

    //Tap and choose first radio tile
    await tester.tap(find.text(firstElementTitle));
    await tester.pump();

    // Validate Radio form field with choosing first tile
    radioFormKey.currentState?.validate();
    await tester.pump();

    // Verify that no error message anymore
    expect(find.text(errorMessage), findsNothing);
  });
}
