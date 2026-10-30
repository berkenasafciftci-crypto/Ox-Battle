import 'package:flutter/material.dart';

import '../data/favorites_store.dart';
import '../data/vocabulary_catalog.dart';
import '../models/vocabulary_word.dart';
import '../widgets/quiz_option_box.dart';

class CompetitionScreen extends StatefulWidget {
  const CompetitionScreen({super.key, required this.selectedLevel});

  static const routeName = '/competition';

  final String selectedLevel;

  @override
  State<CompetitionScreen> createState() => _CompetitionScreenState();
}

class _CompetitionScreenState extends State<CompetitionScreen> {
  // Placeholder choices remain until the project has a real question source.
  static const _placeholderAnswers = <String>[
    'A)...',
    'B)...',
    'C)...',
    'D)...',
  ];

  var _questionIndex = 0;

  VocabularyWord get _currentWord =>
      VocabularyCatalog.words[_questionIndex % VocabularyCatalog.words.length];

  void _advanceQuestion() {
    setState(() {
      _questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: double.infinity,
              height: 44,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Text(
                    'Competition',
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
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final contentWidth = (constraints.maxWidth - 32).clamp(
                    0.0,
                    271.0,
                  );

                  return SingleChildScrollView(
                    child: Center(
                      child: SizedBox(
                        width: contentWidth,
                        child: Column(
                          children: [
                            const SizedBox(height: 7),
                            const _ScorePanel(),
                            const SizedBox(height: 28),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: _OutlinedPanel(
                                width: 98,
                                height: 34,
                                child: Center(
                                  child: Text(
                                    '01:00',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 177,
                              child: _OutlinedPanel(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 12,
                                    top: 7,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'SORU${_questionIndex + 1}:',
                                          semanticsLabel:
                                              'Question ${_questionIndex + 1} for level ${widget.selectedLevel}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Nunito',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        _currentWord.word,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Nunito',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                        ),
                                      ),
                                      Positioned(
                                        top: -8,
                                        right: -4,
                                        child: AnimatedBuilder(
                                          animation: FavoritesStore.instance,
                                          builder: (context, child) {
                                            final isFavorite = FavoritesStore
                                                .instance
                                                .isFavorite(_currentWord.id);
                                            return IconButton(
                                              tooltip: isFavorite
                                                  ? 'Remove from review'
                                                  : 'Save to review',
                                              onPressed: () => FavoritesStore
                                                  .instance
                                                  .toggle(_currentWord),
                                              icon: Icon(
                                                isFavorite
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: isFavorite
                                                    ? const Color(0xFFE2222E)
                                                    : const Color(0xFFBEC1C4),
                                                size: 22,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 46),
                            for (
                              var index = 0;
                              index < _placeholderAnswers.length;
                              index++
                            ) ...[
                              QuizOptionBox(
                                text: _placeholderAnswers[index],
                                onTap: _advanceQuestion,
                              ),
                              if (index != _placeholderAnswers.length - 1)
                                const SizedBox(height: 10),
                            ],
                          ],
                        ),
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

class _ScorePanel extends StatelessWidget {
  const _ScorePanel();

  @override
  Widget build(BuildContext context) {
    return _OutlinedPanel(
      height: 80,
      child: Stack(
        children: [
          const Positioned(
            left: 18,
            top: 16,
            width: 64,
            child: Text(
              'Player1\nscore',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Nunito',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),
          const Positioned(
            right: 21,
            top: 16,
            width: 64,
            child: Text(
              'Player2\nscore',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Nunito',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/figma/versus.png',
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class _OutlinedPanel extends StatelessWidget {
  const _OutlinedPanel({
    required this.child,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  final Widget child;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDFDEE4), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
