import 'package:flutter/material.dart';

import '../widgets/category_card.dart';
import '../widgets/study_progress.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key, required this.onOpenLevels});

  final ValueChanged<String> onOpenLevels;

  static const _categories = <({String imagePath, String title})>[
    (imagePath: 'assets/images/figma/home_category_1.jpg', title: 'kategori1'),
    (imagePath: 'assets/images/figma/home_category_2.jpg', title: 'kategori2'),
    (imagePath: 'assets/images/figma/home_category_3.jpg', title: 'kategori3'),
    (imagePath: 'assets/images/figma/home_category_4.jpg', title: 'kategori4'),
    (imagePath: 'assets/images/figma/home_category_1.jpg', title: 'kategori5'),
    (imagePath: 'assets/images/figma/home_category_2.jpg', title: 'kategori6'),
    (imagePath: 'assets/images/figma/home_category_3.jpg', title: 'kategori7'),
    (imagePath: 'assets/images/figma/home_category_4.jpg', title: 'kategori8'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 320),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hi, Sena👋',
                        style: TextStyle(
                          color: Color(0xFF1C1C1C),
                          fontFamily: 'Nunito',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Let’s start learning!',
                        style: TextStyle(
                          color: Color(0xFF1C1C1C),
                          fontFamily: 'Nunito',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const SizedBox(height: 147, child: StudyProgressCard()),
                      const SizedBox(height: 18),
                      const Text(
                        'Select category',
                        style: TextStyle(
                          color: Color(0xFF1C1C1C),
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      LayoutBuilder(
                        builder: (context, gridConstraints) {
                          final spacing = gridConstraints.maxWidth < 320
                              ? 8.0
                              : 16.0;
                          final cardWidth =
                              (gridConstraints.maxWidth - spacing * 3) / 4;

                          return GridView.builder(
                            itemCount: _categories.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisExtent: cardWidth * 102 / 68,
                                  crossAxisSpacing: spacing,
                                  mainAxisSpacing: spacing,
                                ),
                            itemBuilder: (context, index) {
                              final category = _categories[index];
                              return TextButton(
                                onPressed: () => onOpenLevels(category.title),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: CategoryCard(
                                  imagePath: category.imagePath,
                                  title: category.title,
                                  width: cardWidth,
                                ),
                              );
                            },
                          );
                        },
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
}
