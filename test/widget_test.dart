// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and
// scroll gestures. You can also use WidgetTester to find child widgets, read
// text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_projesi/main.dart';
import 'package:test_projesi/screens/sign_in_screen.dart';
import 'package:test_projesi/screens/sign_up_screen.dart';

void main() {
  testWidgets('app starts on the sign-up route', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(SignUpScreen), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
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
    expect(find.byType(SignInScreen), findsOneWidget);
    expect(find.text('Nickname'), findsNothing);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Sign in with Apple'), findsOneWidget);
    expect(find.text('Sign in with Google'), findsOneWidget);
    expect(find.text('Sign in with SMS'), findsOneWidget);

    navigator.pushNamed(AppRoutes.home);
    await tester.pumpAndSettle();
    expect(find.text('Homepage screen coming soon'), findsOneWidget);
  });

  testWidgets('sign-in fields use email and hidden password input', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SignInScreen()));

    final fields = tester
        .widgetList<TextField>(find.byType(TextField))
        .toList();
    expect(fields, hasLength(2));
    expect(fields[0].keyboardType, TextInputType.emailAddress);
    expect(fields[0].obscureText, isFalse);
    expect(fields[1].obscureText, isTrue);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('sign-in screen scrolls on a short display', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: SignInScreen()));

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -400),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
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

  testWidgets('sign-up login text opens sign-in', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final login = find.byWidgetPredicate(
      (widget) =>
          widget is RichText && widget.text.toPlainText().endsWith('LOGIN'),
    );
    await tester.ensureVisible(login);
    final text = tester.widget<RichText>(login).text.toPlainText();
    final renderParagraph = tester.renderObject<RenderParagraph>(login);
    final loginBox = renderParagraph
        .getBoxesForSelection(
          TextSelection(
            baseOffset: text.length - 'LOGIN'.length,
            extentOffset: text.length,
          ),
        )
        .single;
    await tester.tapAt(tester.getTopLeft(login) + loginBox.toRect().center);
    await tester.pumpAndSettle();

    expect(find.byType(SignInScreen), findsOneWidget);
  });

  testWidgets('sign-up stays on screen and shows error for empty fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Create an account'));
    await tester.pumpAndSettle();

    expect(find.text('Lütfen boşlukları doldurun.'), findsOneWidget);
    expect(find.byType(SignUpScreen), findsOneWidget);
  });

  testWidgets('sign-up opens homepage when all fields are filled', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'nickname');
    await tester.enterText(fields.at(1), 'email@example.com');
    await tester.enterText(fields.at(2), 'password');
    await tester.tap(find.text('Create an account'));
    await tester.pumpAndSettle();

    expect(find.text('Homepage screen coming soon'), findsOneWidget);
  });

  testWidgets('sign-up social buttons open sign-in', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final appleButton = find.text('Sign up with Apple');
    await tester.ensureVisible(appleButton);
    await tester.tap(appleButton);
    await tester.pumpAndSettle();

    expect(find.byType(SignInScreen), findsOneWidget);
  });
}
