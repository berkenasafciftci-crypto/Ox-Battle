import 'package:flutter/material.dart';

class StudyProgressCard extends StatelessWidget {
  const StudyProgressCard({super.key, this.progressSize = 136.26});

  final double progressSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = progressSize < constraints.maxWidth * 0.43
            ? progressSize
            : constraints.maxWidth * 0.43;
        final textWidth = (constraints.maxWidth - size - 7).clamp(0.0, 177.0);

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.09),
                blurRadius: 27,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                width: textWidth,
                child: const Center(
                  child: Text(
                    'How many hours you studied this week',
                    style: TextStyle(
                      color: Color(0xFF1C1C1C),
                      fontFamily: 'Nunito',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 5,
                width: size,
                height: size,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/figma/home_progress.png',
                      width: size,
                      height: size,
                      fit: BoxFit.contain,
                    ),
                    const Text(
                      '2h 15m',
                      style: TextStyle(
                        color: Color(0xFF1C1C1C),
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
