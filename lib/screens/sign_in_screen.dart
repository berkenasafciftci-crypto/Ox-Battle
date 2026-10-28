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
            final contentWidth = (constraints.maxWidth - 40).clamp(0.0, 320.0);

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 44,
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
                              child: InkWell(
                                onTap: () => Navigator.maybePop(context),
                                borderRadius: BorderRadius.circular(50),
                                child: SizedBox(
                                  width: 48,
                                  height: 40,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/figma/back_arrow.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: SizedBox(
                          width: contentWidth,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 58,
                                child: Center(
                                  child: Text(
                                    'Ox-Battle',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF2563EB),
                                      fontFamily: 'Nunito',
                                      fontSize: 28,
                                      fontWeight: FontWeight.w800,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 26),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      hintText: 'Email',
                                      keyboardType: TextInputType.emailAddress,
                                      prefixIcon: Image.asset(
                                        'assets/images/figma/signup_email.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      validator: _requiredFieldValidator,
                                    ),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      hintText: 'Password',
                                      obscureText: true,
                                      prefixIcon: Image.asset(
                                        'assets/images/figma/signup_lock.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      validator: _requiredFieldValidator,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 43),
                              PrimaryButton(
                                text: 'Login',
                                height: 40,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
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
                              const SizedBox(height: 42),
                              SocialAuthButton(
                                text: 'Sign in with Apple',
                                icon: Image.asset(
                                  'assets/images/figma/social_apple.png',
                                  width: 20,
                                  height: 20,
                                ),
                                backgroundColor: const Color(0xFFE3EDFF),
                                onPressed: _noop,
                              ),
                              const SizedBox(height: 12),
                              SocialAuthButton(
                                text: 'Sign in with Google',
                                icon: Image.asset(
                                  'assets/images/figma/social_google.png',
                                  width: 20,
                                  height: 20,
                                ),
                                backgroundColor: const Color(0xFFE3EDFF),
                                onPressed: _noop,
                              ),
                              const SizedBox(height: 12),
                              SocialAuthButton(
                                text: 'Sign in with SMS',
                                icon: Image.asset(
                                  'assets/images/figma/social_sms.png',
                                  width: 20,
                                  height: 20,
                                ),
                                backgroundColor: const Color(0xFFE3EDFF),
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
              color: Color(0xFFBEC1C4),
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
