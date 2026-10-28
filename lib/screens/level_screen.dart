import 'package:flutter/material.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Levels')),
      body: const Center(child: Text('Bu ekran birazdan tasarlanacak')),
    );
  }
}
