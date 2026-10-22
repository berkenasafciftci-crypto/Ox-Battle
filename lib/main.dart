import 'package:flutter/material.dart';

import 'screens/main_layout_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ox-Battle',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.signUp,
      routes: AppRoutes.routes,
    );
  }
}

abstract final class AppRoutes {
  static const signUp = '/signup';
  static const signIn = '/signin';
  static const home = '/home';

  static final Map<String, WidgetBuilder> routes =
      Map<String, WidgetBuilder>.unmodifiable({
        signUp: (_) => const SignUpScreen(),
        signIn: (_) => const SignInScreen(),
        home: (_) => const MainLayoutScreen(),
      });
}
