import 'package:flutter/material.dart';

import 'level_screen.dart';
import '../widgets/category_card.dart';
import '../widgets/study_progress.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  static const _categories = <({String imagePath, String title})>[
    (imagePath: 'https://picsum.photos/seed/category1/100', title: 'kategori1'),
    (imagePath: 'https://picsum.photos/seed/category2/100', title: 'kategori2'),
    (imagePath: 'https://picsum.photos/seed/category3/100', title: 'kategori3'),
    (imagePath: 'https://picsum.photos/seed/category4/100', title: 'kategori4'),
    (imagePath: 'https://picsum.photos/seed/category5/100', title: 'kategori5'),
    (imagePath: 'https://picsum.photos/seed/category6/100', title: 'kategori6'),
    (imagePath: 'https://picsum.photos/seed/category7/100', title: 'kategori7'),
    (imagePath: 'https://picsum.photos/seed/category8/100', title: 'kategori8'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hi, Sena👋',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                "Let's start learning!",
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 24),
              const SizedBox(
                height: 147,
                child: StudyProgressCard(progressSize: 96),
              ),
              const SizedBox(height: 18),
              const Text(
                'Select category',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                itemCount: _categories.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisExtent: 102,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  void openLevelScreen() {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => const LevelScreen(),
                      ),
                    );
                  }

                  return TextButton(
                    onPressed: openLevelScreen,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: CategoryCard(
                      imagePath: category.imagePath,
                      title: category.title,
                      onTap: openLevelScreen,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
