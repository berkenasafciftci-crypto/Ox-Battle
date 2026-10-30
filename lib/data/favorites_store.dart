import 'package:flutter/foundation.dart';

import '../models/vocabulary_word.dart';

class FavoritesStore extends ChangeNotifier {
  FavoritesStore._();

  static final FavoritesStore instance = FavoritesStore._();

  final Map<String, VocabularyWord> _wordsById = {};

  List<VocabularyWord> get words => List.unmodifiable(_wordsById.values);

  bool isFavorite(String wordId) => _wordsById.containsKey(wordId);

  bool toggle(VocabularyWord word) {
    final isNowFavorite = !_wordsById.containsKey(word.id);
    if (isNowFavorite) {
      _wordsById[word.id] = word;
    } else {
      _wordsById.remove(word.id);
    }

    notifyListeners();
    return isNowFavorite;
  }
}
