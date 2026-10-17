import 'package:flutter/material.dart';

import 'widgets/custom_text_field.dart';
import 'widgets/primary_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ox-Battle',
      home: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding =
                  constraints.maxWidth < 368 && constraints.maxWidth > 48
                  ? 24.0
                  : 0.0;
              final contentWidth = constraints.maxWidth - horizontalPadding * 2;

              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 24,
                  ),
                  child: SizedBox(
                    width: contentWidth < 320 ? contentWidth : 320,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CustomTextField(
                          hintText: 'Nickname',
                          prefixIcon: Icon(
                            Icons.person_outline,
                            size: 20,
                            color: Color(0xFF515960),
                          ),
                        ),
                        const SizedBox(height: 16),
                        PrimaryButton(
                          text: 'Create an account',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
