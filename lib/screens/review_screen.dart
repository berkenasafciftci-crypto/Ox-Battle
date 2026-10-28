import 'package:flutter/material.dart';

import '../widgets/search_bar_widget.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  static const _savedWords = <Map<String, dynamic>>[
    {'word': 'as many as', 'subtitle': 'as many as'},
    {'word': 'City break', 'subtitle': 'City break'},
    {'word': 'Cosmopolitan', 'subtitle': 'Cosmopolitan'},
    {'word': 'Crowded', 'subtitle': 'Crowded'},
    {'word': 'Embassy', 'subtitle': 'Embassy'},
    {'word': 'Getaway', 'subtitle': 'Getaway'},
    {'word': 'Disappointing', 'subtitle': 'Disappointing'},
    {'word': 'Jaw-dropping', 'subtitle': 'Jaw-dropping'},
    {'word': 'Lively', 'subtitle': 'Lively'},
  ];

  String _searchQuery = '';

  List<Map<String, dynamic>> get _visibleWords {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return _savedWords;
    }

    return _savedWords.where((word) {
      return (word['word'] as String).toLowerCase().contains(query) ||
          (word['subtitle'] as String).toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(
              height: 44,
              child: Center(
                child: Text(
                  'Your saved Words',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    color: Color(0xFF263038),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth < 320
                        ? constraints.maxWidth
                        : 320,
                    child: SearchBarWidget(
                      onChanged: (query) {
                        setState(() {
                          _searchQuery = query;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1, thickness: 1, color: Color(0xFFEAEBEC)),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: _visibleWords.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFEAEBEC),
                ),
                itemBuilder: (context, index) {
                  final word = _visibleWords[index];
                  return SizedBox(
                    height: 66,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  word['word'] as String,
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3,
                                    color: Color(0xFF2E2E2E),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  word['subtitle'] as String,
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    color: Color(0xFF7D8388),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CustomPaint(painter: _WordSignalPainter()),
                          ),
                        ],
                      ),
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

class _WordSignalPainter extends CustomPainter {
  const _WordSignalPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final mutedPaint = Paint()..color = const Color(0xFFBEC1C4);
    final activePaint = Paint()..color = const Color(0xFFE2222E);
    final baseline = size.height - 1;

    canvas.drawRect(Rect.fromLTRB(1, baseline - 6, 4, baseline), activePaint);
    canvas.drawRect(Rect.fromLTRB(6, baseline - 10, 9, baseline), mutedPaint);
    canvas.drawRect(Rect.fromLTRB(11, baseline - 13, 14, baseline), mutedPaint);
  }

  @override
  bool shouldRepaint(covariant _WordSignalPainter oldDelegate) => false;
}
