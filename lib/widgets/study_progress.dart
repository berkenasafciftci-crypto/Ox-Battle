import 'package:flutter/material.dart';

class StudyProgressCard extends StatelessWidget {
  const StudyProgressCard({super.key, this.progressSize = 76});

  final double progressSize;

  static const _blue = Color(0xFF2864EB);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'How many hours you studied this week',
                style: const TextStyle(
                  color: Color(0xFF202124),
                  fontFamily: 'Nunito',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: progressSize,
            height: progressSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const CircularProgressIndicator(
                  value: 0.65,
                  strokeWidth: 6,
                  backgroundColor: Color(0xFFE8EEFC),
                  valueColor: AlwaysStoppedAnimation<Color>(_blue),
                ),
                const Text(
                  '2h 15m',
                  style: TextStyle(
                    color: Color(0xFF202124),
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
