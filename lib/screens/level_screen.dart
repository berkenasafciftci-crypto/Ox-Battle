import 'package:flutter/material.dart';

import 'competetion_screen.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key, this.categoryTitle = 'Kategori1'});

  static const routeName = '/level';

  final String categoryTitle;

  static const _levels = <String>['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
  static const _imagePaths = <String, String>{
    'A1': 'assets/images/levels/a1.png',
    'A2': 'assets/images/levels/a2.png',
    'B1': 'assets/images/levels/b1.png',
    'B2': 'assets/images/levels/b2.png',
    'C1': 'assets/images/levels/c1.png',
    'C2': 'assets/images/levels/c2.png',
  };

  @override
  Widget build(BuildContext context) {
    final visibleCategoryTitle = categoryTitle.isEmpty
        ? categoryTitle
        : '${categoryTitle[0].toUpperCase()}${categoryTitle.substring(1)}';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: double.infinity,
              height: 65,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 44,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Text(
                          'Select Level',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF263038),
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                        Positioned(
                          left: 8,
                          child: Semantics(
                            button: true,
                            label: 'Back',
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
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
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 41,
                    right: 27,
                    child: Text(
                      visibleCategoryTitle,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xFF263038),
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final scale = (constraints.maxWidth / 248).clamp(0.0, 1.0);
                  final gridWidth = 248 * scale;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 46),
                        Center(
                          child: SizedBox(
                            width: gridWidth,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 244 * scale,
                                child: GridView.builder(
                                  itemCount: _levels.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 64 * scale,
                                        mainAxisSpacing: 25 * scale,
                                        mainAxisExtent: 130 * scale,
                                      ),
                                  itemBuilder: (context, index) {
                                    final level = _levels[index];
                                    return Center(
                                      child: _LevelCard(
                                        level: level,
                                        imagePath: _imagePaths[level]!,
                                        scale: scale,
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute<void>(
                                              settings: const RouteSettings(
                                                name:
                                                    CompetitionScreen.routeName,
                                              ),
                                              builder: (context) =>
                                                  CompetitionScreen(
                                                    selectedLevel: level,
                                                  ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({
    required this.level,
    required this.imagePath,
    required this.scale,
    required this.onTap,
  });

  final String level;
  final String imagePath;
  final double scale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final imageSize = 90 * scale;

    return Semantics(
      button: true,
      label: 'Select level $level',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10 * scale),
        child: SizedBox(
          width: imageSize,
          height: 130 * scale,
          child: Column(
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * scale),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withValues(alpha: 0.25),
                      blurRadius: 20 * scale,
                      offset: Offset(0, 10 * scale),
                      spreadRadius: -2 * scale,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10 * scale),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 13 * scale),
              SizedBox(
                height: 27 * scale,
                child: Center(
                  child: Text(
                    level,
                    style: TextStyle(
                      color: const Color(0xFF1C1C1C),
                      fontFamily: 'Nunito',
                      fontSize: 12 * scale,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
