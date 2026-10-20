import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/social_auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                              const SizedBox(height: 40),
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
                              const SizedBox(height: 48),
                              const CustomTextField(
                                hintText: 'Username',
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  size: 20,
                                  color: Color(0xFF515960),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const CustomTextField(
                                hintText: 'Email',
                                prefixIcon: Icon(
                                  Icons.mail_outline,
                                  size: 20,
                                  color: Color(0xFF515960),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const CustomTextField(
                                hintText: 'Password',
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  size: 20,
                                  color: Color(0xFF515960),
                                ),
                              ),
                              const SizedBox(height: 16),
                              PrimaryButton(
                                text: 'Create an account',
                                onPressed: () {},
                              ),
                              const SizedBox(height: 32),
                              const _OrDivider(),
                              const SizedBox(height: 18),
                              SocialAuthButton(
                                text: 'Sign up with Apple',
                                icon: const Icon(Icons.apple, size: 20),
                                onPressed: () {},
                              ),
                              const SizedBox(height: 12),
                              const SocialAuthButton(
                                text: 'Sign up with Google',
                                icon: Icon(
                                  Icons.g_mobiledata,
                                  color: Color(0xFF4285F4),
                                  size: 24,
                                ),
                                onPressed: _noop,
                              ),
                              const SizedBox(height: 12),
                              const SocialAuthButton(
                                text: 'Sign up with SMS',
                                icon: Icon(
                                  Icons.sms,
                                  color: Color(0xFF263038),
                                  size: 20,
                                ),
                                onPressed: _noop,
                              ),
                              const SizedBox(height: 64),
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
                        const Padding(
                          padding: EdgeInsets.only(top: 44, bottom: 32),
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

void _noop() {}
