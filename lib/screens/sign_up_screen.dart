import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/social_auth_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final TapGestureRecognizer _loginTapRecognizer;
  bool _showEmptyFieldsError = false;

  @override
  void initState() {
    super.initState();
    _loginTapRecognizer = TapGestureRecognizer()
      ..onTap = () => Navigator.pushNamed(context, '/signin');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _loginTapRecognizer.dispose();
    super.dispose();
  }

  void _createAccount() {
    final hasEmptyField =
        _usernameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty;

    setState(() {
      _showEmptyFieldsError = hasEmptyField;
    });

    if (!hasEmptyField) {
      Navigator.pushNamed(context, '/home');
    }
  }

  void _openSignIn() {
    Navigator.pushNamed(context, '/signin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final contentWidth = (constraints.maxWidth - 40).clamp(0.0, 320.0);

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          width: contentWidth,
                          child: Column(
                            children: [
                              const SizedBox(height: 48),
                              const Text(
                                'Welcome to Ox-Battle',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF263038),
                                  fontFamily: 'Nunito',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 54),
                              CustomTextField(
                                hintText: 'Username',
                                controller: _usernameController,
                                prefixIcon: Image.asset(
                                  'assets/images/figma/signup_user.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                hintText: 'Email',
                                controller: _emailController,
                                prefixIcon: Image.asset(
                                  'assets/images/figma/signup_email.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                hintText: 'Password',
                                controller: _passwordController,
                                prefixIcon: Image.asset(
                                  'assets/images/figma/signup_lock.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              const SizedBox(height: 25),
                              PrimaryButton(
                                text: 'Create an account',
                                onPressed: _createAccount,
                              ),
                              if (_showEmptyFieldsError) ...[
                                const SizedBox(height: 8),
                                const Text(
                                  'Lütfen boşlukları doldurun.',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Nunito',
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 28),
                              const _OrDivider(),
                              const SizedBox(height: 19),
                              SocialAuthButton(
                                text: 'Sign up with Apple',
                                icon: Image.asset(
                                  'assets/images/figma/social_apple.png',
                                  width: 20,
                                  height: 20,
                                ),
                                onPressed: _openSignIn,
                              ),
                              const SizedBox(height: 12),
                              SocialAuthButton(
                                text: 'Sign up with Google',
                                icon: Image.asset(
                                  'assets/images/figma/social_google.png',
                                  width: 20,
                                  height: 20,
                                ),
                                onPressed: _openSignIn,
                              ),
                              const SizedBox(height: 12),
                              SocialAuthButton(
                                text: 'Sign up with SMS',
                                icon: Image.asset(
                                  'assets/images/figma/social_sms.png',
                                  width: 20,
                                  height: 20,
                                ),
                                onPressed: _openSignIn,
                              ),
                              const SizedBox(height: 37),
                              const Text(
                                'By creating an account you agree to our\n'
                                'Terms of Service and Privacy Policy',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1C1C1C),
                                  fontFamily: 'Nunito',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 52, bottom: 32),
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 20 / 14,
                                color: Color(0xFF263038),
                              ),
                              children: [
                                TextSpan(text: 'Already got an account? '),
                                TextSpan(
                                  text: 'LOGIN',
                                  recognizer: _loginTapRecognizer,
                                  style: TextStyle(
                                    color: Color(0xFF2563EB),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFF3F3F5), height: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              color: Color(0xFFA8ACAF),
              fontFamily: 'Nunito',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(child: Divider(color: Color(0xFFF3F3F5), height: 1)),
      ],
    );
  }
}
