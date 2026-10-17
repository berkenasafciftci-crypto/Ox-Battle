// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and
// scroll gestures. You can also use WidgetTester to find child widgets, read
// text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_projesi/main.dart';

void main() {
  testWidgets('app starts with the custom text field and button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Nickname'), findsOneWidget);
    expect(find.text('Create an account'), findsOneWidget);
    expect(tester.getSize(find.byType(TextField)), const Size(320, 48));
  });

  testWidgets('text field fits a narrow screen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(320, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    expect(tester.getSize(find.byType(TextField)), const Size(272, 48));
    expect(tester.takeException(), isNull);
  });
}
