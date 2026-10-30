import 'package:flutter/material.dart';

import '../data/favorites_store.dart';
import '../data/vocabulary_catalog.dart';
import '../models/vocabulary_word.dart';

class DictionaryWordScreen extends StatelessWidget {
  const DictionaryWordScreen({super.key, required this.categoryTitle});

  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    final title = categoryTitle.isEmpty
        ? categoryTitle
        : '${categoryTitle[0].toUpperCase()}${categoryTitle.substring(1)}';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
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
            const Divider(height: 1, color: Color(0xFFEAEBEC)),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: VocabularyCatalog.words.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFEAEBEC),
                ),
                itemBuilder: (context, index) {
                  return _DictionaryWordRow(
                    word: VocabularyCatalog.words[index],
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

class _DictionaryWordRow extends StatelessWidget {
  const _DictionaryWordRow({required this.word});

  final VocabularyWord word;

  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesStore.instance;

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
                    word.word,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                      color: Color(0xFF2E2E2E),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    word.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                      color: Color(0xFF7D8388),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            AnimatedBuilder(
              animation: favorites,
              builder: (context, child) {
                final isFavorite = favorites.isFavorite(word.id);
                return IconButton(
                  tooltip: isFavorite ? 'Remove from review' : 'Save to review',
                  onPressed: () => favorites.toggle(word),
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? const Color(0xFFE2222E)
                        : const Color(0xFFBEC1C4),
                    size: 22,
                  ),
                );
              },
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
