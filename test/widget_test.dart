// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and
// scroll gestures. You can also use WidgetTester to find child widgets, read
// text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_projesi/main.dart';
import 'package:test_projesi/screens/sign_up_screen.dart';

void main() {
  testWidgets('app starts on the sign-up route', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(SignUpScreen), findsOneWidget);
    expect(find.text('Nickname'), findsOneWidget);
    expect(find.text('Create an account'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(tester.getSize(find.byType(TextField).first), const Size(320, 48));
  });

  testWidgets('text field fits a narrow screen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(320, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    expect(tester.getSize(find.byType(TextField).first), const Size(280, 48));
    expect(tester.takeException(), isNull);
  });

  testWidgets('sign-in and home named routes are registered', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.pushNamed(AppRoutes.signIn);
    await tester.pumpAndSettle();
    expect(find.text('Sign In screen coming soon'), findsOneWidget);

    navigator.pushNamed(AppRoutes.home);
    await tester.pumpAndSettle();
    expect(find.text('Home screen coming soon'), findsOneWidget);
  });

  testWidgets('sign-up screen scrolls with all three input fields', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: SignUpScreen()));

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
