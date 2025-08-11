// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:a_cameras_example/main.dart';

void main() {
  testWidgets('Verify app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app bar is present
    expect(find.byType(AppBar), findsOneWidget);

    // Verify that the app bar title is present
    expect(find.text('Plugin example app'), findsOneWidget);

    // Verify that the floating action button is present
    expect(find.byType(OutlinedButton), findsOneWidget);
  });
}
