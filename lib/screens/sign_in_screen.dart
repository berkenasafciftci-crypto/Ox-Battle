import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/social_auth_button.dart';
import 'main_layout_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 48,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Text(
                              'Sign in',
                              style: TextStyle(
                                color: Color(0xFF263038),
                                fontFamily: 'Nunito',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () => Navigator.maybePop(context),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 40,
                                  minHeight: 40,
                                ),
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Color(0xFF263038),
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 36),
                      Center(
                        child: SizedBox(
                          width: 320,
                          child: Column(
                            children: [
                              const Text(
                                'Ox-Battle',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF2864EB),
                                  fontFamily: 'Nunito',
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 36),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      hintText: 'Email',
                                      keyboardType: TextInputType.emailAddress,
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        size: 18,
                                        color: Color(0xFF515960),
                                      ),
                                      validator: _requiredFieldValidator,
                                    ),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      hintText: 'Password',
                                      obscureText: true,
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        size: 20,
                                        color: Color(0xFF515960),
                                      ),
                                      validator: _requiredFieldValidator,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              PrimaryButton(
                                text: 'Login',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MainLayoutScreen(),
                                      ),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 44),
                              const _OrDivider(),
                              const SizedBox(height: 24),
                              SocialAuthButton(
                                text: 'Sign in with Apple',
                                icon: const Icon(Icons.apple, size: 20),
                                onPressed: _noop,
                              ),
                              const SizedBox(height: 12),
                              const SocialAuthButton(
                                text: 'Sign in with Google',
                                icon: Icon(
                                  Icons.g_mobiledata,
                                  color: Color(0xFF4285F4),
                                  size: 24,
                                ),
                                onPressed: _noop,
                              ),
                              const SizedBox(height: 12),
                              const SocialAuthButton(
                                text: 'Sign in with SMS',
                                icon: Icon(
                                  Icons.sms,
                                  color: Color(0xFF263038),
                                  size: 20,
                                ),
                                onPressed: _noop,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String? _requiredFieldValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Lütfen boşluklari doldurunuz';
    }
    return null;
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
